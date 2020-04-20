-- Restaura o FILEGROUP PRIMARY
RESTORE DATABASE BDSSD FROM DISK = 'C:\SSD\Backups\BDSSD_FGPrimary.BAK'
WITH NORECOVERY

-- Restaura o FILEGROUP MKT
RESTORE DATABASE BDSSD FROM DISK = 'C:\SSD\Backups\BDSSD_FGMKT.BAK'
WITH NORECOVERY

-- Restaura o FILEGROUP PROD
RESTORE DATABASE BDSSD FROM DISK = 'C:\SSD\Backups\BDSSD_FGPROD.BAK'
WITH NORECOVERY

-- Restaura o FILEGROUP RH
RESTORE DATABASE BDSSD FROM DISK = 'C:\SSD\Backups\BDSSD_FGRH.BAK'
WITH NORECOVERY

-- Restaura o Log01
RESTORE LOG BDSSD FROM DISK = 'C:\SSD\Backups\BDSSDLog01.TRN'
WITH NORECOVERY

-- Restaura o Log02
RESTORE LOG BDSSD FROM DISK = 'C:\SSD\Backups\BDSSDLog02.TRN'
WITH NORECOVERY

-- Restaura o FILEGROUP CORP
RESTORE DATABASE BDSSD FROM DISK = 'C:\SSD\Backups\BDSSD_FGCORP.BAK'
WITH NORECOVERY

-- Restaura o Log03
RESTORE LOG BDSSD FROM DISK = 'C:\SSD\Backups\BDSSDLog03.TRN'
WITH NORECOVERY

-- Deixa o banco Operacional
RESTORE LOG BDSSD WITH RECOVERY

-- Verifica os pedidos
SELECT PedidoNum, DataPedido, EmpregadoID, ProdutoID, ClienteID
FROM BDSSD.CORP.Pedidos