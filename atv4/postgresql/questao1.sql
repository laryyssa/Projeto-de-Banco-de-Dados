-- QUESTAO 1 ---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION DiminuirSalario(cpf_func VARCHAR, porc INT) 
RETURNS NUMERIC(10,2) AS 
$$
DECLARE
    novo_salario NUMERIC(10,2);
	salario_atual NUMERIC(10,2);
	var NUMERIC(10,2);
BEGIN
    SELECT salario INTO salario_atual
    FROM funcionario f
    WHERE f.cpf = cpf_func;
	
	var = (100-porc*1.0)/100;
	novo_salario := salario_atual * var;

    UPDATE funcionario f
    SET salario = novo_salario
    WHERE f.cpf = cpf_func;

    RETURN novo_salario;
END;
$$ 
LANGUAGE plpgsql;
