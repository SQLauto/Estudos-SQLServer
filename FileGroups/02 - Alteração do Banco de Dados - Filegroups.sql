-- Muda o Contexto de Banco de Dados
USE Master

-- Adiciona os FILEGROUPs
ALTER DATABASE BDSSD ADD FILEGROUP RH
ALTER DATABASE BDSSD ADD FILEGROUP MKT
ALTER DATABASE BDSSD ADD FILEGROUP PROD
ALTER DATABASE BDSSD ADD FILEGROUP CORP

-- Adiciona novos Arquivos
ALTER DATABASE BDSSD ADD FILE (
	NAME='BDSSD_RH',
	FILENAME='C:\SSD\BDSSD_RH.NDF') TO FILEGROUP [RH]
	
-- Adiciona novos Arquivos
ALTER DATABASE BDSSD ADD FILE (
	NAME='BDSSD_MKT',
	FILENAME='C:\SSD\BDSSD_MKT.NDF') TO FILEGROUP [MKT]
	
-- Adiciona novos Arquivos
ALTER DATABASE BDSSD ADD FILE (
	NAME='BDSSD_PROD',
	FILENAME='C:\SSD\BDSSD_PROD.NDF') TO FILEGROUP [PROD]
	
-- Adiciona novos Arquivos
ALTER DATABASE BDSSD ADD FILE (
	NAME='BDSSD_CORP',
	FILENAME='C:\SSD\BDSSD_CORP.NDF') TO FILEGROUP [CORP]