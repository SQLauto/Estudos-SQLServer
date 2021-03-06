USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_diminui_log]    Script Date: 12/17/2012 16:24:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_diminui_log] 
AS
BEGIN
  DECLARE @name_backup VARCHAR (255)
  DECLARE @name_backup_anterior VARCHAR (255)
  DECLARE @name_backup_log VARCHAR (255)
  DECLARE @cmd_text VARCHAR (1000)
  DECLARE @namedatabase VARCHAR (255)
  DECLARE @comando VARCHAR (1000)
  DECLARE @LogicalNameData nVARCHAR(128)
  DECLARE @LogicalNameLog nVARCHAR(128) 
  DECLARE @error_message VARCHAR (8000)
  DECLARE @to VARCHAR (8000)
  DECLARE @from VARCHAR (8000)
  DECLARE @assunto VARCHAR (8000)
  DECLARE @ctrl_cursor SMALLINT
  SET @error_message = ''
  SET @to = 'dba@localcred.com.br'
  SET @from = 'dba@localcred.com.br'
  SET @assunto = ''

  SET @ctrl_cursor = 0

  DECLARE c_databases CURSOR LOCAL FOR SELECT name   
                                       FROM [192.168.0.14].MASTER.dbo.sysdatabases 
                                       WHERE DBID > 6 and name not in (
'AUDIT'
,'DBA_BASE'
,'distribution')
                                       ORDER BY 1

  OPEN c_databases FETCH NEXT FROM c_databases INTO @namedatabase

  WHILE @@fetch_status = 0
  BEGIN 

  BEGIN TRY

-- Diminui o LOG

  SET @comando = ' alter database '+ @namedatabase +'  SET RECOVERY Simple 
  
  use '+ @namedatabase + 
           ' declare @name_ldf VARCHAR (255)
             declare @comando2 VARCHAR (8000)

             select @name_ldf = rtrim(name) from sysfiles where fileid = 2
             
             set @comando2 = ''dbcc shrinkfile ('''''' + @name_ldf + '''''',5120)''
             exec (@comando2)             
             
             alter database '+ @namedatabase +'  SET RECOVERY FULL 
           '            

  EXEC (@comando)

  END TRY
  BEGIN CATCH

    SELECT @error_message = 'Erro na  replicação da base: ' + @namedatabase + '  
    - erro msg ' + error_message()
    SELECT @assunto ='Erro na  replicação da base: ' + @namedatabase
    EXEC MASTER.dbo.sp_SQLNotify 
         @to,
         @from,
         @assunto,
         @error_message

  END CATCH

    FETCH NEXT FROM c_databases INTO @namedatabase
  END
  CLOSE c_databases
  DEALLOCATE c_databases
END
