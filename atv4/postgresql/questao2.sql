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