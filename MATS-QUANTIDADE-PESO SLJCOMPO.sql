USE ROSARIO 
GO

/*
SELECT 
A.CODTAB, A.DESCRT, B.DESCRT, B.FILMAT, B.CODMAT,
CASE 
	WHEN   A.CODTAB IN (19,23, 26, 29, 32) THEN B.DESCRT
END AS MATS,
CASE 
	WHEN   A.CODTAB IN (21, 24, 27, 30, 34) THEN B.DESCRT
END AS QUANTIDADE,
CASE 
	WHEN   A.CODTAB IN (22, 25, 28, 31, 35) THEN B.DESCRT
END AS PESO
 FROM TD_CRT A
JOIN TT_CRTXPRO B ON B.CODCRT = A.CODTAB
WHERE B.FILMAT+B.CODMAT = 'LCH  374'
*/

/*
SELECT A.CODTAB, A.DESCRT AS DESC1, B.DESCRT AS DESC2, B.FILMAT+B.CODMAT AS CPROS
INTO #MATS
 FROM TD_CRT A
JOIN TT_CRTXPRO B ON B.CODCRT = A.CODTAB
WHERE A.CODTAB IN (19,23, 26, 29, 32)
GO

SELECT A.CODTAB, A.DESCRT AS DESC1, B.DESCRT AS DESC2, B.FILMAT+B.CODMAT AS CPROS
INTO #QUANTIDADE
 FROM TD_CRT A
JOIN TT_CRTXPRO B ON B.CODCRT = A.CODTAB
WHERE A.CODTAB IN (21, 24, 27, 30, 34)
GO

SELECT A.CODTAB, A.DESCRT AS DESC1, B.DESCRT AS DESC2, B.FILMAT+B.CODMAT AS CPROS
INTO #PESO
 FROM TD_CRT A
JOIN TT_CRTXPRO B ON B.CODCRT = A.CODTAB
WHERE A.CODTAB IN (22, 25, 28, 31, 35)
*/

/*
SELECT DISTINCT 
	M.CODTAB AS CODTAB_MATS, Q.CODTAB AS CODTAB_QTDS , P.CODTAB AS CODTAB_PESO, 
	M.CPROS AS CPROS_MATS, Q.CPROS AS CPROS_QDTS, Q.CPROS AS CPROS_PESO, 
	M.DESC1 AS DESC1_MATS, Q.DESC1 AS DESC1_QTDS, P.DESC1 AS DESC1_PESO,  
	M.DESC2 AS DESC2_MATS, Q.DESC2 AS DESC2_QTDS, P.DESC2 AS DESC2_PESO
INTO SLJCOMPO_TMP
FROM #MATS M
LEFT JOIN #QUANTIDADE Q ON Q.CPROS = M.CPROS
LEFT JOIN #PESO P ON P.CPROS = Q.CPROS
*/

SELECT * FROM ROSARIO..SLJCOMPO_TMP