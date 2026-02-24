-- trabalho #2: Gestão de Eventos e Participantes

/*O objetivo é criar um banco de dados que registre eventos e as pessoas que se inscreveram neles. 
O foco estará na integridade dos dados (PK/FK) e na recuperação de informações (INNER JOIN).
*/

# FASE 1: Construção do DB e tabelas/ criando relacionamentos;

create database if not exists Gestão;

use Gestão;

create table Organizadores
(	-- Relacionamento: um organizador pode ter vários eventos -> 1:N
	organizador_id int,
    primary key (organizador_id),
    nome varchar (50),
    email varchar (100) unique
);

create table Eventos
( -- Relacionamento: um evento pode ter apenas um organizador principal -> N:1
	evento_id int,
    primary key (evento_id),
    titulo varchar(50),
    data_ date,
    capacidade int,
    constraint capacidade_maior_que_zero check (capacidade > 0),
    id_organizador_fk int,
    foreign key (id_organizador_fk) references Organizadores (organizador_id)
);

create table Participantes
( -- Relacionamento: um participante pode se inscrever em vários eventos. Um evento tem vários participantes -> N:M
	participante_id int,
    primary key (participante_id),
    nome varchar (100),
    cpf varchar(11) unique,
    data_cadastro date,
    ativo bool
);

create table Inscricoes 
(
	inscricao_id int,
    primary key (inscricao_id),
    id_participante_fk int,
    foreign key (id_participante_fk) references Participantes (participante_id),
    id_evento_fk int,
    foreign key (id_evento_fk) references Eventos (evento_id),
    data_inscricao DATETIME
);

# Fase 2: Inserção de dados

insert into Organizadores (organizador_id, nome, email) values (1,"Gabriel Berioni","gabrielberioni3@gmail.com");
insert into Organizadores (organizador_id, nome, email) values (2,"Carlos Almeida","carlosmeidaal@gmail.com");
insert into Organizadores (organizador_id, nome, email) values (3,"Igor Bastos","igaobastos@gmail.com");

insert into Eventos (evento_id, titulo, data_, capacidade, id_organizador_fk) values (1,"ExpoTech", "2025-10-01", 500, 1);
insert into Eventos (evento_id, titulo, data_, capacidade, id_organizador_fk) values (2,"ExpoBio", "2025-10-23", 350, 2);
insert into Eventos (evento_id, titulo, data_, capacidade, id_organizador_fk) values (3,"ExpoEco", "2025-11-05", 400, 3);

insert into Participantes (participante_id, nome, cpf, data_cadastro, ativo) values (1, "Samuel Barros","5456189308", "2025-08-17", true);
insert into Participantes (participante_id, nome, cpf, data_cadastro, ativo) values (2, "Maria Goldin","5765309167", "2025-01-21", true);
insert into Participantes (participante_id, nome, cpf, data_cadastro, ativo) values (3, "Daniel Macedo","5135779026", "2025-04-02", true);
insert into Participantes (participante_id, nome, cpf, data_cadastro, ativo) values (4, "Amanda Larissa","5398765240", "2025-12-31", false);
insert into Participantes (participante_id, nome, cpf, data_cadastro, ativo) values (5, "Giovana Label","5987345129", "2025-05-08", false);

insert into Inscricoes (inscricao_id, id_participante_fk, id_event_fk, data_inscricao) values (1,1,1,"2025-02-04");
insert into Inscricoes (inscricao_id, id_participante_fk, id_event_fk, data_inscricao) values (2,2,2,"2025-03-18");
insert into Inscricoes (inscricao_id, id_participante_fk, id_event_fk, data_inscricao) values (3,3,3,"2025-07-21");
insert into Inscricoes (inscricao_id, id_participante_fk, id_event_fk, data_inscricao) values (4,4,4,"2025-11-29");
insert into Inscricoes (inscricao_id, id_participante_fk, id_event_fk, data_inscricao) values (5,5,5,"2025-03-22");

# Fase 3: Consulta de dados

SELECT * FROM Participantes WHERE ativo = true ORDER BY data_cadastro asc; -- mostrar todos os partipantes com cadastro ativo e ordenados pela data mais antiga até a mais nova

SELECT titulo FROM Eventos INNER JOIN Organizadores ON Eventos.id_organizador_fk = Organizadores.organizador_id; -- seleciontar, juntar e mostrar o titulo do evento ao lado do nome dos organizadores

SELECT E.titulo AS "Evento", P.nome AS "Participante", O.nome AS "Organizadores" FROM Eventos E INNER JOIN Organizadores O ON E.id_organizador_fk = O.organizador_id
INNER JOIN Inscricoes I ON E.evento_id = I.id_evento_fk
INNER JOIN Participantes P ON I.id_participante_fk = P.participante_id; -- seleciono, junto e mostro os dados como uma lista de presença: titulo evento, nome participante.alter

-- 1 -- escreva uma consulta que utiliza inner join entre eventos e organizadores para listar o titulo do evento e data de evento para apenas os eventos organizados por carlos almeida

SELECT E.titulo AS "TÍTULO DO EVENTO", E.data_ AS "DATA DO EVENTO" 
FROM Eventos E 
INNER JOIN Organizadores O ON E.id_organizador_fk = O.organizador_id
WHERE O.nome = "Carlos Almeida";

/* -- 2 -- escreva uma consulta que utilize dois INNER JOIN entre eventos, inscricoes e participantes para listar o titulo do evento e o nome do participante para apenas os participantes cujo 
participante_id seja menor que 3 */
 
SELECT E.titulo AS "TÍTULO DO EVENTO", P.nome AS "NOME DO PARTICIPANTE"
FROM Eventos E
INNER JOIN Inscricoes I ON E.evento_id = I.id_evento_fk
INNER JOIN Participantes P ON I.id_participante_fk = P.participante_id
WHERE P.participante_id < 3;

/* -- 3 -- escreva uma consulta que utilize INNER JOIN para mostrar o nome do participante, o CPF, e o titulo do evento. A lista deve inlcuir apenas os participantes que estao ativos e deve ser 
ordenada pela data de inscrição do mais recente para o mais antigo */

SELECT P.nome AS "NOME DO PARTICIPANTE", P.cpf AS "CPF DO PARTICIPANTE", E.titulo AS "TÍTULO DO EVENTO"
FROM Participantes P 
INNER JOIN Inscricoes I ON P.participante_id = I.id_participante_fk
INNER JOIN Eventos E ON I.id_evento_fk = E.evento_id
WHERE P.ativo = true
ORDER BY data_inscricao desc;

/* -- 4 -- escreva uma consulta que utilize INNER JOIN para mostrar o nome do organizador e titulo do evento para apenas os eventos que tem capacidade superior a 350 pessoas */

SELECT O.nome AS "NOME DO ORGANIZADOR", E.titulo AS "TÍTULO DO EVENTO" 
FROM Organizadores O
INNER JOIN Eventos E ON E.id_organizador_fk = O.organizador_id
WHERE E.capacidade >= 350;

/* -- 5 -- escreva uma consulta que use dois INNER JOIN para mostrar o nome do participante, sua data de cadastro e data de inscrição. adicione um filtro where que mostre apenas
os participantes que se inscreveram após a data de "2025-06-01" */

SELECT P.nome AS "NOME DO PARTICIPANTE", P.data_cadastro AS "DATA CADASTRO PARTICIPANTE", I.data_inscricao AS "DATA DE INSCRIÇÃO"
FROM Participantes P
INNER JOIN Inscricoes I ON I.id_participante_fk = P.participante_id
WHERE I.data_inscricao > "2025-06-01";





