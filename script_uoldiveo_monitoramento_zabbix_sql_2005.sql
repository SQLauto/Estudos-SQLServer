use [master]
go

if (select count(*) from sys.databases where name = N'uoldiveodb')=0 and (select count(*) from sys.databases where name = N't4bdb01')>0


  begin

     declare @filedata varchar(1000)
            ,@filelog  varchar(1000)
            ,@sql      varchar(8000)
      
     set @filedata=(select left([filename],charindex('t4bdb01',[filename])-1) as filedata from t4bdb01.dbo.sysfiles
                where fileid=1)

     set @filelog=(select left([filename],charindex('t4bdb01',[filename])-1)as filelog from t4bdb01.dbo.sysfiles
                where fileid=2)

     set @sql =       

       'create database [uoldiveodb] on primary 
       (name = ''uoldiveodb'', filename = ''' + @filedata + 'uoldiveodb.mdf'' , size = 100mb , maxsize = 5gb, filegrowth = 1024mb)
        log on 
       (name = ''uoldiveodb_log'', filename = ''' + @filelog + 'uoldiveodb_log.ldf'' , size = 100mb , maxsize = 5gb , filegrowth = 1024mb)'

      exec(@sql)
      -- print @sql
     
     alter database [uoldiveodb] set recovery simple 

    end

if (select count(*) from sys.databases where name = N'uoldiveodb')>0

  begin
  
  print 'A base de dados de administração já existe no ambiente do cliente!'
  
  end

    else
    
       begin

          set @filedata=(select left([filename],charindex('master',[filename])-1) as filedata from master.dbo.sysfiles
                         where fileid=1)

          set @filelog=(select left([filename],charindex('mast',[filename])-1)as filelog from master.dbo.sysfiles
                         where fileid=2)

     set @sql =       

       'create database [uoldiveodb] on primary 
       (name = ''uoldiveodb'', filename = ''' + @filedata + 'uoldiveodb.mdf'' , size = 100mb , maxsize = 5gb, filegrowth = 1024mb)
        log on 
       (name = ''uoldiveodb_log'', filename = ''' + @filelog + 'uoldiveodb_log.ldf'' , size = 100mb , maxsize = 5gb , filegrowth = 1024mb)'

      exec(@sql)
      --print @sql
      
       alter database [uoldiveodb] set recovery simple 

   end
   
GO

USE [uoldiveodb]

GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_estado_verifica_status_base_dados]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_estado_verifica_status_base_dados]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_estado_verifica_status_base_dados]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_sessao_verifica_deadlocks]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_sessao_verifica_deadlocks]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_sessao_verifica_deadlocks]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_uso_consumo_log]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_uso_consumo_log]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_uso_consumo_log]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_uso_espaco_livre_dados]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_uso_espaco_livre_dados]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_uso_espaco_livre_dados]
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_input_buffer]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_input_buffer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_input_buffer]
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_pega_espaco_livre_dados]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_pega_espaco_livre_dados]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_pega_espaco_livre_dados]
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_sp_who3]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_sp_who3]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_sp_who3]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_average_lock_wait_time_ms]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_average_lock_wait_time_ms]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_average_lock_wait_time_ms]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_batch_requests_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_batch_requests_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_batch_requests_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_full_scans_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_full_scans_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_full_scans_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_lazy_writes_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_lazy_writes_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_lazy_writes_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_longest_transaction_running_time]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_longest_transaction_running_time]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_longest_transaction_running_time]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_memory_grants_pending]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_memory_grants_pending]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_memory_grants_pending]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_page_life_expectancy]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_page_life_expectancy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_page_life_expectancy]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_sql_compilations_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_sql_compilations_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_sql_compilations_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_sql_recompilations_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_sql_recompilations_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_sql_recompilations_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_target_server_memory_kb]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_target_server_memory_kb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_target_server_memory_kb]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_total_server_memory_kb]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_total_server_memory_kb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_total_server_memory_kb]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_transactions_sec]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_transactions_sec]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_transactions_sec]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_user_connections]    Script Date: 05/08/2013 23:10:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_user_connections]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_zabbix_contador_user_connections]
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_user_connections]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_user_connections]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[usp_zabbix_contador_user_connections]
as

select 
	cntr_value as Valor
from 
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':General Statistics'' and 
	counter_name = ''User Connections''




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_transactions_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_transactions_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create proc [dbo].[usp_zabbix_contador_transactions_sec]
as

declare @time1 datetime
       ,@time2 datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Databases'' and 
	counter_name = ''Transactions/sec'' AND 
	instance_name = ''_Total'';
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Databases'' and 
	counter_name = ''Transactions/sec'' AND 
	instance_name = ''_Total'';

-- calcula transações por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Transactions/sec];
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_total_server_memory_kb]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_total_server_memory_kb]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[usp_zabbix_contador_total_server_memory_kb]
as

select 
	cntr_value as Valor
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Memory Manager'' and 
	counter_name = ''Total Server Memory (KB)''



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_target_server_memory_kb]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_target_server_memory_kb]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[usp_zabbix_contador_target_server_memory_kb]
as

select 
	cntr_value as Valor
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Memory Manager'' and 
	counter_name = ''Target Server Memory (KB)''

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_sql_recompilations_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_sql_recompilations_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create proc [dbo].[usp_zabbix_contador_sql_recompilations_sec]
as

declare @time1 datetime
       ,@time2 datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' and 
	counter_name = ''SQL Re-Compilations/sec''
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' and 
	counter_name = ''SQL Re-Compilations/sec''

-- calcula páginas lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [SQL Re-Compilations/sec];





' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_sql_compilations_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_sql_compilations_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create proc [dbo].[usp_zabbix_contador_sql_compilations_sec]
as

declare @time1 datetime
       ,@time2 datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' and 
	counter_name = ''SQL Compilations/sec''
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' and 
	counter_name = ''SQL Compilations/sec''

-- calcula páginas lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [SQL Compilations/sec];




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_page_life_expectancy]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_page_life_expectancy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[usp_zabbix_contador_page_life_expectancy]
as

select 
	cntr_value as Valor
from
	master.sys.dm_os_performance_counters
where 
	 object_name = left([object_name],charindex('':'',[object_name])-1)+'':Buffer Manager'' and 
	 counter_name = ''Page Life Expectancy''





' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_memory_grants_pending]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_memory_grants_pending]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[usp_zabbix_contador_memory_grants_pending]
as

select 
	cntr_value as Valor
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Memory Manager'' and 
	counter_name = ''Memory Grants Pending''



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_longest_transaction_running_time]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_longest_transaction_running_time]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[usp_zabbix_contador_longest_transaction_running_time]
as

select 
	          cntr_value as Valor
              from
	          master.sys.dm_os_performance_counters
              where object_name = left([object_name],charindex('':'',[object_name])-1)+'':Transactions'' and 
	          counter_name = ''Longest Transaction Running Time''



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_lazy_writes_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_lazy_writes_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create proc [dbo].[usp_zabbix_contador_lazy_writes_sec]
as
declare @time1 datetime
       ,@time2 datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Buffer Manager'' and 
	counter_name = ''Lazy writes/sec'';
	

-- aguarda por 5 seconds
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Buffer Manager'' and 
	counter_name = ''Lazy writes/sec'';

-- calcula páginas lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Lazy writes/sec];



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_full_scans_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_full_scans_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create proc [dbo].[usp_zabbix_contador_full_scans_sec]
as
declare @time1  datetime
       ,@time2  datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Access Methods'' and 
	counter_name = ''Full Scans/sec'';
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Access Methods'' and 
	counter_name = ''Full Scans/sec'';

-- calcula páginas lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Full Scans/sec];




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create procedure [dbo].[usp_zabbix_contador_buffer_cache_hit_ratio]
as

select 
	convert(decimal(15,2), 100.0 * t.CacheHitRatio / t.CacheHitRatioBase)
from 
	(
		select
		(
			select 
				cntr_value as ''CacheHitRatio'' 
			from 
				master.sys.dm_os_performance_counters
			where 
				object_name = left([object_name],charindex('':'',[object_name])-1)+'':Buffer Manager'' and 
				counter_name = ''Buffer cache hit ratio'' 
		) as ''CacheHitRatio'',  
		(
			select 
				cntr_value AS ''CacheHitRatioBase'' 
			from 
				master.sys.dm_os_performance_counters
			where 
				object_name = left([object_name],charindex('':'',[object_name])-1)+'':Buffer Manager'' and 
				counter_name = ''Buffer cache hit ratio base'' 
		) as ''CacheHitRatioBase''
	) as t




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_batch_requests_sec]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_batch_requests_sec]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create proc [dbo].[usp_zabbix_contador_batch_requests_sec]
as
declare @time1  datetime
       ,@time2  datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' AND 
	counter_name = ''Batch Requests/sec'';
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':SQL Statistics'' AND 
	counter_name = ''Batch Requests/sec'';

-- calcula páginas lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Batch Requests/sec];



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_contador_average_lock_wait_time_ms]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_contador_average_lock_wait_time_ms]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

create proc [dbo].[usp_zabbix_contador_average_lock_wait_time_ms]
as
declare @time1  datetime
       ,@time2  datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Locks'' AND 
	counter_name = ''Average Wait Time (ms)'' AND 
	instance_name = ''_Total'';
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Locks'' AND 
	counter_name = ''Average Wait Time (ms)'' AND 
	instance_name = ''_Total'';

-- realiza o cálculo págins lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Average Wait Time (ms)];




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create procedure [dbo].[usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas]
as

declare @cmaster varchar(100),
        @sql     varchar(max)

set @cmaster = convert(varchar(100),(select databasepropertyex(''master'', ''Collation'')))

set @sql=''if not exists(select  *
		      from  
			 (select d.name      
              from 
              master.sys.databases as d 
              where d.name not in(''''tempdb'''',''''msdb'''',''''master'''',''''model'''',''''Northwind'''',''''pubs'''')
              and   d.state_desc = ''''ONLINE''''
              and   d.is_read_only<>1
              and   d.is_in_standby<>1
              and   d.recovery_model_desc=''''FULL''''
              and   d.name not in(select distinct database_name collate '' + @cmaster + '' from msdb.dbo.backupset where [type]=''''L''''
                                  and backup_start_date between dateadd(hh, -6, getdate()) and getdate()))consulta)

select 0 as Valor ---Não existem bases de dados sem backup de log e com modelo de recuperação FULL
else 
select 1 as Valor ---Existem bases de dados sem backup de log e com modelo de recuperação FULL''

exec (@sql)




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_sp_who3]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_sp_who3]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[usp_uoldiveo_sp_who3]
AS BEGIN

	DECLARE @SESSAO INT
	DECLARE @LOCK INT
	DECLARE @QTD INT
	DECLARE @CMD VARCHAR(2000)
	DECLARE @SPID INT
	DECLARE @SQL_HANDLE BINARY(20)
	
	DECLARE CUR_REIN CURSOR FOR
	
	SELECT DISTINCT BLOCKED FROM MASTER..SYSPROCESSES WHERE BLOCKED > 0
	
	OPEN CUR_REIN
		FETCH CUR_REIN INTO @SESSAO
		WHILE @@FETCH_STATUS = 0 BEGIN
			IF ((SELECT COUNT(SPID) FROM MASTER..SYSPROCESSES WHERE BLOCKED = 0 AND SPID = @SESSAO AND SPID != BLOCKED) > 0) BEGIN
				
				SET @LOCK = @SESSAO
			END
			FETCH CUR_REIN INTO @SESSAO
		END
	CLOSE CUR_REIN
	DEALLOCATE CUR_REIN
	
	IF (@LOCK > 0) BEGIN
		SET @QTD = (SELECT COUNT(DISTINCT SPID) 
						FROM MASTER..SYSPROCESSES 
						WHERE BLOCKED > 0 AND SPID != @LOCK)
		
		IF (@QTD != 0) BEGIN
			
			SET @CMD = (SELECT TOP(1) QT.TEXT 
			FROM SYS.DM_EXEC_REQUESTS ER INNER JOIN SYS.SYSPROCESSES SP 
			ON ER.SESSION_ID = SP.SPID CROSS APPLY SYS.DM_EXEC_SQL_TEXT(ER.SQL_HANDLE)AS QT 
			WHERE SESSION_ID = @LOCK 
			AND SESSION_ID NOT IN (@@SPID))
			
						
			IF ISNULL(@CMD,'''') = '''' BEGIN
				
				SELECT @SQL_HANDLE = SQL_HANDLE FROM MASTER.DBO.SYSPROCESSES
				WHERE SPID = @LOCK

				SELECT @CMD = TEXT FROM ::FN_GET_SQL(@SQL_HANDLE)								
			
			END
			
			SELECT DISTINCT BLOQUEANDO = ''BLOQUEANDO'', BLOQUEIOS = @QTD, SPID SPID, STATUS STATUS, LOGINAME LOGIN, HOSTNAME MAQUINA, 
			PROGRAM_NAME PROGRAMA, CMD COMMAND, CPU CPU, PHYSICAL_IO DISK, LAST_BATCH LASTBATCH, SQL_TEXT = @CMD
			FROM MASTER..SYSPROCESSES
			WHERE SPID = @LOCK AND BLOCKED = 0
		
		END
	END	
	
	SELECT DISTINCT
	SPID SPID, BLOCKED BLKBY, STATUS STATUS, LOGINAME LOGIN, HOSTNAME MAQUINA, PROGRAM_NAME PROGRAMA, CMD COMMAND, CPU CPU, PHYSICAL_IO DISK, 
	LAST_BATCH LASTBATCH
	INTO #PROCESSOS
	FROM MASTER..SYSPROCESSES
	WHERE (CMD != ''AWAITING COMMAND'' AND HOSTNAME != '''' AND SPID NOT IN (@@SPID))
	ORDER BY PHYSICAL_IO DESC
	
	ALTER TABLE #PROCESSOS ADD SQL_TEXT VARCHAR(2000)
	
	DECLARE CUR_REIN2 CURSOR FOR
	SELECT DISTINCT SPID FROM #PROCESSOS
	
	OPEN CUR_REIN2
		FETCH CUR_REIN2 INTO @SPID
		WHILE @@FETCH_STATUS = 0 BEGIN
			
			SET @CMD = (SELECT TOP(1) QT.TEXT 
			FROM SYS.DM_EXEC_REQUESTS ER INNER JOIN SYS.SYSPROCESSES SP 
			ON ER.SESSION_ID = SP.SPID CROSS APPLY SYS.DM_EXEC_SQL_TEXT(ER.SQL_HANDLE)AS QT 
			WHERE SESSION_ID = @SPID 
			AND SESSION_ID NOT IN (@@SPID) )
			
			IF ISNULL(@CMD,'''') = '''' BEGIN
				
				SELECT @SQL_HANDLE = SQL_HANDLE FROM MASTER.DBO.SYSPROCESSES
				WHERE SPID = @SPID

				SELECT @CMD = TEXT FROM ::FN_GET_SQL(@SQL_HANDLE)
			
			END
			
			UPDATE #PROCESSOS SET SQL_TEXT = @CMD 
			WHERE SPID = @SPID
			
			FETCH CUR_REIN2 INTO @SPID
		END
	CLOSE CUR_REIN2
	DEALLOCATE CUR_REIN2
			
	IF (@LOCK > 0 AND @QTD != 0)
		SELECT SPID, STATUS, LOGIN, MAQUINA, PROGRAMA, BLKBY, COMMAND, CPU, DISK, LASTBATCH, SQL_TEXT FROM #PROCESSOS
	ELSE
		SELECT SPID, STATUS, LOGIN, MAQUINA, PROGRAMA, COMMAND, CPU, DISK, LASTBATCH, SQL_TEXT FROM #PROCESSOS
	DROP TABLE #PROCESSOS

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_pega_espaco_livre_dados]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_pega_espaco_livre_dados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE procedure [dbo].[usp_uoldiveo_pega_espaco_livre_dados]
as
DECLARE @DBInfo TABLE  
( ServerName VARCHAR(100),  
DatabaseName VARCHAR(100),  
FileSizeMB INT,  
LogicalFileName sysname,  
PhysicalFileName NVARCHAR(520),  
Status sysname,  
Updateability sysname,  
RecoveryMode sysname,  
FreeSpaceMB INT,  
FreeSpacePct VARCHAR(7),  
FreeSpacePages INT,  
PollDate datetime)  

DECLARE @command VARCHAR(5000)  

SELECT @command = ''Use ['' + ''?'' + ''] SELECT  
@@servername as ServerName,  
'' + '''''''' + ''?'' + '''''''' + '' AS DatabaseName,  
CAST(sysfiles.size/128.0 AS int) AS FileSize,  
sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName,  
CONVERT(sysname,DatabasePropertyEx(''''?'''',''''Status'''')) AS Status,  
CONVERT(sysname,DatabasePropertyEx(''''?'''',''''Updateability'''')) AS Updateability,  
CONVERT(sysname,DatabasePropertyEx(''''?'''',''''Recovery'''')) AS RecoveryMode,  
CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, '' + '''''''' +  
       ''SpaceUsed'' + '''''''' + '' ) AS int)/128.0 AS int) AS FreeSpaceMB,  
CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name,  
'' + '''''''' + ''SpaceUsed'' + '''''''' + '' ) AS int)/128.0)/(sysfiles.size/128.0))  
AS decimal(4,2))) AS varchar(8)) + '' + '''''''' + ''%'' + '''''''' + '' AS FreeSpacePct,  
GETDATE() as PollDate FROM dbo.sysfiles''  
INSERT INTO @DBInfo  
   (ServerName,  
   DatabaseName,  
   FileSizeMB,  
   LogicalFileName,  
   PhysicalFileName,  
   Status,  
   Updateability,  
   RecoveryMode,  
   FreeSpaceMB,  
   FreeSpacePct,  
   PollDate)  
EXEC sp_MSForEachDB @command  

SELECT  
   ServerName,  
   DatabaseName,
   LogicalFileName,   
   FileSizeMB,     
   FreeSpaceMB,  
   FreeSpacePct,  
   PollDate  
FROM @DBInfo  
ORDER BY FreeSpacePct


' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_input_buffer]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_input_buffer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_uoldiveo_input_buffer]
 ( @SPID SMALLINT, -- O SPID A SER ANALIZADO
   @WAIT TINYINT = 1, -- INTERVALO DE REPETIÇÃO ENTRE AS VERIFICAÇÕES.VALORDEVEESTAR ENTRE 0 E 60 SEGUNDOS -- DEFAULT É DE 1 EM 1 SEGUNDO 
   @NOLOOP BIT = 1, -- SE =1, O SPID É ANALIZADO APENAS UMA VEZ. SE =0 FICA EM LOOP ATÉ O FINAL DO PROCESSO. 
   @@COMANDO VARCHAR(8000) OUTPUT
 )
 AS
 BEGIN
 
/********************************************************************************************
 SP_USRINPUTBUFFER: ESTA PROCEDURE PERMITE IDENTIFICAR A INSTRUÇÃO EXATA
 QUE ESTÁ SENDO
 EXECUTADO POR UMA DADA CONEXÃO. SEMELHANTE AO DBCC INPUTBUFFER MAS
 DIFERENTE DESTA, EM CASO
 DE PROCEDURE, A PROC MOSTRA TODA A INSTRUÇÃO INTEIRA E NÃO APENAS O NOME
 DA PROCEDURE. MUITO BOA
 PARA SER USADA EM CONJUNTO COM A PROCEDURE SP_USRHEADBLOCKER.
 
 EXEMPLO: SP_USRINPUTBUFFER 54 (ONDE 54 É O ID DA CONEXÃO SPID)
 
 OBS: SE PREFERIR, ESTA PODE SER CRIADA EM QUALQUER BANCO, PORÉM, AO
 EXECUTÁ-LA DEVERÁ PASSAR O NOME DA
 BASE ONDE A MESMA SE ENCONTRA. EXEMPLO: BASE..SP_USRINPUTBUFFER 54
 

*********************************************************************************************/
 

 SET NOCOUNT ON
 
 DECLARE @SQL_HANDLE BINARY(20), @HANDLE_FOUND BIT
 DECLARE @STMT_START INT, @STMT_END INT
 DECLARE @LINE VARCHAR(8000), @WAIT_STR VARCHAR(8)
 
 SET @HANDLE_FOUND = 0
 
 IF @WAIT NOT BETWEEN 0 AND 60
 BEGIN
 RAISERROR(''VALORES VÁLIDOS PARA @WAIT ESTÃO ENTRE 0 E 60 SEGUNDOS'', 16, 1)
 RETURN -1
 END
 ELSE
 BEGIN
 SET @WAIT_STR = ''00:00:'' + RIGHT(''00'' + CAST(@WAIT AS VARCHAR(2)), 2)
 END
 
 WHILE 1 = 1
 BEGIN
 SELECT @SQL_HANDLE = SQL_HANDLE,
 @STMT_START = STMT_START/2,
 @STMT_END = CASE WHEN STMT_END = -1 THEN -1 ELSE STMT_END/2 END
 FROM MASTER.DBO.SYSPROCESSES
 WHERE SPID = @SPID
 AND ECID = 0
 
 IF @SQL_HANDLE = 0X0
 BEGIN
 IF @HANDLE_FOUND = 0
 BEGIN
 RAISERROR(''NÃO PODE ENCONTRAR O HANDLE OU O SPID É INVÁLIDO'', 16, 1)
 RETURN -1
 END
 ELSE
 BEGIN
 RAISERROR(''QUERY/STORED PROCEDURE COMPLETADA'', 0, 1)
 RETURN 0
 END
 END
 ELSE
 BEGIN
 SET @HANDLE_FOUND = 1
 END
 PRINT ''******** STATEMENT SENDO EXECUTADO NO MOMENTO ************''
 PRINT ''''
 SET @LINE =
 (
 SELECT
 SUBSTRING( TEXT,
 COALESCE(NULLIF(@STMT_START, 0), 1),
 CASE @STMT_END
 WHEN -1
 THEN DATALENGTH(TEXT)
 ELSE
 (@STMT_END - @STMT_START)
 END
 )
 FROM ::FN_GET_SQL(@SQL_HANDLE)
 )
 
 PRINT @LINE
 
 --SETANDO VALOR DA LINHA NA VARIAVEL OUTPUT
 SET @@COMANDO = @LINE
 --RETORNANDO VALOR PARA A CHAMADA
 SELECT @@COMANDO
 
 IF @NOLOOP = 1
 BEGIN
 RETURN 0
 END
 
 WAITFOR DELAY @WAIT_STR
 
 END
 
 END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_uso_espaco_livre_dados]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_uso_espaco_livre_dados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE procedure [dbo].[usp_zabbix_uso_espaco_livre_dados]
as

 
create table #db_files(
 db_files    varchar(300),
 file_loc    varchar(300),
 filesizeMB  decimal(9,2),
 spaceUsedMB decimal(9,2),
 FreespaceMB decimal(9,2))
 
declare @strSQL    nvarchar(2000)
       ,@dbName    varchar(8000)
       ,@getDBname cursor
 
set @getDBname = cursor for
select name from master.sys.databases
where  name not in(''tempdb'',''msdb'',''master'',''model'',''Northwind'',''pubs'')
and    state_desc = ''ONLINE''
and    is_read_only<>1
and    is_in_standby<>1
 
open @getDBname
fetch next
 from @getDBname into @dbName
 while @@FETCH_STATUS = 0
 BEGIN
 
select @strSQL = 
    ''
       use '' + quotename(@dbName) + ''
       insert into #db_files
       select
       name
     , filename
     , convert(decimal(12,2),round(a.size/128.000,2)) as FileSizeMB
     , convert(decimal(12,2),round(fileproperty(a.name,''''SpaceUsed'''')/128.000,2)) as SpaceUsedMB
     , convert(decimal(12,2),round((a.size-fileproperty(a.name,''''SpaceUsed''''))/128.000,2)) as FreeSpaceMB
       from dbo.sysfiles a
       where a.fileid<>2
       and   a.maxsize >-1
     ''
     exec sp_executesql @strSQL
 
fetch next
 
 from @getDBname into @dbName
 
end

 close      @getDBname
 deallocate @getDBname

if not exists(select * from #db_files
              where  convert(decimal(15,2),(SpaceUsedMB/FileSizeMB)*100)>80.00)

select 0 as Valor ---Não existem bancos de dados com espaço livre maior que 80%
else
select 1 as Valor ---Existem bancos de dados com espaço livre maior que 80%

drop table #db_files





' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_uso_consumo_log]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_uso_consumo_log]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


create procedure [dbo].[usp_zabbix_uso_consumo_log]
as
create table #lgspace(
						dbname nvarchar(128),
						size   [FLOAT],
						pct    [FLOAT],
						status [INT])

insert into #lgspace
exec (''DBCC SQLPERF(LOGSPACE)'')
	
if not exists(select dbname
                    ,pct 
			  from   #lgspace as ls inner join master.sys.master_files as mf
			  on     db_id(ls.dbname) = mf.database_id
			  where  ls.pct>70.00
			  and    mf.database_id not in(1,2,3,4)
			  and    mf.[file_id]=2
			  and    mf.max_size<268435456 ---Arquivo de log que não cresce até o limite máximo de 2TB.
			  and    mf.max_size >-1)      ---Arquivo de log sem crescimento automático

select 0 as Valor ---Não existem arquivos de log com percentual de uso maior que 70%
else 
select 1 as Valor ---Existem arquivos de log com percentual de uso maior que 70%

drop table #lgspace


' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE procedure [dbo].[usp_zabbix_sessao_verifica_queries_bloqueadas]
as

begin
if exists (
select r.session_id, r.plan_handle,
    r.sql_handle, r.request_id,
    r.start_time, r.status,
    r.command, r.database_id,
    r.user_id, r.wait_type,
    r.wait_time, r.last_wait_type,
    r.wait_resource, r.total_elapsed_time,
    r.cpu_time, r.transaction_isolation_level,
    r.row_count, st.text
from master.sys.dm_exec_requests r
cross apply master.sys.dm_exec_sql_text(r.sql_handle) as st
where r.blocking_session_id = 0 
    and r.session_id in 
    (select distinct(blocking_session_id)
     from master.sys.dm_exec_requests)
group by r.session_id, r.plan_handle,
    r.sql_handle, r.request_id,
    r.start_time, r.status,
    r.command, r.database_id,
    r.user_id, r.wait_type,
    r.wait_time, r.last_wait_type,
    r.wait_resource, r.total_elapsed_time,
    r.cpu_time, r.transaction_isolation_level,
    r.row_count, st.text
)
begin
select count (r.session_id) as Valor
from master.sys.dm_exec_requests r
cross apply master.sys.dm_exec_sql_text(r.sql_handle) as st
where r.blocking_session_id = 0 
    and r.session_id in 
    (select distinct(blocking_session_id)
         from master.sys.dm_exec_requests)
end
else
select 0 as Valor
end


' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_sessao_verifica_deadlocks]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_sessao_verifica_deadlocks]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[usp_zabbix_sessao_verifica_deadlocks]
as
declare @time1  datetime
       ,@time2  datetime
       ,@value1 bigint
       ,@value2 bigint

-- pega o primeiro exemplo
select 
	@value1 = cntr_value, 
	@time1 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Locks'' and 
	counter_name = ''Number of Deadlocks/sec'' AND 
	instance_name = ''_Total'';
	

-- aguarda por 5 segundos
waitfor delay ''00:00:05'';

-- pega o segundo exemplo
select 
	@value2 = cntr_value, 
	@time2 = getdate()
from
	master.sys.dm_os_performance_counters
where 
	object_name = left([object_name],charindex('':'',[object_name])-1)+'':Locks'' and 
	counter_name = ''Number of Deadlocks/sec'' AND 
	instance_name = ''_Total'';

-- calcula págins lidas por segundo
select
	(@value2 - @value1) / datediff(ss,@time1,@time2) [Number of Deadlocks/sec];




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_estado_verifica_status_base_dados]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_estado_verifica_status_base_dados]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE procedure [dbo].[usp_zabbix_estado_verifica_status_base_dados]
as
if not exists(select name from master.sys.databases
where  state_desc not in(''ONLINE'',''RESTORING'',''RECOVERING''))

select 0 as Valor ---Não existem bases de dados offline
else 
select 1 as Valor ---Existem bases de dados offline





' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[usp_zabbix_erro_verifica_status_error_log_sql_server]
as
declare @strSQL       nvarchar(2000)
       ,@errorName    varchar(5000)
       ,@getErrorname cursor

create table #error_log(LogDate datetime,ProcessInfo varchar(100), Text varchar(5000))
 
set    @getErrorname = cursor for
select error_name from uoldiveodb.dbo.uoldiveo_error_list
 
open @getErrorname

fetch next

from  @getErrorname into @errorName

while @@FETCH_STATUS = 0

begin
 
select @strSQL = ''exec master.dbo.xp_readerrorlog 1,1,'''''' + @errorName + ''''''''
     
     insert into #error_log
     exec sp_executesql @strSQL

if (select count(*) from #error_log) > 0

  begin
  
     break
 
  end
 
fetch next
 
 from @getErrorname INTO @errorName
 
end

close @getErrorname
deallocate @getErrorname
     
begin 
 
     if not exists (select count(*) from #error_log)
 
       select 0 as Valor ---Não Existem erros no arquivo do Error Log do SQL Server 
       else 
       select 1 as Valor ---Existem erros no arquivo do Error Log do SQL Server
 
end

--if (select count(*) from #error_log)>0

--begin tran 

--exec sp_cycle_errorlog;

--commit tran
 
drop table #error_log



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE procedure [dbo].[usp_zabbix_saude_verifica_base_dados_sem_executar_dbcc_checkdb]
as

create table #tempdb
(
    dbname varchar(255),
    field  varchar(255),
    value  varchar(255))

create table #tempdb1
(
    parentobject varchar(255),
    object       varchar(255),
    field        varchar(255),
    value        varchar(255))

execute master..sp_MSforeachdb ''
insert into #tempdb1 exec(''''dbcc dbinfo ( ''''''''?'''''''') with tableresults'''')
insert into #tempdb (field, value, dbname)
select field, value, ''''?'''' from #tempdb1
truncate table #tempdb1'';

insert into uoldiveodb.dbo.uoldiveo_dbcc_checkdb_monitor
select   dbname,field,max(value) as value,getdate() from #tempdb
where    field = ''dbi_dbccLastKnownGood''
and      value < getdate()-7
and      dbname not in(''master'',''model'',''tempdb'',''msdb'',''uoldiveodb'',''t4bdb01'',''Northwind'',''pubs'')
group by dbname,field

if not exists(select   dbname, max(value) as value from #tempdb
where    field = ''dbi_dbccLastKnownGood''
and      value < getdate()-7
and      dbname not in(''master'',''model'',''tempdb'',''msdb'',''uoldiveodb'',''t4bdb01'',''Northwind'',''pubs'')
group by dbname)

select 0 as Valor ---Não existem bases de dados sem verificação da consistência (dbcc checkdb) na última semana 
else 
select 1 as Valor ---Existem bases de dados sem verificação da consistência (dbcc checkdb) na última semana

drop table #tempdb
drop table #tempdb1









' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE procedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]
as

if not exists(select status_last_execution from uoldiveodb.dbo.uoldiveo_job_monitor 
 where id_job_execution in(select max(id_job_execution) from uoldiveodb.dbo.uoldiveo_job_monitor)
 and   job_name = ''UOLDIVEO: Rotina Manutenção''
 and   status_last_execution=''Falha'')

   select 0  as Valor ---Sucesso
else
   select 1  as Valor ---Falha     




' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE procedure [dbo].[usp_zabbix_job_status_log_shipping_ultimos_60_minutos]
as
if not exists(select top 1 log_time from msdb.dbo.log_shipping_monitor_error_detail 
              where  log_time between dateadd(minute, -30, getdate()) and getdate())

select 0 as Valor ---Não existem erros no envio do backup de log entre o servidor primário e secundário
else 
select 1 as Valor ---Existem erros no envio do backup de log entre o servidor primário e secundário






' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE procedure [dbo].[usp_zabbix_job_status_atingiu_limite_tempo_plano_manutencao]
as
    
if exists (select * from uoldiveodb.dbo.uoldiveo_job_monitor
where  datediff(minute,dat_begin_execution,getdate())> (threshold_execution-15)
and    id_job_execution in(select max(id_job_execution) from uoldiveodb.dbo.uoldiveo_job_monitor
                           where  status_last_execution=''Executando''
                           and    convert(varchar(10),dat_begin_execution,112)=convert(varchar(10),getdate(),112))
and    job_name = ''UOLDIVEO: Rotina Manutenção'')
          
select 1 as Valor    ---Faltam 15 minutos para a rotina de manutenção ultrapassar o limite (janela) de tempo de execução.
else
select 0 as Valor    ---A rotina de manutenção não ultrapassou o limite (janela) de tempo de execução.


' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE procedure [dbo].[usp_zabbix_backup_base_dados_sem_historico_backup]
as
if not exists(select  *
		      from  
			 (select d.name      
              from 
              master.sys.databases as d left join msdb.dbo.backupset as b
              on db_id(d.name)  = db_id(b.database_name) 
              where b.database_name is null and d.name not in(''tempdb'',''model'',''Northwind'',''pubs'')
              and   d.state_desc = ''ONLINE''
              and   d.is_read_only<>1
              and   d.is_in_standby<>1)consulta)

select 0 as Valor ---Não existem bases de dados sem histórico de backup
else 
select 1 as Valor ---Existem bases de dados sem histórico de backup



' 
END
GO
/****** Object:  StoredProcedure [dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]    Script Date: 05/08/2013 23:10:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE procedure [dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]
as
if not exists(select  *
		      from  
			 (select     bacs.database_name as banco,
			             max(bacs.backup_finish_date) as dt_backup
			  from       msdb.dbo.backupmediafamily as bacm
			  inner join msdb.dbo.backupset as bacs
			  on         bacm.media_set_id = bacs.media_set_id 
			  inner join master.sys.databases as d
			  on         d.database_id = db_id(bacs.database_name)
		   	  where      bacs.[type] = ''D''
		   	  and   d.state_desc = ''ONLINE''
		   	  and   d.name not in(''tempdb'',''model'',''Northwind'',''pubs'')
              and   d.is_read_only<>1
              and   d.is_in_standby<>1
			  group by   bacs.database_name) consulta
		      where dt_backup < (select getdate() -1))

select 0 as Valor ---Não existem bases de dados sem backup full no último dia 
else 
select 1 as Valor ---Existem bases de dados sem backup full no último dia




' 
END
GO

/****** Object:  Table [dbo].[uoldiveo_dbcc_checkdb_monitor]    Script Date: 05/13/2013 16:23:08 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_dbcc_checkdb_monitor]') AND type in (N'U'))

CREATE TABLE [dbo].[uoldiveo_dbcc_checkdb_monitor](
	[db_name] [varchar](255) NULL,
	[field] [varchar](255) NULL,
	[dat_last_dbcc_execution] [datetime] NULL,
	[dat_status_execution] [datetime] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[uoldiveo_error_list]    Script Date: 05/13/2013 16:27:16 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_error_list]') AND type in (N'U'))

CREATE TABLE [dbo].[uoldiveo_error_list](
	[error_name] [varchar](255) NULL,
	[dat_registration] [datetime] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[uoldiveo_index_fragment]    Script Date: 05/13/2013 16:28:50 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_index_fragment]') AND type in (N'U'))

CREATE TABLE [dbo].[uoldiveo_index_fragment](
	[db_name] [nvarchar](255) NULL,
	[table_name] [nvarchar](255) NULL,
	[schema_name] [nvarchar](255) NULL,
	[index_name] [nvarchar](255) NULL,
	[avg_fragment] [decimal](18, 2) NULL,
	[dat_execution] [datetime] NULL,
	[status_execution] [bit] NULL,
	[id_job_monitor] [int] NULL,
	[index_partition] [int] NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[uoldiveo_job_monitor]    Script Date: 05/13/2013 16:31:48 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_job_monitor]') AND type in (N'U'))

CREATE TABLE [dbo].[uoldiveo_job_monitor](
	[id_job_execution] [int] IDENTITY(1,1) NOT NULL,
	[job_name] [varchar](100) NULL,
	[job_description] [varchar](255) NULL,
	[dat_begin_execution] [datetime] NULL,
	[dat_end_execution] [datetime] NULL,
	[time_minute_execution] [varchar](50) NULL,
	[status_last_execution] [char](10) NULL,
	[threshold_execution] [int] NOT NULL,
	[dat_end_statistics_execution] [datetime] NULL,
	[dat_end_index_execution] [datetime] NULL,
	[dat_end_recompile_execution] [datetime] NULL,
	[dat_end_dbcc_execution] [datetime] NULL,
	[error_description_statistics] [varchar](255) NULL,
	[error_description_index] [varchar](255) NULL,
	[error_description_recompile] [varchar](255) NULL,
	[error_description_dbcc] [varchar](255) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[uoldiveo_bancos_manutencao]    Script Date: 05/13/2013 16:49:40 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_bancos_manutencao]') AND type in (N'U'))


CREATE TABLE [dbo].[uoldiveo_bancos_manutencao](
	[ID_IDEN] [int] IDENTITY(1,1) NOT NULL,
	[ID_BANCO] [int] NULL,
	[NOME_BANCO] [varchar](256) NULL
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[uoldiveo_backup_config]    Script Date: 05/13/2013 17:01:10 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uoldiveo_backup_config]') AND type in (N'U'))

CREATE TABLE [dbo].[uoldiveo_backup_config](
	[database_id] [int] NULL,
	[database_name] [nvarchar](255) NULL,
	[database_state] [tinyint] NULL,
	[database_state_desc] [nvarchar](255) NULL,
	[database_user_access] [tinyint] NULL,
	[database_user_access_desc] [nvarchar](255) NULL,
	[database_recovery_model] [tinyint] NULL,
	[database_recovery_model_desc] [nvarchar](255) NULL,
	[database_is_read_only] [bit] NULL,
	[database_dat_changed_read_only] [datetime] NULL,
	[backup_full_path] [varchar](255) NULL,
	[backup_full_is_active] [bit] NULL,
	[backup_diff_path] [varchar](255) NULL,
	[backup_diff_is_active] [bit] NULL,
	[backup_log_path] [varchar](255) NULL,
	[backup_log_is_active] [bit] NULL,
	[backup_is_active_desc] [varchar](50) NULL,
	[backup_dat_inactive] [datetime] NULL
) ON [PRIMARY]

GO


/****** Object:  Login [adm.uoldiveodb]    Script Date: 05/07/2013 12:19:07 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'adm.uoldiveodb')
DROP LOGIN [adm.uoldiveodb]
GO

/* For security reasons the login is created disabled and with a random password. */
/****** Object:  Login [adm.uoldiveodb]    Script Date: 05/07/2013 12:19:07 ******/
CREATE LOGIN [adm.uoldiveodb] WITH PASSWORD=N'uoldiveo@1234', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO

EXEC sys.sp_addsrvrolemember @loginame = N'adm.uoldiveodb', @rolename = N'sysadmin'

GO

/****** Object:  Login [usr.zabbix]    Script Date: 05/13/2013 17:08:04 ******/
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'usr.zabbix')
DROP LOGIN [usr.zabbix]

GO

