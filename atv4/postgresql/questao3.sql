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

