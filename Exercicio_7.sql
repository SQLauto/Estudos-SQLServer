7) CRIE UMA FUNCTION CHAMADA FUN_RETORNA_NUMERO_CLIENTE QUE DEVER� REALIZAR UM SELECT MAX NA TABELA DE CLIENTES E 
DEVER� RETORNAR ESSE VALOR SOMADO DE 1. ESSA FUN��O DEVER� SER CRIADA APENAS NO PACKAGE BODY.

CREATE OR REPLACE PACKAGE PKG_RETORNA_NUMERO_CLIENTE IS

FUNCTION FUN_RETORNA_NUMERO_CLIENTE (P_COD_CLIENTE IN CLIENTE.COD_CLIENTE%TYPE) RETURN CLIENTE.COD_CLIENTE%TYPE;

END;
/

CREATE OR REPLACE PAKAGE BODY PKG_RETORNA_NUMERO_CLIENTE IS

FUNCTION FUN_RETORNA_NUMERO_CLIENTE (P_COD_CLIENTE IN CLIENTE.COD_CLIENTE%TYPE) RETURN CLIENTE.COD_CLIENTE%TYPE IS

X.COD_CLIENTE%TYPE;

BEGIN

FUNCTION FUN_RETORNA_NUMERO_CLIENTE (P_COD_CLIENTE IN CLIENTE.COD_CLIENTE%TYPE)
		RETURN VARCHAR2 IS
		X VARCHAR2(10);
	BEGIN
		SELECT MAX(COD_CLIENTE) + 1  INTO X FROM CLIENTE WHERE COD_CLIENTE = P_COD_CLIENTE;
		RETURN X;
	END;
	END PKG_RETORNA_NUMERO_CLIENTE;



