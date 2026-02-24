-- trabalho #1: Sistema de Gerenciamento de Estoque e Pedidos

/* ideia: Você criará um pequeno sistema que gerencia Produtos e Pedidos. 
O desafio será usar todas as restrições e cláusulas SQL solicitadas para garantir a integridade e 
a consulta eficiente dos dados.
*/

-- FASE #1: CONSTRUINDO O DB E AS TABELAS
create database if not exists GerenciamentoVendas;

use GerenciamentoVendas;

create table Categorias
(	
	categoria_id int,
    primary key (categoria_id),
    nome_categoria varchar (100) unique -- exemplo: eletrodoméstico, cozinha, banheiro e etc.
);

create table Produtos 
(	
	produto_id int,
    primary key (produto_id), -- 
    nome_produto varchar(100),
    preco_unitario float ,
    constraint preco_maior_zero check (preco_unitario > 0), -- Nomeando o check 
    quantidade_em_estoque int,
    barras_codigo varchar(100) unique,
    registro date, 
    disponibilidade bool,
    id_produto_fk int,
    foreign key (id_produto_fk) references Categorias (categoria_id)
    
);

use GerenciamentoVendas;

create table Pedidos
(	
	pedido_id int,
    primary key (pedido_id),
    data_hora_pedido datetime,
    valor_total_pedido float,
    status_pedido varchar(50),
    constraint check (status_pedido IN ('Pendente', 'Em Processamento', 'Concluído'))
    
);

-- FASE #2: INSERÇÃO DE DADOS NAS TABELAS

insert into Categorias (categoria_id, nome_categoria) values (1, 'Eletrodoméstico');
insert into Categorias (categoria_id, nome_categoria) values (2, 'Eletrônicos');
insert into Categorias (categoria_id, nome_categoria) values (3, 'Alimentos');

insert into Produtos
	(produto_id, nome_produto, preco_unitario, quantidade_em_estoque, barras_codigo, registro, disponibilidade, id_categoria_fk)
values
	(1, 'Microondas', 489.90, 7, '00012345', '2025-10-01', TRUE, 1),
    (2, 'Smart TV 50"', 2999.00, 15, '00067890', '2025-10-15', TRUE, 2),
    (3, 'Cafeteira', 125.50, 20, '00011223', '2025-10-20', TRUE, 1),
    (4, 'Chocolate Barra', 4.50, 100, '987654321', '2025-11-01', TRUE, 3);
    
insert into Pedidos 
	(pedido_id, data_hora_pedido, valor_total_pedido, status_pedido)
values
	(1, '2025-11-05 20:19:55', 499.90, 'Em Processamento'),
    (2, '2025-11-04 15:30:00', 3124.50, 'Concluído');
    
select nome_produto, preco_unitario, quantidade_em_estoque from Produtos 
where quantidade_em_estoque < 50;

select data_hora_pedido from Produtos order by data_hora_pedido DESC;

-- FASE #3: INNER JOIN

select 
	P.nome_produto,
	C.nome_categoria
from 
	Produtos P 
inner join 
	Categorias C 
-- A junção é feita entre a FK (id_categoria_fk) e a PK (categoria_id)
on P.id_categoria_fk = C.categoria_id;
    

