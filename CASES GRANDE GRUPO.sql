USE ROSARIO
GO
/*
DROP TABLE GG_DECORACOES
DROP TABLE GG_DIVERSOS
DROP TABLE GG_ELETRODOMESTICOS
DROP TABLE GG_JOIAS
DROP TABLE GG_MONTBLANC
DROP TABLE GG_OCULOS
DROP TABLE GG_RELOGIOS
DROP TABLE GG_U_DOMESTICAS
*/
--GRANDE GRUPO DECORACOES
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN'BANDEJAS' THEN'BA'
WHEN'BANHEIRO/LAVABO'THEN'BAN'
WHEN'BAUS'THEN'BAU'
WHEN'BOLAS DECORATIVAS'THEN'BOL'
WHEN'BOX/CX'THEN'BOX'
WHEN'CARTEIRAS'THEN'CA'
WHEN'CASTICAIS/CANDELABROS'THEN'CAS'
WHEN'CENTRO DE MESA'THEN'CM'
WHEN'DECORACOES'THEN'DEC'
WHEN'DIVERSOS'THEN'DDV'
WHEN'ENFEITES NATALINO'THEN'ENF'
WHEN'ESTATUAS/ESCULTURAS'THEN'EST'
WHEN'ESTOJOS'THEN'ESJ'
WHEN'FRUTEIRAS'THEN'FRU'
WHEN'LUMINARIAS/ABAJUS'THEN'LUM'
WHEN'ORGANIZADORES/UTENSIOLIOS'THEN'ORG'
WHEN'PORTA RETRATO'THEN'PRT'
WHEN'PORTA VELA'THEN'PRV'
WHEN'POTES/TIGELAS'THEN'POT'
WHEN'PRATOS'THEN'PRA'
WHEN'RELOGIOS'THEN'REL'
WHEN'SOUPAT/SUPORTES'THEN'SOU'
WHEN'TRAVESSAS'THEN'TRA'
WHEN'VALENTINO'THEN'VAL'
WHEN'VASOS/BACIA/GARRAFAS'THEN'VAS'
WHEN'VELAS DECORATIVAS'THEN'VEL'
END AS GRUPO
INTO GG_DECORACOES
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 8

--GRANDE GRUPO DIVERSOS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN'CARTEIRAS'THEN ''
WHEN'DIVERSOS'THEN 'DIV'
WHEN'ESSENCIAS'THEN 'DES'
WHEN'ORGANIZADORES/UTENSIOLIOS' THEN 'DOU'
WHEN'TECHNO MARINE'THEN	''
END AS GRUPO
INTO GG_DIVERSOS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 7

--GRANDE GRUPO ELETRODOMESTICOS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN'BATEDEIRA'THEN'BAT'
WHEN'CAFETEIRAS/CHALEIRAS/BULES'THEN'CAF'
WHEN'DIVERSOS'THEN'EDV'
WHEN'LINHA BAR'THEN'LBA'
WHEN'LIQUIDIFICADOR'THEN'LQF'
WHEN'TORRADEIRA'THEN'TOR'
END AS GRUPO
INTO GG_ELETRODOMESTICOS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 10

--GRANDE GRUPO JOIAS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN 'ABOTOADURA'THEN'AB'
WHEN 'ALIANCAS'THEN'AL'
WHEN 'ANEIS'THEN'AN'
WHEN 'ARGOLA'THEN'AR'
WHEN 'ARO'THEN'ARO'
WHEN 'BRACELETE'THEN'BRA'
WHEN 'BRACELETES'THEN'BRA'
WHEN 'BRINCO'THEN'BR'
WHEN 'BROCHE/PIERCING'THEN'BRO'
WHEN 'CHAVEIRO/ABOTOA'THEN'CHA'
WHEN 'CORRENTE'THEN'CO'
WHEN 'FEIXO/TARRAXA/S'THEN'FEI'
WHEN 'GARGANT'THEN'GA'
WHEN 'GARGANTILHA'THEN'GA'
WHEN 'MONT BLANC'THEN''
WHEN 'PINGENTES'THEN'PI'
WHEN 'PRED. GRAVATA'THEN'PGR'
WHEN 'PULSEIRA'THEN'PU'
WHEN 'PULSEIRAS'THEN'PU'
WHEN 'TORNOZELEIRA'THEN'TO'
END AS GRUPO
INTO GG_JOIAS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 1

--GRANDE GRUPO MONTBLANC
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN'ABOTOADURA'THEN'AB'
WHEN'ANEIS'THEN'AN'
WHEN'BLOCO ANOTACAO'THEN'BA'
WHEN'BOLSAS'THEN'BO'
WHEN'BRINCO'THEN'BR'
WHEN'CARTEIRAS'THEN'CAR'
WHEN'CHAVEIRO'THEN'CHA'
WHEN'CINTOS'THEN'CIN'
WHEN'DIVERSOS'THEN'ADV'
WHEN'ESTOJOS'THEN'AES'
WHEN'GARGANT'THEN'GA'
WHEN'INSTR. ESCRITA'THEN'CAN'
WHEN'NECESSAIRE'THEN'NEC'
WHEN'PASTAS'THEN'PST'
WHEN'PERFUMES'THEN'PER'
WHEN'PORTA CARTAO'THEN'PC'
WHEN'PORTA CHAVES'THEN'PCH'
WHEN'PRED. GRAVATA'THEN'PRG'
WHEN'REFIL ESCRITA'THEN'REF'
END AS GRUPO
INTO GG_MONTBLANC
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 5

--GRANDE GRUPO OCULOS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN 'BVLGARI'THEN'OBV'
WHEN 'CARRERA'THEN'OCA'
WHEN 'CHRISTIAN DIOR'THEN'OCH'
WHEN 'DIESEL'THEN'ODE'
WHEN 'EMPORIO ARMANI'THEN'OEA'
WHEN 'GIORGIO ARMANI'THEN'OGA'
WHEN 'GUCCI'THEN'OGU'
WHEN 'MONT BLANC'THEN'OMB'
WHEN 'OAKLEY'THEN'OOA'
WHEN 'RAY BAN'THEN'ORB'
WHEN 'TOM FORD'THEN'OTF'
WHEN 'VOGUE'THEN'OVO'
END AS GRUPO
INTO GG_OCULOS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 3

--GRANDE GRUPO RELOGIOS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN 'ARMANI EXCHANGE'THEN'ERA'
WHEN 'BREITLING'THEN'RBR'
WHEN 'CALVIN KLEIN'THEN'RCK'
WHEN 'EMPORIO'THEN'REA'
WHEN 'EMPORIO ARMANI'THEN'REA'
WHEN 'GUESS'THEN'RGE'
WHEN 'INVICTA'THEN'RIN'
WHEN 'MICHAEL KORS'THEN'RMK'
WHEN 'MIDO'THEN'RMI'
WHEN 'MONT BLANC'THEN'RMB'
WHEN 'NIKE'THEN'RNK'
WHEN 'OAKLEY'THEN'ROA'
WHEN 'PUMA'THEN'RPU'
WHEN 'RELOGIOS'THEN'RRE'
WHEN 'SECULUS'THEN'RSE'
WHEN 'SWATCH'THEN'RSW'
WHEN 'TECHNO MARINE'THEN'RTM'
WHEN 'TECHNOS'THEN'RTE'
WHEN 'TISSOT'THEN'RTI'
END AS GRUPO
INTO GG_RELOGIOS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 2

--GRANDE GRUPO UTILIDADES DOMESTICAS
SELECT 
DISTINCT
--TT_PRO.DEPART, TD_DEP.CODTAB, TD_DEP.DESDEP, TD_CL1.CLASS1 
TD_DEP.CODTAB AS TD_DEP_CODTAB,
TT_PRO.DEPART AS TT_PRO_DEPART,
TD_CL1.CODTAB AS TD_CLI1_CODTAB,
TT_PRO.CLASS1 AS TT_PRO_COD_CLASS1,
TD_CL1.CLASS1 AS TD_CL1_CLASS1,
CASE TD_DEP.DESDEP
	WHEN 'JOIAS' THEN 'JOI'
	WHEN 'MONTBLANC' THEN 'IE'
	WHEN 'OCULOS' THEN 'OC'
	WHEN 'RELOGIOS' THEN 'REL'
	WHEN 'UTILIDADES DOMESTICAS' THEN 'UD'
	WHEN 'DECORA플O' THEN 'DEC'
	WHEN 'ELETRODOMESTICOS' THEN 'ELD'
	WHEN 'FOTOGRA플O' THEN 'FG'
	WHEN 'ACESSORIOS' THEN 'AC'
	WHEN 'DIVERSOS' THEN 'DIV'
	WHEN 'ELETRODOMESTICOS' THEN 'ELE'
	ELSE TD_DEP.DESDEP
END AS G_GRUPO,
CASE TD_CL1.CLASS1
WHEN 'APARELHOS JANTAR'THEN'UAP'
WHEN 'BANDEJAS'THEN'UBA'
WHEN 'BANHEIRO/LAVABO'THEN'UBN'
WHEN 'BATEDEIRA'THEN'UBT'
WHEN 'BAUS'THEN'UBS'
WHEN 'BOLEIRAS'THEN'UBL'
WHEN 'BOMBONIERE/BALEIRO'THEN'UBO'
WHEN 'CAFETEIRAS/CHALEIRAS/BULES'THEN'UCF'
WHEN 'CANECAS'THEN'UCA'
WHEN 'CASTICAIS/CANDELABROS'THEN'UCT'
WHEN 'CENTRO DE MESA'THEN'UCM'
WHEN 'CESTOS'THEN'UCE'
WHEN 'CHA E CAFE'THEN'UCH'
WHEN 'COPOS/TA�AS'THEN'UCO'
WHEN 'DIVERSOS'THEN'UDI'
WHEN 'ESTOJOS'THEN'UES'
WHEN 'FACAS E TALHERES'THEN'UFC'
WHEN 'FRUTEIRAS'THEN'UFT'
WHEN 'GALHETEIRO'THEN'UGR'
WHEN 'GARRAFAS TERMICAS'THEN'UGT'
WHEN 'GUARDANPOS'THEN'UGU'
WHEN 'JG AMERICANO'THEN'UJA'
WHEN 'LANCHE/SOBREMESA'THEN'ULS'
WHEN 'LINHA BAR'THEN'UBR'
WHEN 'LIQUIDIFICADOR'THEN'ULQ'
WHEN 'ORGANIZADORES/UTENSIOLIOS'THEN'UOU'
WHEN 'PETISQUERAS'THEN'UPT'
WHEN 'PORTA RETRATO'THEN'UPR'
WHEN 'POTES/TIGELAS'THEN'UPT'
WHEN 'PRATOS'THEN'UPA'
WHEN 'RECHAUDS/FONDUE'THEN'URE'
WHEN 'SALADEIRAS'THEN'USA'
WHEN 'SOUPAT/SUPORTES'THEN'USO'
WHEN 'TORRADEIRA'THEN'UTO'
WHEN 'TRAVESSAS'THEN'UTA'
WHEN 'VASOS/BACIA/GARRAFAS'THEN'UVB'
WHEN 'XICARAS'THEN'UXI'
END AS GRUPO
INTO GG_U_DOMESTICAS
FROM TT_PRO 
LEFT JOIN TD_DEP ON TD_DEP.CODTAB = TT_PRO.DEPART
LEFT JOIN TD_CL1 ON TD_CL1.CODTAB = TT_PRO.CLASS1
WHERE  TT_PRO.DEPART = 9