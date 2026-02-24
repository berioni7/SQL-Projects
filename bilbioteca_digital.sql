-- trabalho #4: Gerenciamento de Biblioteca Digital

/*O objetivo é criar um banco de dados que gerencie uma biblioteca, bem como autores e livros. 
O foco estará na consulta dos dados, usando conceitos como TABELA TEMPORÁRIA, CTE e CTE RECURSIVA (recursividade).
*/

# FASE 1: Construção do DB e tabelas/ criando relacionamentos;

create database if not exists biblioteca_digital;

use biblioteca_digital;

create table Autores (
	id_autor int,
    primary key (id_autor),
    nome_autor varchar(100),
    nacionalidade varchar(100),
    nacional int(1)
);

create table Livros (
	id_livro int,
    primary key(id_livro),
    titulo varchar(100),
    ano_publicacao int,
    constraint ano_publicacao_check check (ano_publicacao > 1500),
    id_autor_fk int,
    foreign key (id_autor_fk) references Autores (id_autor)
);

create table Membros (
	id_membro int,
    primary key (id_membro),
    nome_membro varchar(20),
    sobrenome_membro varchar(100),
    email_membro varchar(100),
    check (email_membro like '%@gmail.com')
);	

create table Emprestimos ( -- tabela de relacionamento (intermediária), pois registra quem pegou qual livro N:M (Várias pessoas podem pegar o mesmo livro, e o mesmo livro pode ser pego por muitas pessoas)
	id_emprestimo int,
    primary key (id_emprestimo),
    id_livro_fk int,
    foreign key (id_livro_fk) references Livros (id_livro),
    id_membros_fk int,
    foreign key (id_membros_fk) references Membros (id_membro),
    data_emprestimo date,
    data_devolucao_prevista date
);

# FASE 2: Inserção de dados;

insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (0, 'Milan Kundera', 'Tcheco', 0);
insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (1, 'Machado de Assis', 'Brasileiro', 1);
insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (2, 'Clarice Lispector', 'Ucraniana', 0);
insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (3, 'Liev Tolstói', 'Russo', 0);
insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (4, 'Albert Camus', 'Francês', 0);
insert into Autores (id_autor, nome_autor, nacionalidade, nacional) values (5, 'Mary Shelley', 'Inglesa', 0);

insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (0, 'A Insustentável Leveza do Ser', '1984-04-01', 0);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (1, 'A Imortalidade', '1988-08-17', 0);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (2, 'Memórias Póstumas de Brás Cubas', '1881-03-02', 1);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (3, 'Quincas Borba', '1891-09-15', 1);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (4, 'A Hora da Estrela', '1977-05-12', 2);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (5, 'Um Sopro de Vida', '1969-07-28', 2);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (6, 'Guerra e Paz', '1835-01-29', 3);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (7, 'Anna Karenina', '1870-12-08', 3);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (8, 'O Estrangeiro', '1942-04-12', 4);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (9, 'A Peste', '1955-11-11', 4);
insert into Livros (id_livro, titulo, ano_publicacao, id_autor_fk ) values (10, 'O Mito de Sísifo', '1960-02-21', 4);

insert into Membros (id_membro, nome_membro, sobrenome_membro, email_membro) values (0,'Gabriel','Berioni','gabrielberioni3@gmail.com');
insert into Membros (id_membro, nome_membro, sobrenome_membro, email_membro) values (1,'Carlos','Almeida','caralmeida@gmail.com');
insert into Membros (id_membro, nome_membro, sobrenome_membro, email_membro) values (2,'Jorge','Tadeu','tadeu-jorge@gmail.com');
insert into Membros (id_membro, nome_membro, sobrenome_membro, email_membro) values (3,'Junior','Filho','junin998filho@gmail.com');
insert into Membros (id_membro, nome_membro, sobrenome_membro, email_membro) values (4,'Daniel','Marcelo','MarceloLoLDani0@gmail.com');

insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (0, 0, 0, '2025-11-29', '2025-12-15');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (1, 4, 0, '2025-11-29', '2025-12-08');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (2, 2, 1, '2025-11-15', '2025-12-02');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (3, 3, 1, '2025-11-15', '2025-12-04');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (4, 1, 2, '2025-11-01', '2025-11-20');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (5, 5, 3, '2025-11-05', '2025-11-18');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (6, 8, 4, '2025-11-30', '2025-12-20');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (7, 10, 0, '2025-11-02', '2025-11-15');
insert into Emprestimos (id_emprestimo, id_livro_fk, id_membros_fk, data_emprestimo, data_devolucao_prevista) values (8, 9, 4, '2025-12-03', '2025-12-22');

# FASE 3: Consultas avançadas;

SELECT * FROM Livros WHERE ano_publicacao > 1900;
SELECT nome_membro, sobrenome_membro FROM Membros Order By nome_membro, sobrenome_membro;

select L.titulo AS 'TITULO', A.nome_autor AS 'NOME AUTOR' 
from Livros L
inner join Autores A ON L.id_autor_fk = A.id_autor;

SELECT 
    A.nome_autor, 
    L.titulo
FROM 
    Autores A 
LEFT JOIN 
    Livros L ON A.id_autor = L.id_autor_fk;

Select L.id_livro, M.nome_membro 
from Livros L
right outer join Emprestimos E on L.id_livro = E.id_livro_fk
right outer join Membros M on E.id_membro_fk = M.id_membro;

-- Consultas usando Tabelas derivadas, CTE, CTE recursiva

-- TABELA TEMPORÁRIA: SÓ EXISTE DURANTE A SESSÃO MySQL

CREATE TEMPORARY TABLE LivrosPopulares
(
	id_livro_emprestado int,
    primary key (id_livro_emprestado),
    vezes_emprestado int
);

INSERT INTO LivrosPopulares (id_livro_emprestado, vezes_emprestado)

select * from LivrosPopulares WHERE vezes_emprestado > 2;

-- EXPRESSÃO DE TABELA COMUM (CTE): CONJUNTO DE RESULTADOS NOMEADO E TEMPORÁRIO, DEFINIDO DENTRO DO ESCOPO DE UMA ÚNICA FUNÇÃoptimize

WITH MembrosComEmprestimos AS (
	select distinct id_membro_fk
    from Emprestimos E
)
select M.nome_membro, M.sobrenome_membro, M.email_membro
from Membros M
inner join MembrosComEmprestimos MCE on M.id_membro = MCE.id_membro_fk;










