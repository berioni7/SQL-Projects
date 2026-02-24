-- trabalho #5: Criar e gerenciar uma biblioteca musical

/*O objetivo é criar um banco de dados que gerencie uma biblioteca musical e suas respectivas tabelas.
O foco estará na consulta dos dados, usando conceitos como joins, subqueries, agregação e funções built-in.
*/

# FASE 1: Construção do DB e tabelas/ criando relacionamentos;

DROP DATABASE IF EXISTS biblioteca_musical;
CREATE DATABASE biblioteca_musical;
USE biblioteca_musical;

create table genero (
	id_genero int,
    primary key (id_genero),
    nome_do_genero varchar(50)
);

create table artista (
	id_artista int,
    primary key (id_artista),
    nome_artista varchar(100),
    pais_origem varchar (100)
);

create table album (
	id_album int,
    primary key (id_album),
    titulo_album varchar(100),
    ano_lancamento year,
    numero_faixas int,
    id_artistas_fk int,
    foreign key (id_artistas_fk) references artista (id_artista)
);

create table faixa (
	id_faixa int,
    primary key (id_faixa),
    titulo_faixa varchar(50),
    duracao time,
    preco decimal,
    id_album_fk int,
    foreign key (id_album_fk) references album (id_album),
    id_genero_fk int,
    foreign key (id_genero_fk) references genero (id_genero)    
);

# FASE 2: Inserção de dados;

insert into genero (id_genero, nome_do_genero) values (4, 'Numetal');
insert into genero (id_genero, nome_do_genero) values (3, 'Heavy-metal');
insert into genero (id_genero, nome_do_genero) values (1, 'Grunge');
insert into genero (id_genero, nome_do_genero) values (2, 'Shoegaze');
insert into genero (id_genero, nome_do_genero) values (0, 'Indie');

insert into artista (id_artista, nome_artista, pais_origem) values (0, 'Deftones', 'Argentina');
insert into artista (id_artista, nome_artista, pais_origem) values (1, 'Metallica', 'EUA');
insert into artista (id_artista, nome_artista, pais_origem) values (2, 'Alice in Chains', 'EUA');
insert into artista (id_artista, nome_artista, pais_origem) values (3, 'Cocteau Twins', 'Escócia');
insert into artista (id_artista, nome_artista, pais_origem) values (4, 'The Strokes', 'EUA');

insert into album (id_album, titulo_album, ano_lancamento, numero_faixas, id_artistas_fk) values (0, 'Around the Fur', '1997', 8, 0);
insert into album (id_album, titulo_album, ano_lancamento, numero_faixas, id_artistas_fk) values (1, '...And Justice for All', '1988', 7, 1);
insert into album (id_album, titulo_album, ano_lancamento, numero_faixas, id_artistas_fk) values (2, 'Jar of Flies', '1999', 5, 2);
insert into album (id_album, titulo_album, ano_lancamento, numero_faixas, id_artistas_fk) values (3, 'Heaven or Las Vegas', '1990', 8, 3);
insert into album (id_album, titulo_album, ano_lancamento, numero_faixas, id_artistas_fk) values (4, 'The Abnormal', '2021', 9, 4);

insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (0,'Rickets', '00:03:17', '0.99', 0, 4);
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (1,'One', '00:07:49', '1.99', 1, 3 );
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (2,'Nutshell', '00:02:57', '0.89', 2, 1 );
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (3,'Cherry-Coloured Funk', '00:04:31', '1.29', 3, 2);
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (4,'The Adults Are Talking', '00:04:49', '1.09', 4, 0);
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (5,'Stay Away', '00:02:59', '0.99', 2, 1);
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (6,'My Own Summer', '00:05:03', '1.59', 0, 4);
insert into faixa (id_faixa, titulo_faixa, duracao, preco, id_album_fk, id_genero_fk) values (7,'Heaven or Las Vegas', '00:03:40', '0.99', 3, 2);

# FASE 3: Consultas avançadas;

use biblioteca_musical;

select avg(preco)
from faixa;

select min(duracao)
from faixa;

select max(duracao)
from faixa;

SELECT A.titulo_album, SUM(F.preco)                
FROM album A                                      
JOIN faixa F ON A.id_album = F.id_album_fk       
GROUP BY A.titulo_album                                  
ORDER BY PrecoTotalFaixas DESC;

select titulo_faixa, preco from faixa
where titulo_faixa like '_Love' and preco > 1.00; -- n vai retornar nada pq n tem 'love' em nenhuma faixa

select * from album where ano_lancamento between '1990' and '2022';

select F.titulo_faixa, A.titulo_album, AR.nome_artista
from faixa F
inner join album A on F.id_album_fk = A.id_album
inner join artista AR on A.id_artistas_fk = AR.id_artista; -- heheheha

-- subqueries:

select titulo_faixa, duracao from faixa where duracao > (select avg(duracao) from faixa); -- retorna a/as durações que forem maiores que a média

SELECT titulo_faixa FROM faixa
WHERE id_genero_fk IN ( SELECT id_genero FROM genero WHERE nome_do_genero IN ('Grunge', 'Indie'));



