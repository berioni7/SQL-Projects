-- trabalho #3: Gestão de ativos digitais e capacidade de armazenamento

/* Objetivo: O objetivo deste projeto é simular um sistema de gerenciamento de arquivos e servidores, 
focando na utilização de tipos de dados numéricos que representam tamanhos (bytes) e estados (BIT/TINYINT) e substituindo as consultas de junção para praticar OUTER JOIN e CROSS JOIN. */

-- Fase #1: criação do DB, tabelas e relacionamentos

create database if not exists AtivosDigitais;

use AtivosDigitais;

create table Arquivos -- registrar os arquivos digitais
(
	arquivo_id bigint,
    primary key (arquivo_id),
    nome_arquivo VARCHAR(100),
    tamanho_bytes bigint,
    constraint tamanho_bytes_check check (tamanho_bytes >= 0),
    is_criptografado tinyint(1),
    extenso VARCHAR(50)
);

create table Servidores -- regritra todos os servidores de armazenamento
(
	servidor_id smallint,
    primary key (servidor_id),
    nome_servidor varchar(50) unique,
    capacidade_gb int,
    localizacao varchar(50)
);

create table Alocacoes -- (tabela intermediária) vai ligar, numa relação N:M, arquivos e servidores
(
	alocacao_id int,
    primary key (alocacao_id),
    id_arquivo_fk bigint,
    foreign key (id_arquivo_fk) references Arquivos (arquivo_id),
    id_servidores_fk smallint,
    foreign key (id_servidores_fk) references Servidores (servidor_id),
    data_alocacao date
);

-- Fase #2: Inserção de dados

insert into Servidores (servidor_id, nome_servidor, capacidade_gb, localização) values (1, 'ServerA', 80, 'GestãoServerA');
insert into Servidores (servidor_id, nome_servidor, capacidade_gb, localização) values (2, 'ServerB', 90, 'GestãoServerB');
insert into Servidores (servidor_id, nome_servidor, capacidade_gb, localização) values (3, 'ServerC', 10, 'GestãoServerC');

insert into Arquivos (arquivos_id, nome_arquivo, tamanhos_bytes, is_criptografado, extenso) values (1, 'Imagem1', 15882390, 1, '.png');
insert into Arquivos (arquivos_id, nome_arquivo, tamanhos_bytes, is_criptografado, extenso) values (2, 'Imagem2', 15879392, 0, '.png');
insert into Arquivos (arquivos_id, nome_arquivo, tamanhos_bytes, is_criptografado, extenso) values (3, 'Imagem3', 13862794, 1, '.jpeg');

insert into Alocacoes (alocacao_id, id_arquivo_fk, id_servidor_fk, data_alocacao) values (1,1,1,'2025-03-29');
insert into Alocacoes (alocacao_id, id_arquivo_fk, id_servidor_fk, data_alocacao) values (2,2,2,'2025-04-14');
insert into Alocacoes (alocacao_id, id_arquivo_fk, id_servidor_fk, data_alocacao) values (3,3,1,'2025-09-13');

SELECT nome_arquivo, tamanho_bytes FROM Arquivos WHERE is_criptografado = 1 ORDER BY arquivo_id desc;

SELECT S.nome_servidor AS 'NOME DO SERVIDOR', A.nome_arquivos_fk AS 'NOME DO ARQUIVO'
FROM Servidores S
LEFT OUTER JOIN Alocacoes a ON  S.servidor_id = a.id_servidores_fk 
LEFT OUTER JOIN Arquivos A ON a.id_arquivo_fk = A.arquivo_id;

SELECT S.nome_servidor AS 'NOME DO SERVIDOR', A.nome_arquivo AS 'NOME DO ARQUIVO', A.tamanho_bytes AS 'TAMANHO'
FROM Servidores S
CROSS JOIN Arquivos A;







