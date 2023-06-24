create database loja_de_brinquedos;

use loja_de_brinquedos;

create table loja(
	id int not null,
    cep char(9),
    cnpj char(18),
    nome varchar(25),
    telefone CHAR(10),
    
    constraint loja_pk primary key(id),
    constraint telefone_uk unique(telefone),
    constraint loja_nome_uk unique(nome)
);

create table funcionarios(
	cpf char(14) not null,
    nome varchar(25) not null,
    idade int,
    cargo varchar(25),
    telefone char(10),
    id_loja int,
    
    constraint funcionarios_pk primary key(cpf),
    constraint loja_func_fk foreign key(id_loja) references loja(id)
);


create table cliente(
	registro int not null,
    cpf char(14) not null,
    nome varchar(25) not null,
    score int,
    
    constraint cliente_pk primary key(registro),
    constraint cpf_uk unique(cpf)
);

create table vendas(
	id int not null,
    data_hora datetime,
    valor int,
    cpf_funcionario char(14) not null,
    registro_cliente int not null,
    
    constraint vendas_pk primary key(id),
    constraint cpf_func_fk foreign key(cpf_funcionario) references funcionarios(cpf),
    constraint reg_cliente_fk foreign key(registro_cliente) references cliente(registro),
	constraint valor_ck check(valor>0)
);


create table brinquedos(
	id int not null,
    quantidade_estoque int,
    nome varchar(25) not null,
    fabricante varchar(30),
    material varchar(20),
    classificacao_indicativa varchar(20),
    vida_util varchar(15),
    
    constraint brinquedos_pk primary key(id)
);

create table boneco(
	id int unique not null,
    acessorios varchar(50),
    
    primary key(id),
    constraint boneco_fk foreign key(id) references brinquedos(id)
);

create table tabuleiro(
	id int unique not null,
    quantidade_pecas int,
    
    primary key(id),
    constraint tabuleiro_fk foreign key(id) references brinquedos(id)
);

create table cartas(
	id int unique not null,
    quantidade_cartas int,
    
    primary key(id),
    constraint cartas_fk foreign key(id) references brinquedos(id),
    constraint cartas_ck check(quantidade_cartas > 0)
);

create table carrinho(
	id int unique not null,
    pilha varchar(10),
    
    primary key(id),
    constraint carrinho_fk foreign key(id) references brinquedos(id)
);

create table dependente(
	cpf_funcionarios char(14) unique not null,
    cpf char(14) unique not null,
    nome varchar(20),
    idade int,
    parentesco varchar(25),
    
    primary key(cpf_funcionarios, cpf),
    constraint cpf_func_depend_fk foreign key(cpf_funcionarios) references funcionarios(cpf) on delete cascade
);

create table contem(
	id_venda int not null,
    id_brinquedo int not null,
    quantidade int,
    
    primary key(id_venda,id_brinquedo),
    constraint id_venda_fk foreign key(id_venda) references vendas(id),
    constraint id_brinquedo_fk foreign key(id_brinquedo) references brinquedos(id)
);

INSERT INTO loja VALUES (1, '12345-678', '12.345.678/0001-01', 'Loja A', 1234567890);
INSERT INTO loja VALUES (2, '98765-432', '98.765.432/0001-02', 'Loja B', 2345678901);
INSERT INTO loja VALUES (3, '54321-876', '54.321.876/0001-03', 'Loja C', 3456789012);
INSERT INTO loja VALUES (4, '87654-321', '87.654.321/0001-04', 'Loja D', 4567890123);
INSERT INTO loja VALUES (5, '13579-642', '13.579.642/0001-05', 'Loja E', 5678901234);
INSERT INTO loja VALUES (6, '24680-753', '24.680.753/0001-06', 'Loja F', 6789012345);
INSERT INTO loja VALUES (7, '97531-246', '97.531.246/0001-07', 'Loja G', 7890123456);
INSERT INTO loja VALUES (8, '86420-975', '86.420.975/0001-08', 'Loja H', 8901234567);
INSERT INTO loja VALUES (9, '35792-084', '35.792.084/0001-09', 'Loja I', 9012345678);
INSERT INTO loja VALUES (10,'78045-217', '78.045.217/0001-10', 'Loja J', 0123456789);

INSERT INTO funcionarios VALUES ('111.111.111-11', 'Funcionário A', 30, 'Cargo A', 1234567890, 1);
INSERT INTO funcionarios VALUES ('222.222.222-22', 'Funcionário B', 35, 'Cargo B', 2345678901, 2);
INSERT INTO funcionarios VALUES ('333.333.333-33', 'Funcionário C', 28, 'Cargo C', 3456789012, 1);
INSERT INTO funcionarios VALUES ('444.444.444-44', 'Funcionário D', 32, 'Cargo D', 4567890123, 3);
INSERT INTO funcionarios VALUES ('555.555.555-55', 'Funcionário E', 27, 'Cargo E', 5678901234, 2);
INSERT INTO funcionarios VALUES ('666.666.666-66', 'Funcionário F', 31, 'Cargo F', 6789012345, 1);
INSERT INTO funcionarios VALUES ('777.777.777-77', 'Funcionário G', 29, 'Cargo G', 7890123456, 3);
INSERT INTO funcionarios VALUES ('888.888.888-88', 'Funcionário H', 33, 'Cargo H', 8901234567, 2);
INSERT INTO funcionarios VALUES ('999.999.999-99', 'Funcionário I', 26, 'Cargo I', 9012345678, 1);
INSERT INTO funcionarios VALUES ('000.000.000-00', 'Funcionário J', 34, 'Cargo J', 0123456789, 3);

INSERT INTO cliente VALUES (1, '111.111.111-11', 'Cliente A', 500);
INSERT INTO cliente VALUES (2, '222.222.222-22', 'Cliente B', 700);
INSERT INTO cliente VALUES (3, '333.333.333-33', 'Cliente C', 600);
INSERT INTO cliente VALUES (4, '444.444.444-44', 'Cliente D', 550);
INSERT INTO cliente VALUES (5, '555.555.555-55', 'Cliente E', 800);
INSERT INTO cliente VALUES (6, '666.666.666-66', 'Cliente F', 450);
INSERT INTO cliente VALUES (7, '777.777.777-77', 'Cliente G', 900);
INSERT INTO cliente VALUES (8, '888.888.888-88', 'Cliente H', 650);
INSERT INTO cliente VALUES (9, '999.999.999-99', 'Cliente I', 700);
INSERT INTO cliente VALUES (10,'000.000.000-00', 'Cliente J', 550);

INSERT INTO vendas VALUES (1, '2023-06-01 10:00:00', 100, '111.111.111-11', 1);
INSERT INTO vendas VALUES (2, '2023-06-02 14:30:00', 150, '222.222.222-22', 2);
INSERT INTO vendas VALUES (3, '2023-06-03 16:45:00', 200, '333.333.333-33', 3);
INSERT INTO vendas VALUES (4, '2023-06-04 12:15:00', 120, '444.444.444-44', 4);
INSERT INTO vendas VALUES (5, '2023-06-05 11:30:00', 180, '555.555.555-55', 5);
INSERT INTO vendas VALUES (6, '2023-06-06 09:45:00', 90, '666.666.666-66', 6);
INSERT INTO vendas VALUES (7, '2023-06-07 13:20:00', 170, '777.777.777-77', 7);
INSERT INTO vendas VALUES (8, '2023-06-08 15:10:00', 140, '888.888.888-88', 8);
INSERT INTO vendas VALUES (9, '2023-06-09 10:45:00', 110, '999.999.999-99', 9);
INSERT INTO vendas VALUES (10, '2023-06-10 17:00:00', 160, '000.000.000-00', 10);

INSERT INTO brinquedos VALUES (1, 10, 'Carrinho de Controle', 'Fabricante A', 'Plástico', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (2, 5, 'Boneca de Pano', 'Fabricante B', 'Tecido', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (3, 8, 'Quebra-Cabeça', 'Fabricante C', 'Papelão', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (4, 12, 'Jogo de Tabuleiro', 'Fabricante D', 'Papelão', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (5, 3, 'Cubo Mágico', 'Fabricante E', 'Plástico', 'Acima de 3 anos', 'Indeterminada');
INSERT INTO brinquedos VALUES (6, 6, 'Bola de Futebol', 'Fabricante F', 'Couro', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (7, 15, 'Pelúcia de Animal', 'Fabricante G', 'Tecido', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (8, 20, 'Kit de Construção', 'Fabricante H', 'Plástico', 'Livre', 'Indeterminada');
INSERT INTO brinquedos VALUES (9, 7, 'Patins', 'Fabricante I', 'Metal e Plástico', 'Acima de 5 anos', 'Indeterminada');
INSERT INTO brinquedos VALUES (10, 4, 'Carrinho de Brinquedo', 'Fabricante J', 'Plástico', 'Livre', 'Indeterminada');

INSERT INTO boneco VALUES (1, 'Espada, escudo');
INSERT INTO boneco VALUES (2, 'Capa, lança');
INSERT INTO boneco VALUES (3, 'Óculos, varinha');
INSERT INTO boneco VALUES (4, 'Chapéu, bengala');
INSERT INTO boneco VALUES (5, 'Asas, arco e flecha');
INSERT INTO boneco VALUES (6, 'Colar, coroa');
INSERT INTO boneco VALUES (7, 'Cinto, escudo');
INSERT INTO boneco VALUES (8, 'Chapéu, espada');
INSERT INTO boneco VALUES (9, 'Martelo, capacete');
INSERT INTO boneco VALUES (10, 'Escudo, lança');


INSERT INTO tabuleiro VALUES (1, 100);
INSERT INTO tabuleiro VALUES (2, 200);
INSERT INTO tabuleiro VALUES (3, 150);
INSERT INTO tabuleiro VALUES (4, 120);
INSERT INTO tabuleiro VALUES (5, 180);
INSERT INTO tabuleiro VALUES (6, 90);
INSERT INTO tabuleiro VALUES (7, 170);
INSERT INTO tabuleiro VALUES (8, 140);
INSERT INTO tabuleiro VALUES (9, 110);
INSERT INTO tabuleiro VALUES (10, 160);

INSERT INTO cartas VALUES (1, 50);
INSERT INTO cartas VALUES (2, 100);
INSERT INTO cartas VALUES (3, 75);
INSERT INTO cartas VALUES (4, 60);
INSERT INTO cartas VALUES (5, 90);
INSERT INTO cartas VALUES (6, 45);
INSERT INTO cartas VALUES (7, 85);
INSERT INTO cartas VALUES (8, 70);
INSERT INTO cartas VALUES (9, 55);
INSERT INTO cartas VALUES (10, 80);
select * from cartas;

INSERT INTO carrinho VALUES (1, 'Sim');
INSERT INTO carrinho VALUES (2, 'Não');
INSERT INTO carrinho VALUES (3, 'Sim');
INSERT INTO carrinho VALUES (4, 'Não');
INSERT INTO carrinho VALUES (5, 'Sim');
INSERT INTO carrinho VALUES (6, 'Sim');
INSERT INTO carrinho VALUES (7, 'Não');
INSERT INTO carrinho VALUES (8, 'Sim');
INSERT INTO carrinho VALUES (9, 'Sim');
INSERT INTO carrinho VALUES (10, 'Não');

INSERT INTO dependente VALUES ('111.111.111-11', '111.111.111-11', 'Dependente A', 10, 'Filho');
INSERT INTO dependente VALUES ('666.666.666-66', '222.222.222-22', 'Dependente B', 8, 'Filha');
INSERT INTO dependente VALUES ('222.222.222-22', '333.333.333-33', 'Dependente C', 12, 'Filho');
INSERT INTO dependente VALUES ('777.777.777-77', '444.444.444-44', 'Dependente D', 6, 'Filho');
INSERT INTO dependente VALUES ('333.333.333-33', '555.555.555-55', 'Dependente E', 9, 'Filho');
INSERT INTO dependente VALUES ('888.888.888-88', '666.666.666-66', 'Dependente F', 11, 'Filha');
INSERT INTO dependente VALUES ('444.444.444-44', '777.777.777-77', 'Dependente G', 7, 'Filho');
INSERT INTO dependente VALUES ('999.999.999-99', '888.888.888-88', 'Dependente H', 10, 'Filha');
INSERT INTO dependente VALUES ('555.555.555-55', '999.999.999-99', 'Dependente I', 8, 'Filho');
INSERT INTO dependente VALUES ('000.000.000-00', '000.000.000-00', 'Dependente J', 12, 'Filha');

INSERT INTO contem VALUES (1, 1, 2);
INSERT INTO contem VALUES (1, 2, 1);
INSERT INTO contem VALUES (2, 3, 3);
INSERT INTO contem VALUES (2, 4, 1);
INSERT INTO contem VALUES (3, 1, 2);
INSERT INTO contem VALUES (3, 5, 2);
INSERT INTO contem VALUES (4, 6, 1);
INSERT INTO contem VALUES (4, 3, 2);
INSERT INTO contem VALUES (5, 2, 3);
INSERT INTO contem VALUES (5, 7, 1);


UPDATE cliente SET score = 600 WHERE registro = 1;
UPDATE cliente SET score = 800 WHERE registro = 2;
UPDATE cliente SET score = 550 WHERE registro = 3;
UPDATE cliente SET score = 700 WHERE registro = 4;
UPDATE cliente SET score = 450 WHERE registro = 5;
UPDATE cliente SET score = 950 WHERE registro = 6;
UPDATE cliente SET score = 650 WHERE registro = 7;
UPDATE cliente SET score = 700 WHERE registro = 8;
UPDATE cliente SET score = 750 WHERE registro = 9;
UPDATE cliente SET score = 600 WHERE registro = 10;

select * from boneco;
select * from brinquedos;
select * from carrinho;
select * from cartas;
select * from cliente;
select * from contem;
select * from dependente;
select * from funcionarios;
select * from loja;
select * from tabuleiro;
select * from vendas;