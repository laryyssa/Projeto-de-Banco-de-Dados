CREATE TABLE funcionario (
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    sexo VARCHAR(10) NOT NULL,
    ddd INT,
    salario NUMERIC(10, 2),
    telefone VARCHAR(8),
    ativo VARCHAR(1),
    endereco VARCHAR(70) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    cidade VARCHAR(20) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    bairro VARCHAR(20) NOT NULL,
    pais VARCHAR(20) NOT NULL,
    login VARCHAR(12) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    news VARCHAR(8),
    id INT
);

-- insert data
CREATE TABLE funcionario (
    nome VARCHAR(60) ,
    email VARCHAR(60) ,
    sexo VARCHAR(10) ,
    ddd INT,
    salario NUMERIC(10, 2),
    telefone VARCHAR(8),
    ativo VARCHAR(1),
    endereco VARCHAR(70) ,
    cpf VARCHAR(11) ,
    cidade VARCHAR(20),
    estado VARCHAR(2) ,
    bairro VARCHAR(20) ,
    pais VARCHAR(20) ,
    login VARCHAR(12) ,
    senha VARCHAR(12) ,
    news VARCHAR(8),
    id INT primary key
);

insert into funcionario (nome, salario, ativo, cpf, id) values ('Ave Pfertner', 31075.84, 'N', '21714950151', 863710);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Nate Rookledge', 30788.04, 'S', '62698923582', 764647);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Freedman Addekin', 44138.15, 'N', '60881398317', 825003);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Grenville Davidowsky', 46455.32, 'N', '19113157625', 332869);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Winifred Stoneman', 15907.76, 'N', '24408538902', 593112);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Felita Westmerland', 34888.46, 'S', '57681877766', 582443);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Harrison Klais', 3021.83, 'N', '39972778329', 773657);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Eduino Peres', 28894.38, 'S', '97805990864', 866849);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Ivor Janusik', 38969.43, 'S', '45196466387', 9989);
insert into funcionario (nome, salario, ativo, cpf, id) values ('Rosemary Rookwell', 47108.48, 'N', '64970544694', 866729);

------- testes

select * from status_func

UPDATE status_func
SET data_promocao = '2020-06-28'
WHERE id_funcionario = (
    SELECT id
    FROM funcionario
    WHERE cpf = '45196466387'
);


select promoverFuncionario('45196466387',2)






