USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_replica_bases_por_base]    Script Date: 12/17/2012 16:26:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_replica_bases_por_base] ( @namedatabase varchar (255))
as
begin
  declare @name_backup varchar (255)
  declare @name_backup_anterior varchar (255)
  declare @name_backup_log varchar (255)
  declare @cmd_text varchar (1000)
 
  declare @comando varchar (1000)
  declare @LogicalNameData nvarchar(128)
  declare @LogicalNameLog nvarchar(128) 
  declare @error_message varchar (8000)
  declare @to varchar (8000)
  declare @from varchar (8000)
  declare @assunto varchar (8000)
  declare @ctrl_cursor smallint

  create table #Restore (
    LogicalName nvarchar(128),
    PhysicalName nvarchar(260), 
    Type char(1), 
    FileGroupName nvarchar(128), 
    SizeB numeric(20, 0), 
    MaxSizeB numeric(20, 0), 
    fileid bigint, 
    createlsn bigint, 
    droplsn bigint, 
    Uniqueld uniqueidentifier, 
    ReadOnlyLsn bigint,  
    ReadWriteLsn bigint, 
    BackupSizeInBytes bigint, 
    SourceBlockSize bigint, 
    FileGroupID bigint, 
    LOGgRUPgUid uniqueidentifier, 
    DiferentialBasseLsn varchar(100), 
    DiferentialBasseGuid varchar(100), 
    IsReadOnly bigint, 
    IsPresent bigint,
    TDEThumbprint varchar(max))

  set @error_message = ''
  set @to = 'dba@localcred.com.br'
  set @from = 'dba@localcred.com.br'
  set @assunto = ''

  set @ctrl_cursor = 0

  begin

  begin try

-- Exclui Backup dia anterior

    select @name_backup_anterior = @namedatabase + '_backup*.bak'
    select @cmd_text = 'del G:\CopiasBDReplicados\' + @name_backup_anterior
    exec xp_cmdshell @cmd_text

-- Copia os Backups do servidor e cria pastas

    select @name_backup = @namedatabase + '_backup_*.bak'
    select @cmd_text = 'xcopy \\192.168.0.14\G$\backups\'+@namedatabase +'\'+@name_backup+ ' G:\CopiasBDReplicados'
    exec xp_cmdshell @cmd_text
    select @cmd_text = 'md F:\SQL_LOG\DB_'+@namedatabase +'_LOG'
    exec xp_cmdshell @cmd_text
    select @cmd_text = 'md E:\SQL_DATA\DB_'+@namedatabase
    exec xp_cmdshell @cmd_text

-- Renomeia arquivo de backup

    select @cmd_text = 'rename G:\CopiasBDReplicados\'+ @name_backup + ' ' +  @namedatabase + '_backup.bak'
    exec xp_cmdshell @cmd_text
    select @name_backup = @namedatabase + '_backup.bak'

-- Copia os Backups de log

    select @name_backup_log = @namedatabase + '_backup_' + convert(varchar(8),dateadd(dd,-1,getdate()),112) + '*.trn'
    select @cmd_text = 'xcopy \\192.168.0.14\G$\backups\'+@namedatabase +'\'+@name_backup_log+ ' G:\CopiasBDReplicados\BACKUP_LOG'
    exec xp_cmdshell @cmd_text

-- Mata os Processos do Banco a ser restaurado

    declare c_kill_processes cursor local for select 'kill ' + convert(varchar(10),spid) 
                                              from sysprocesses 
                                              where dbid = (select dbid from sysdatabases where name = @namedatabase)
    
    open c_kill_processes fetch next from c_kill_processes into @comando
    
    while @@fetch_status = 0
    begin
      set @ctrl_cursor = 1
      exec (@comando)
      fetch next from c_kill_processes into @comando
    end
    close c_kill_processes
    deallocate c_kill_processes
    
    set @ctrl_cursor = 0

-- Realiza a restauração da base

    insert into #Restore exec('restore filelistonly from disk = ''G:\CopiasBDReplicados\'+@name_backup+'''') 
    select @LogicalNameData = LogicalName from #Restore where Type = 'D' 
    select @LogicalNameLog = LogicalName from #Restore where Type = 'L' 

    select @comando = '
    restore database '+ @namedatabase + ' from disk = N''G:\CopiasBDReplicados\'+@name_backup+''' 
    with file = 1, 
    move ''' + @LogicalNameData + ''' to N''E:\SQL_DATA\DB_'+@namedatabase+'\'+@namedatabase+'_DAT.mdf'',
    move ''' + @LogicalNameLog + ''' to N''F:\SQL_LOG\DB_'+@namedatabase+'_LOG\'+@namedatabase+'_LOG.ldf'',
    KEEP_REPLICATION, nounload, replace, stats = 10'

    exec (@comando)


-- Elimina Logins Orfãos
    select @comando = 'use ' + @namedatabase + '

    declare @comando varchar (1000)

    declare c_map_login cursor local for select ''sp_change_users_login ''''Update_One'''',''''''+ su.name + '''''',''''''+ su.name + '''''''' 
    from
    sys.sysusers su 
    inner join master..syslogins sl on su.name = sl.name collate SQL_Latin1_General_CP1_CI_AS
    where su.uid > 4 and su.uid < 1000 and su.issqluser = 1
    
    open c_map_login fetch next from c_map_login into @comando

    while @@fetch_status = 0
    begin
      exec (@comando)
      fetch next from c_map_login into @comando
    end
    close c_map_login
    deallocate c_map_login'
    exec (@comando)


-- Diminui o LOG

  set @comando = ' alter database '+ @namedatabase +'  SET RECOVERY SIMPLE 
  
  use '+ @namedatabase + 
           ' declare @name_ldf varchar (255)
             declare @comando2 varchar (8000)

             select @name_ldf = rtrim(name) from sysfiles where fileid = 2
             
             set @comando2 = ''dbcc shrinkfile ('''''' + @name_ldf + '''''',5120)''
             exec (@comando2)
           '            

  exec (@comando)

  end try
  begin catch

    select @error_message = 'Erro na  replicação da base: ' + @namedatabase + '  
    - erro msg ' + error_message()
    select @assunto ='Erro na  replicação da base: ' + @namedatabase
    exec master.dbo.sp_SQLNotify 
         @to,
         @from,
         @assunto,
         @error_message

    if @ctrl_cursor = 1
    begin
      close c_kill_processes
      deallocate c_kill_processes
    end
  end catch

  end
end
