SELECT DISTINCT a.CODBARRAS, a.DESCRICAO, a.CODPRODUTO
 FROM PRODUTOS a 
  LEFT OUTER JOIN PRODUTOS_DUPLICADOS b
   ON a.CODBARRAS = b.CODBARRAS
 WHERE a.CODPRODUTO <> b.CODPRODUTO
ORDER BY a.CODPRODUTO
