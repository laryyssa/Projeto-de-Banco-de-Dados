
-- DiminuirSalario()

CREATE FUNCTION DiminuirSalario(cpf VARCHAR(11), p DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE novo_salario DECIMAL(10,2);
    
    SELECT salario * (1 - (p / 100))
    INTO novo_salario
    FROM funcionario
    WHERE cpf = cpf;

    UPDATE funcionario
    SET salario = novo_salario
    WHERE cpf = cpf;

    RETURN novo_salario;
END;


create or replace FUNCTION
    DiminuirSalario(cpf VARCHAR, p INT) 
RETURNS DECIMAL(10,2)
AS $$
DECLARE
    novo_salario DECIMAL(10,2)
BEGIN
    SELECT novo_salario = salario * (1-(p/100))
    FROM funcionario f
    where f.cpf = cpf;

    UPDATE funcionario f
    SET salario = novo_salario
    where f.cpf = cpf

    return novo_salario
END;
$$ language plpgsql;

-- controle de faltas

CREATE TABLE controleFaltas (
    id_funcionario INT NOT NULL,
    data_falta DATE NOT NULL,
    justificativa VARCHAR(100),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id)
);

CREATE TRIGGER falta_trig
AFTER INSERT on controleFaltas
FOR EACH ROW
EXECUTE PROCEDURE controle_faltas();

create or replace FUNCTION 
    controle_faltas();
AS $$
DECLARE 
    faltas INT;
BEGIN
    SELECT count * INTO faltas
    FROM controleFaltas
    WHERE
        (id_funcionario = NEW.id_funcionario) AND
        (justificativa IS NULL)

    if faltas >= 5 THEN
        UPDATE funcionario
        SET ativo = 'N'
        WHERE id = NEW.id_funcionario
    END IF;

END $$

-- promover usuário

CREATE FUNCTION
    promoverUsuario(cpf varchar(11), novo_nivel INT)
RETURNS INT
AS $
DECLARE
    cargo_atual VARCHAR(10);
    nivel_atual INT;
    ultimo_nivel INT;
    periodo_anos INT;
    prox_nivel INT;

BEGIN
    SELECT 
        cargo INTO cargo_atual,
        nivel INTO nivel_atual,
    FROM funcionario f
    WHERE f.cpf = cpf

    if 




END
$$

