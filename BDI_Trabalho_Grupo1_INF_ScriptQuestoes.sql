--Carlos Mugeiro nº20160641
--Leonel Correia nº20160227
--Vasco Gaspar nº20161025
--grupo 1

-- 1 --

SELECT * FROM Categoria_Produto;
SELECT * FROM Produto;
SELECT * FROM Chefe;
SELECT * FROM Receita;
SELECT * FROM Produto_Receita;
SELECT * FROM Utilizador;
SELECT * FROM Receitas_Seguidas;
SELECT * FROM Premio;
SELECT * FROM Evento;
SELECT * FROM Patrocinador;
SELECT * FROM Tipo_Patrocinador;
SELECT * FROM Patrocinador_Evento;
SELECT * FROM Evento_Premio;
SELECT * FROM Juri;
SELECT * FROM Participa_evento;
SELECT * FROM Classificacoes;
SELECT * FROM Restaurante;

-- 2 --

SELECT Receita.nome FROM Receita ,Categoria_Produto, Produto  WHERE Receita.ingrediente_principal=Produto.id_produto AND Produto.id_categoria=Categoria_Produto.id_categoria  AND Categoria_Produto.descrição='lacticinio';

-- 3 --

SELECT Receita.nome, COUNT(Produto_Receita.id_produto) AS Num_Produtos FROM Receita, Produto, Produto_Receita WHERE Receita.id_receita=Produto_Receita.id_receita AND Produto_Receita.id_produto=Produto.id_produto AND Receita.nome='Leite Creme' GROUP BY Receita.nome;

-- 4 --

SELECT Produto.nome_produto FROM Produto WHERE Produto.nome_produto NOT IN (SELECT DISTINCT Produto.nome_produto FROM Produto, Receita, Produto_Receita WHERE Produto_Receita.id_produto = Produto.id_produto AND Produto.id_produto=Receita.ingrediente_principal);


-- 5 --

SELECT DISTINCT FIRST_VALUE(num.nome1) OVER ( ORDER BY num.Num_Receitas DESC) FROM (SELECT Chefe.nome AS nome1, COUNT(Receita.id_chefe) AS Num_Receitas FROM Chefe, Receita  WHERE Chefe.id_chefe=Receita.id_chefe GROUP BY Chefe.nome) AS Num ;

-- 6 --

SELECT Receita.nome FROM(SELECT Receita.id_receita AS id, AVG(Produto_Receita.quantidade) AS qt FROM Receita, Produto_Receita  WHERE Receita.id_receita= Produto_Receita.id_receita GROUP BY Receita.id_receita) AS tabela, Receita, Produto_Receita WHERE Receita.id_receita=tabela.id AND Receita.id_receita= Produto_Receita.id_receita AND Produto_Receita.quantidade>tabela.qt;

-- 7 --

SELECT Receita.nome, tabela.conta FROM(SELECT Receita.id_receita AS idR, COUNT(Receitas_Seguidas.id_receita) AS conta FROM Receita, Receitas_Seguidas WHERE Receita.id_receita=Receitas_Seguidas.id_receita GROUP BY Receita.id_receita) AS tabela, Receita WHERE tabela.idR=Receita.id_receita AND tabela.conta>10;-- na base de dados atual para testar é utilizar o >=1

-- 8 --

SELECT DISTINCT Receita.nome FROM Receita, Produto_Receita, Produto WHERE (Produto_Receita.id_receita=Receita.id_receita AND Produto_Receita.id_produto= Produto.id_produto AND Produto.nome_produto='leite' AND Produto_Receita.quantidade<=100) OR (Produto_Receita.id_receita=Receita.id_receita AND Produto_Receita.id_produto= Produto.id_produto AND Produto.nome_produto='açucar' AND Produto_Receita.quantidade<=150);

-- 9 --

SELECT DISTINCT Restaurante.nome, Restaurante.id_restaurante  FROM(SELECT Receita.id_receita AS receita, Produto.id_produto AS produto FROM Produto, Receita WHERE  Receita.ingrediente_principal=Produto.id_produto ) AS tabela, Restaurante, Produto, Restaurante_Receita WHERE tabela.receita=Restaurante_Receita.pratos AND tabela.produto=Produto.id_produto AND Produto.nome_produto='leite' ORDER BY Restaurante.nome DESC;
-- 10 --

SELECT DISTINCT FIRST_VALUE(tabela.nome) OVER ( ORDER BY tabela.tudo DESC) FROM(SELECT Evento.nome AS nome, (Premio.premio1 + Premio.premio2 + Premio.premio3 + Premio.comissao) AS tudo FROM Evento, Premio WHERE (Evento.id_premio=Premio.id_premio AND Evento.data_ini LIKE '2018-04-%%') OR (Evento.id_premio=Premio.id_premio AND Evento.data_ini LIKE '2018-05-%%') OR (Evento.id_premio=Premio.id_premio AND Evento.data_ini LIKE '2018-06-%%')) AS tabela;

-- 11 --

CREATE TABLE  aux(val int);

INSERT INTO aux (val)
SELECT Receita.ingrediente_principal AS lung1 FROM Classificacoes , Receita WHERE Classificacoes.lugar_1=Receita.id_receita;

INSERT INTO aux (val)
SELECT Receita.ingrediente_principal AS lung2 FROM Classificacoes , Receita WHERE Classificacoes.lugar_2=Receita.id_receita;

INSERT INTO aux (val)
SELECT Receita.ingrediente_principal AS lung3 FROM Classificacoes , Receita WHERE Classificacoes.lugar_3=Receita.id_receita;

SELECT DISTINCT Produto.nome_produto FROM(SELECT val AS val, COUNT(val) AS cout FROM aux GROUP BY val ) AS tabela, Produto, Receita WHERE Receita.ingrediente_principal=Produto.id_produto AND tabela.val=Receita.id_receita;

SELECT * FROM aux;

DROP TABLE aux;
 -- 12 --
 

SELECT Receita.nome FROM(SELECT DISTINCT  FIRST_VALUE(Classificacoes.lugar_2) OVER(ORDER BY Classificacoes.evento) AS lugar2 FROM Classificacoes) AS tabela, Receita WHERE Receita.id_receita=tabela.lugar2

-- 13 --

SELECT tabela1.idEvento, Evento.nome FROM(SELECT DISTINCT Patrocinador_Evento.id_evento AS idEvento FROM(SELECT Patrocinador.id_patrocinador AS id 
FROM Patrocinador, Patrocinador_Evento, Tipo_Patrocinador 
WHERE Patrocinador_Evento.id_patrocinador=Patrocinador.id_patrocinador AND  Patrocinador_Evento.tipo_patrocinador=Tipo_Patrocinador.tipo_patrocinador 
AND Tipo_Patrocinador.tipo_patrocinador=2) AS tabela, Patrocinador_Evento 
WHERE Patrocinador_Evento.id_patrocinador= tabela.id AND Patrocinador_Evento.tipo_patrocinador=2 AND tabela.id=Patrocinador_Evento.tipo_patrocinador) AS tabela1, 
Evento WHERE Evento.id_evento=tabela1.idEvento;

-- 14 --

 -- selecionar apenas os patrocinadores oficiais que já tenhos participado em eventos
 SELECT DISTINCT Patrocinador.nome 
 FROM(SELECT Patrocinador.id_patrocinador as id FROM Tipo_Patrocinador, Patrocinador_Evento, Patrocinador WHERE Patrocinador_Evento.tipo_patrocinador= Tipo_Patrocinador.tipo_patrocinador AND Patrocinador_Evento.id_patrocinador=Patrocinador.id_patrocinador AND Tipo_Patrocinador.descrição='oficial') AS tabela, Patrocinador 
 WHERE tabela.id=Patrocinador.id_patrocinador;

 -- 15 --
 
 -- mostra todos os patrocinadores
CREATE VIEW VerPatrociador AS
SELECT *
FROM Patrocinador;

SELECT * FROM VerPatrociador;

--Drop VIEW VerPatrociador;