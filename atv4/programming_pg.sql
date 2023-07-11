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


-- QUESTAO 2 ---------------------------------------------------------------------

CREATE TABLE controle_faltas (
    id_funcionario INT NOT NULL,
    data_falta DATE NOT NULL,
    justificativa VARCHAR(100),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
);


create or replace FUNCTION controle_faltas()
returns trigger
AS 
$$
DECLARE 
    faltas INT;
BEGIN
    SELECT count (*) INTO faltas
    FROM controle_faltas
    WHERE
        (id_funcionario = NEW.id_funcionario) AND
        (justificativa IS NULL);

    if faltas >= 5 THEN 
        UPDATE funcionario
        SET ativo = 'N'
        WHERE id = NEW.id_funcionario;
    END IF;
	
	return NEW;
END 
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER falta_trig
AFTER INSERT on controle_faltas
FOR EACH ROW 
EXECUTE PROCEDURE controle_faltas();

-- QUESTAO 3 ---------------------------------------------------------------------

create table status_func(
	id_funcionario int,
	cargo varchar(6),
	nivel int,
	data_promocao date,
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)	
)

CREATE FUNCTION promoverFuncionario(cpf_func varchar(11), novo_nivel INT)
RETURNS status_func
AS 
$$
DECLARE
    cargo_atual VARCHAR(6);
    nivel_atual INT;
    data_hoje date;
    data_prom date;
    id_func int;
	updated_row status_func;
BEGIN
    SELECT id INTO id_func
    FROM funcionario f
    WHERE f.cpf = cpf_func;
	
    SELECT 
		cargo,
		nivel,
		data_promocao
	INTO 
		cargo_atual,
		nivel_atual,
		data_prom
	FROM status_func sf
	WHERE sf.id_funcionario = id_func;

    data_hoje := current_date; 

    IF (nivel_atual IS NULL) AND (data_prom IS NULL) THEN
		INSERT INTO status_func (id_funcionario, cargo, nivel, data_promocao)
		VALUES (id_func, 'CARGO1',  1, current_date)
		RETURNING * INTO updated_row;

	ELSIF (novo_nivel = nivel_atual + 1) AND (data_hoje >= data_prom + INTERVAL '3 years') THEN
        IF novo_nivel <= 7 THEN
            UPDATE status_func
            SET 
				nivel = novo_nivel,
				data_promocao = data_hoje
            WHERE id_funcionario = id_func
			RETURNING * INTO updated_row;
        ELSE
            IF cargo_atual = 'CARGO1' THEN
                UPDATE status_func
                SET 
                    cargo = 'CARGO2',
                    nivel = 1,
					data_promocao = data_hoje
                WHERE id_funcionario = id_func
				RETURNING * INTO updated_row;
            ELSIF cargo_atual = 'CARGO2' THEN
                UPDATE status_func
                SET 
                    cargo = 'CARGO3',
                    nivel = 1,
					data_promocao = data_hoje
                WHERE id_funcionario = id_func
				RETURNING * INTO updated_row;
			END IF;
        END IF;
    END IF;
	
	RETURN updated_row;
	
END
$$
LANGUAGE plpgsql;

