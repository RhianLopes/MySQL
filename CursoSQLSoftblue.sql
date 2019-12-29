CREATE DATABASE curso;

USE curso;		

CREATE TABLE funcionarios
(
id int unsigned not null auto_increment,
nome varchar(50) not null,
salario double not null default '0',
departamento varchar(50) not null,
primary key(id)

);


CREATE TABLE veiculos
(
id int unsigned not null auto_increment,
funcionario_id int unsigned default null,
veiculo varchar(40) not null default ' ',
placa varchar(10) not null default ' ',
primary key(id),
CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios(id)
);

CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);


INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, 'Fernando', 1400, 'TI');
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, 'Guilherme', 2500, 'Juridico');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Fábio', 1700, 'TI');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Jose', 1800, 'Marketing');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Isabela', 2200, 'Juridico');

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario > 2000;

UPDATE funcionarios SET salario = salario * 1.1 WHERE id=1;

SET SQL_SAFE_UPDATES =0;
update funcionarios set salario = salario * 1.1;
update funcionarios set salario = round(salario * 1.1, 2);


delete from funcionarios where id = 4;


insert into veiculos (funcionario_id, veiculo, placa) values ( 1, 'Ford Fiesta', 'IDS 2019');
insert into veiculos (funcionario_id, veiculo, placa) values ( 5, 'Ford Ka', 'IWS 0099');

SELECT * FROM veiculos;


update veiculos set funcionario_id = 5 where id = 2;

insert into salarios (faixa, inicio, fim) values ('Analista Jr', 1000, 2000);
insert into salarios (faixa, inicio, fim) values ('Analista Pleno', 2000, 4000);

select * from salarios;

select * from funcionarios f where salario > 2000;

select nome as 'funcionario', salario from  funcionarios f where f.salario > 2000;

select * from funcionarios where nome = 'Guilherme'
union
select * from funcionarios where id = 5;

delete from veiculos where id = 1;
delete from veiculos where id = 2;
select * from veiculos;
select * from veiculos where veiculo is null;

select * from veiculos id, veiculos;
select * from funcionarios;
select * from veiculos;


use curso;

select * from funcionarios;
select* from veiculos;

select funcionarios.nome, veiculos.veiculo from funcionarios inner join veiculos on veiculos.funcionario_id = funcionarios.id and funcionarios.id < 5;


/*MOSTRA QUEM DOS FUNCIONARIOS TEM VEICULOS*/
select * from funcionarios f inner join veiculos v on v.funcionario_id = f.id;

/*MOSTRA TODOS OS FUNCIONARIOS TENDO OU NAO VEICULO, CASO NAO NULL*/
select * from funcionarios f left join veiculos v on v.funcionario_id = f.id;

/*MOSTRA TODOS OS VEICULOS TENDO FUNCIONARIO OU NAO, CASO NAO NULL*/
select * from funcionarios f right join veiculos v on v.funcionario_id = f.id;



/*NO MYSQL NAO TEM FULL JOIN, ENTAO FAZ UM UNION ENTRE LEFT AND RIGHT*/
/*NO FULL JOIN NO CASO UNION, MOSTRA TUDO DAS DUAS TABELAS, NAO REPETE TABELA
O UNION ALL REPETE OS REGISTROS*/
select * from funcionarios f left join veiculos v on v.funcionario_id = f.id
union
select * from funcionarios f right join veiculos v on v.funcionario_id = f.id;


insert into veiculos (funcionario_id, veiculo, placa) values ( null, " Moto ",  "SB-0003");

select * from veiculos;

CREATE TABLE cpfs
(
id int unsigned not null,
cpf varchar(14) not null,
primary key(id),
constraint fk_cpf foreign key (id) references funcionarios(id)
);

select*from funcionarios;

insert into cpfs(id,cpf) values (1,'111.111.111-11');
insert into cpfs(id,cpf) values (2,'222.222.222-22');
insert into cpfs(id,cpf) values (3,'333.333.333-33');
insert into cpfs(id,cpf) values (5,'555.555.555-55');

select*from cpfs;

/*AMBAS OPÇOES ABAIXO DAO O MESMO VALOR, O COMANDO USING USA O CAMPO ID, PRESENTE NAS DUAS TABELAS, 
MAS PARA ISSO ELES DEVEM EXISTIR E POSSUIR IDS IGUAIS*/
select*from funcionarios inner join cpfs on funcionarios.id = cpfs.id; 
select*from funcionarios inner join cpfs using(id); 


CREATE TABLE clientes
(
id int unsigned not null auto_increment,
nome varchar(45)not null,
quem_indicou int unsigned,
primary key (id),
constraint fk_quem_indicou foreign key (quem_indicou) references clientes(id)
);


insert into clientes (nome, quem_indicou) values ('Andre', null);
insert into clientes (nome, quem_indicou) values ('Samuel', 1);
insert into clientes (nome, quem_indicou) values ('Carlos', 2);
insert into clientes (nome, quem_indicou) values ('Rafael', 1);

select*from clientes;	

/*RELACIONAMENTO ENTRE A MESMA TABELA, PARA ISSO DEVE SER UTILIZADO O USO DE APELIDOS, CLIENTES A E CLIENTES B*/
select a.nome, b.nome from clientes a join clientes b on a.quem_indicou = b.id;
select a.nome AS CLIENTE, b.nome as QUEM_INDICOU from clientes a join clientes b on a.quem_indicou = b.id;
select a.nome AS CLIENTE, b.nome as "QUEM INDICOU" from clientes a join clientes b on a.quem_indicou = b.id;

/*RELACIONAMENTO TRIPLO OU MAIS*/
select * from funcionarios inner join veiculos on veiculos.funcionario_id = funcionarios.id inner join cpfs on cpfs.id = funcionarios.id;

select*from funcionarios;

/*CRIAR VISAO, ELA NAO OCUPA ESPAÇO, mudar apenas a view e nao em todos os comandos*/
create view funcionarios_a	as select * from funcionarios where salario >= 1700;
select * from funcionarios_a;


drop view funcionarios_a;
create view funcionarios_a	as select * from funcionarios where salario >= 2000;

select * from funcionarios;

/*COUNT*/
select count(*) from funcionarios;
select count(*) from funcionarios where salario > 1600;
select count(*) from funcionarios where salario > 1600 and departamento = 'Juridico';

/*SUM*/
select sum(salario) from funcionarios;
select sum(salario) from funcionarios where departamento = 'TI';

/*AVG = MEDIA*/
select avg(salario) from funcionarios;
select avg(salario) from funcionarios where departamento = 'TI';

/*MAX*/
select max(salario) from funcionarios;
select max(salario) from funcionarios where departamento = 'TI';

/*MIN*/
select min(salario) from funcionarios;
select min(salario) from funcionarios where departamento = 'TI';

select departamento from funcionarios;
/*DISTINCT*/
select distinct(departamento) from funcionarios;

/*ORDER BY*/
select *from funcionarios;
select *from funcionarios order by nome;
select *from funcionarios order by nome desc;
select *from funcionarios order by salario;
select *from funcionarios order by departamento;
select *from funcionarios order by departamento, salario;
select *from funcionarios order by departamento desc, salario desc;


/*LIMIT*/
select * from funcionarios limit 2; 

/*OFF SET*/
select * from funcionarios limit 2 offset 1;
select * from funcionarios limit 1,2;


/*GROUP BY*/
select avg(salario) from funcionarios;
select avg(salario) from funcionarios where departamento = 'TI';
select avg(salario) from funcionarios where departamento = 'Juridico';
select departamento, avg(salario) from funcionarios group by departamento;

/*HAVING*/
select departamento, avg(salario) from funcionarios group by departamento having avg(salario) > 2000;
select departamento from funcionarios group by departamento having avg(salario) > 2000;

/*SUBQUERIE*/
select nome from funcionarios where departamento in ('TI', 'Juridico');
select nome from funcionarios where departamento in 
(
select departamento from funcionarios group by departamento having avg(salario) > 2000
);
/*IP ESPECIFICO PARA ACESSAR*/
/*create user 'andre'@'200.200.190.190' identified by 'milani123456';*/

/*APENAS DESTA MAQUINA PODE ACESSAR*/
/*create user 'andre'@'localhost' identified by 'milani123456';*/

/*QUALQUER IP*/
/*create user 'andre'@'%' identified by 'milani123456';*/

create user 'andre'@'localhost' identified by 'milani123456';
grant all on curso.* to 'andre'@'localhost';

create user 'andre'@'%' identified by 'andrevigem';

/*DAR ACESSO DE APENAS VER OU DE INSERIR DADOS*/
grant select on curso.* to 'andre'@'%';
/*grant insert on curso.* to 'andre'@'%';*/
grant insert on curso.funcionarios to 'andre'@'%';

/*REMOVER O ACESSO*/
revoke insert on curso.funcionarios from 'andre'@'%';
revoke select on curso.* from 'andre'@'%';

grant insert on curso.funcionarios to 'andre'@'%';
grant insert on curso.veiculos to 'andre'@'%';
revoke insert on curso.funcionarios from 'andre'@'%';
revoke insert on curso.veiculos from 'andre'@'%';

revoke all on curso.* from 'andre'@'localhost';

drop user 'andre'@'localhost';
drop user 'andre'@'%';

create user 'andre'@'%' identified by 'andrevigem';
grant select on curso.* to 'andre'@'%';
grant insert on curso.funcionarios to 'andre'@'%';

/*ver os usuarios */
select User from mysql.user;

/*ver o poder do usuario*/
show grants for 'andre'@'%';

revoke select on curso.* from 'andre'@'%';
grant insert on curso.funcionarios to 'andre'@'%';
drop user 'andre'@'%';

SELECT customers.name, customers.street FROM customers WHERE customers.state = 'RS';

select*from funcionarios;
select*from veiculos;


/*TRASAÇÃO DTL*/
/*CONSULTAR SHOW ENGINES PARA UM QUE ACEITE TRANSAÇOES NO CASO O INNODB SUPORTA*/
show engines;

create table contas
(
id int unsigned not null auto_increment,
titular varchar(45) not null,
saldo double not null,
primary key(id) 
) engine InnoDB;

insert into contas(titular , saldo) values ('Andre', 1000);
insert into contas(titular , saldo) values ('Carlos', 2000);


select * from contas;

start transaction;
update contas set saldo = saldo - 100 where id = 1;
update contas set saldo = saldo + 100 where id = 2;
rollback;

start transaction;
update contas set saldo = saldo - 100 where id = 1;
update contas set saldo = saldo + 100 where id = 2;
commit;

/*STORE PROCEDURES*/

create table pedidos
(
id int unsigned not null auto_increment,
descrição varchar(100) not null,
valor double not null default '0',
pago varchar(3) not null default 'Não',
primary key(id)
);

insert into pedidos(descrição, valor) values ('TV',3000);
insert into pedidos(descrição, valor) values ('Geladeira', 1400);
insert into pedidos(descrição, valor) values ('DVD Player',300);

select*from pedidos;

/*CLICAR COM O BOTAO DIREITO EM STORE PROCEDURES E CRIAR UM*/
call limpa_pedidos();

create table estoque
(
id int unsigned not null auto_increment,
 descrição varchar(50) not null,
 quantidade int not null,
 primary key(id)
);
/*TRIGGER*/
create trigger gatilho_limpa_pedido before insert on estoque for each row call limpa_pedidos();

select*from pedidos;

insert into pedidos(descrição, valor) values ('TV',3000);
insert into pedidos(descrição, valor) values ('Geladeira', 1400);
insert into pedidos(descrição, valor) values ('DVD Player',300);

insert into estoque(descrição, quantidade) values ('Fogão', 5);

select * from estoque;

delete from estoque where id = 2;

insert into pedidos(descrição, valor) values ('TV',3000);
insert into pedidos(descrição, valor) values ('Geladeira', 1400);
insert into pedidos(descrição, valor) values ('DVD Player',300);

update pedidos set pago = 'Sim' where id = 8;

select*from pedidos;

insert into estoque(descrição, quantidade) values ('Forno', 3);

select*from pedidos;


