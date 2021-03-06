USE [master]
GO
/****** Object:  StoredProcedure [dbo].[mssql_backup]    Script Date: 22/04/2015 16:18:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec mssql_backup 'C:\Backup\','FULL','nocompress',2,'d','init','GerenciadorInnerRep'

ALTER procedure [dbo].[mssql_backup] 
		@path varchar(2000) ,--= 'C:\bkp\', --path que sera gravado
		@typebackup varchar(30),-- = 'diff', --tipo de backup FULL/DIFF/LOG
		@compress varchar(11),-- = 'nocompress', --comprimido (compression) ou nao comprimido (no_compression)
		@retention tinyint,-- = 2, --dias de retencao, caso nao tenha retencao coloque valor 0
		@type_name varchar(2),-- = 'dh', --data do label do backup (DH = YYYYMMDD_HH24MI / D = YYYYMMDD)
		@with_init varchar(6),-- = 'noinit', --sobrescrever (init) ou nao sobrescrever (noinit)
		@db varchar(2000) -- = nome da base de dados, caso queira todas use somente ''
as
/****************************************************************************************************************************/
/*Nome: backup_mssql.sql																									*/
/*MSSQL versoes: 2005,2008,2012																								*/
/*Criador: Andre Nakazima data: ??/08/2013																					*/
/*Modificado por: Igor Eduardo Savatin Carvalho data: 22/04/2015															*/
/*Requerimentos: parametro xp_cmdshell habilitado e user do servico MSSQL com permissao de escrita no diretorio.			*/
/*Habilitar o paremetro xp_cmdshell:																						*/
/*	Exec sp_configure -- se estiver entre 16 ou 20 as opcoes avançadas estao bloqueadas										*/
/*	Exec sp_configure 'show advanced options',1 -- execute esse comando para habilitar as opcoes avancadas					*/
/*	reconfigure																												*/
/*	Exec sp_configure 'xp_cmdshell',1 -- habilitando o xp_cmdshell															*/
/*	reconfigure																												*/
/****************************************************************************************************************************/
declare
	@data_retention varchar(8), --data de delete (depende da variavel retention)
	@type char(8), --tipo de bkp log ou dados
	@databasename varchar(300), --nomes da base de dados na variavel em cada fetch
	@backupsql varchar(8000), --comando de backup
	@data varchar(20), --data do label do backup
	@md VARCHAR (4000), --populando variavel com comando de criacao das tabelas com o nome das bases
	@cmd VARCHAR (4000), --criando delete dos backups por tempo de retencao
	@extention_bkp varchar(4), --extencao: log = .trn/ full ou diff = .bak
	@typecompression varchar(14), --comprimido (compression) ou nao comprimido (no_compression)
	@typeinit varchar(10), --sobrescrever (init) ou nao sobrescrever (noinit)
	@typediff varchar(15), --se sera diferencial ou nao;
	@path_new varchar(500); --acertanto a path para colocar o nome do server
DECLARE database_cursor cursor for
	SELECT	d.name 
	FROM	master..sysdatabases d 
	WHERE d.name NOT IN ('tempdb') 
	and rtrim(ltrim(upper(d.name))) in (case when rtrim(ltrim(@db)) ='' then d.name else @db end)

	and status NOT IN (128,512,4096,32768);
	-- 128 = recovering
	-- 512 = offline
	-- 4096 = single user
	-- 32768 = emergency mode
open	database_cursor
fetch next from database_cursor
into @databasename --colocando os nomes da base de dados na variavel em cada fetch
	Exec sp_configure 'show advanced options',1;
	reconfigure;
	Exec sp_configure 'xp_cmdshell',1;
	reconfigure;
WHILE
	@@fetch_status = 0
BEGIN
	set @path_new = case when substring(@path,len(@path),1) = '\' then substring(@path,1,len(@path)-1) end + '\'+ replace(@@SERVERNAME,'\','_')+'\';
	set @data_retention = REPLACE((CONVERT(VARCHAR,(SELECT GETDATE()-(@retention)),112)),'-','');	--prepara a data de delete (depende da variavel retention)
	SET @data = convert(varchar(20),getdate(),112) +
		case when upper(ltrim(rtrim(@type_name))) = 'DH' 
		THEN '_' + case when len(convert(varchar(2),datepart(hh,getdate())))=1 then '0'+convert(varchar(2),datepart(hh,getdate())) else convert(varchar(2),datepart(hh,getdate())) end
				+ case when len(convert(varchar(2),datepart(mi,getdate())))=1 then '0'+convert(varchar(2),datepart(mi,getdate())) else convert(varchar(2),datepart(mi,getdate())) end
		ELSE ''
		end; --data do label do backup (DH = YYYYMMDD_HH24MI / D = YYYYMMDD)
	set @type = case when upper(rtrim(ltrim(@typebackup))) = 'LOG' then 'log' when upper(rtrim(ltrim(@typebackup))) in ('FULL','DIFF') then 'database' end; --tipo de bkp log ou dados
	set @extention_bkp = '.' + case when upper(rtrim(ltrim(@typebackup))) = 'LOG' then 'trn' when upper(rtrim(ltrim(@typebackup))) in ('FULL','DIFF') then 'bak' end; --extencao: log = .trn/ full ou diff = .bak
	set @typecompression = case when upper(rtrim(ltrim(@compress))) = 'COMPRESS' then 'compression,' else '' end; --comprimido (compression) ou nao comprimido (no_compression)
	set @typeinit = case when upper(rtrim(ltrim(@with_init))) = 'INIT' and upper(rtrim(ltrim(@typebackup))) != 'LOG' then ' init' else ' noinit' end; --sobrescrever (init) ou nao sobrescrever (noinit)
	set @typediff = case when upper(rtrim(ltrim(@typebackup))) = 'DIFF' then ', differential' else '' end; --se sera diferencial ou nao
	IF (SELECT CONVERT(VARCHAR (10),DATABASEPROPERTYEX(@databasename,'Status'))) = 'ONLINE' --checagem se a base de dados esta online
	BEGIN
		set @md = 'IF NOT EXIST "' + @path_new + @databasename +'\'+@typebackup+'\" md "'+@path_new + @databasename+'\'+rtrim(ltrim(@typebackup))+'\"'; --populando variavel com comando de criacao das tabelas com o nome das bases
		set @backupsql = 'backup ' + @type + ' ' + @databasename + ' to disk = N''' + @path_new + @databasename + '\'+rtrim(ltrim(upper(@typebackup)))+'\BK' + rtrim(ltrim(upper(@typebackup))) + '_' 
						+ @databasename + '_' + @data + @extention_bkp + ''' with '	+ @typecompression + @typeinit + @typediff;	--comando de backup
		--set @cmd = case when @retention = 0 then '' else 'del '+ @path_new + @databasename +'\'+@typebackup+ '\BK'+ upper(rtrim(ltrim(@typebackup))) + '_*'+ @data_retention + '*' + @extention_bkp end; --criando delete dos backups por tempo de retencao
		set @cmd = case when @retention = 0 then '' else 'forfiles -p  '+ @path_new + @databasename +'\'+@typebackup+ '\ /d -1 /c "cmd /c del @path"' end; --criando delete dos backups por tempo de retencao
		/*executando os comandos mas com as regras de bkp log e full*/
		if upper(rtrim(ltrim(@typebackup))) = 'LOG'
			or ( select cast( databasepropertyex(@databasename,'recovery') as varchar(15) ) ) = 'FULL' --se foi escolhido tipo de bkp log e se a base esta com modo de recuperacao full
			or upper(rtrim(ltrim(@typebackup))) = ('FULL') --se voce escolhe o tipo full
			or upper(rtrim(ltrim(@typebackup))) in ('DIFF') and upper(rtrim(ltrim(@databasename))) != 'MASTER'--se voce escolhe tipo diferencial, o banco master só faz backup full
		begin
			/*print @md;
			print (@backupsql);
			print @cmd;*/
			exec xp_cmdshell @md;
			exec (@backupsql);
			exec xp_cmdshell @cmd;
		end
	end;

fetch next from database_cursor
into @databasename
END
	Exec sp_configure 'xp_cmdshell',0;
	reconfigure;
	Exec sp_configure 'show advanced options',0;
	reconfigure;
close	database_cursor
deallocate	database_cursor