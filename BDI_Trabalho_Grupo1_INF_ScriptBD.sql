--Carlos Mugeiro nº20160641
--Leonel Correia nº20160227
--Vasco Gaspar nº20161025
--grupo 1

CREATE TABLE Categoria_Produto(id_categoria INT IDENTITY(1,1) NOT NULL PRIMARY KEY, descrição VARCHAR(100));

CREATE TABLE Produto(id_produto INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome_produto VARCHAR(50), calorias_produto INT, id_categoria INT REFERENCES Categoria_Produto(id_categoria));

CREATE TABLE Chefe(id_chefe INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome VARCHAR(40), data_de_inicio DATE);

CREATE TABLE Receita(id_receita INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome VARCHAR(40), data_registo DATE, modo VARCHAR(50), tempo INT, calorias INT ,id_chefe INT REFERENCES Chefe(id_chefe) , ingrediente_principal INT REFERENCES Produto(id_produto) );

CREATE TABLE Produto_Receita(id_receita INT REFERENCES Receita(id_receita) , id_produto INT REFERENCES Produto(id_produto),quantidade INT , PRIMARY KEY(id_receita,id_produto));

CREATE TABLE Utilizador(id_utilizador INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome VARCHAR(50), morada VARCHAR(100), genero VARCHAR(30), categoria_de_produtos INT REFERENCES Categoria_Produto(id_categoria));

CREATE TABLE Receitas_Seguidas(id_utilizador INT REFERENCES Utilizador(id_utilizador) , id_receita INT REFERENCES Receita(id_receita));

CREATE TABLE Premio(id_premio INT IDENTITY(1,1) NOT NULL PRIMARY KEY, premio1 INT, premio2 INT, premio3 INT, comissao INT);

CREATE TABLE Evento(id_evento INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome varchar(50), recinto VARCHAR(80), data_ini DATE, data_final DATE, id_premio INT REFERENCES Premio(id_premio));

CREATE TABLE Patrocinador(id_patrocinador INT IDENTITY(1,1) NOT NULL PRIMARY KEY, nome VARCHAR(40), morada VARCHAR(100), país VARCHAR(100), email VARCHAR(100));

CREATE TABLE Tipo_Patrocinador(tipo_patrocinador INT IDENTITY(1,1) NOT NULL PRIMARY KEY, descrição  VARCHAR(100));

CREATE TABLE Patrocinador_Evento(id_evento INT REFERENCES Evento(id_evento), id_patrocinador INT REFERENCES Patrocinador(id_patrocinador) , tipo_patrocinador INT REFERENCES Tipo_Patrocinador(tipo_patrocinador) , valor_contribuido INT, PRIMARY KEY(id_evento,id_patrocinador));

CREATE TABLE Evento_Premio(id_evento INT REFERENCES Evento(id_evento), id_premio INT REFERENCES Premio(id_premio));

CREATE TABLE Juri(id_evento INT REFERENCES Evento(id_evento),  id_patrocinador INT REFERENCES Patrocinador(id_patrocinador));

CREATE TABLE Participa_evento(id_evento INT REFERENCES Evento(id_evento), id_receita INT REFERENCES Receita(id_receita), id_chefe INT REFERENCES Chefe(id_chefe));

CREATE TABLE Classificacoes(lugar_1 INT REFERENCES Receita(id_receita), lugar_2 INT REFERENCES Receita(id_receita), lugar_3 INT REFERENCES Receita(id_receita), evento INT REFERENCES Evento(id_evento) NOT NULL PRIMARY KEY);

CREATE TABLE Restaurante(id_restaurante INT NOT NULL PRIMARY KEY , nome VARCHAR(50));

CREATE TABLE Restaurante_Receita(id_restaurante INT REFERENCES Restaurante(id_restaurante) , pratos INT REFERENCES Receita(id_receita), PRIMARY KEY(id_restaurante, pratos));

/*
DROP TABLE Classificacoes;
DROP TABLE Restaurante;
DROP TABLE Participa_evento;
DROP TABLE Juri;
DROP TABLE Evento_Premio;
DROP TABLE Patrocinador_Evento;
DROP TABLE Tipo_Patrocinador;
DROP TABLE Patrocinador;
DROP TABLE Evento;
DROP TABLE Premio;
DROP TABLE Receitas_Seguidas;
DROP TABLE Utilizador;
DROP TABLE Produto_Receita;
DROP TABLE Receita;
DROP TABLE Chefe;
DROP TABLE Produto;
DROP TABLE Categoria_Produto;
*/


INSERT INTO Categoria_Produto VALUES('lacticinio');
INSERT INTO Categoria_Produto VALUES('processados');
INSERT INTO Categoria_Produto VALUES('construtores');
INSERT INTO Produto VALUES('leite',  50, 1);
INSERT INTO Produto VALUES('açucar', 100, 2);
INSERT INTO Produto VALUES('ovos', 100, 2);
INSERT INTO Chefe VALUES('Menel', '2018-06-07');
INSERT INTO Chefe VALUES('Leonel', '2018-06-06');
INSERT INTO Receita VALUES('Leite Creme', '2018-06-07', 'fogão', 20, 30, 1, 1);
INSERT INTO Receita VALUES('Leite Condensado', '2018-06-07', 'fogão', 50, 60, 1, 1);
INSERT INTO Receita VALUES('Shot de Leite', '2018-06-06', 'bebida', 5, 35, 2, 1);
INSERT INTO Receita VALUES('Leite Creme', '2018-06-07', 'fogão', 20, 30, 2, 1);
INSERT INTO Receita VALUES('Leite Condensado', '2018-06-07', 'fogão', 50, 60, 2, 1);
INSERT INTO Receita VALUES('Leite Condensado', '2018-06-07', 'fogão', 50, 60, 2, 2);
INSERT INTO Receita VALUES('Pão de Ló', '2018-06-07', 'forno', 50, 60, 2, 1);
INSERT INTO Produto_Receita VALUES(1,1, 100);
INSERT INTO Produto_Receita VALUES(1,2, 30);
INSERT INTO Produto_Receita VALUES(2,1, 100);
INSERT INTO Produto_Receita VALUES(2,2, 34);
INSERT INTO Produto_Receita VALUES(3,1, 75);
INSERT INTO Produto_Receita VALUES(4,1, 80);
INSERT INTO Produto_Receita VALUES(4,2, 90);
INSERT INTO Produto_Receita VALUES(5,1, 95);
INSERT INTO Produto_Receita VALUES(5,2, 101);
INSERT INTO Produto_Receita VALUES(8,1, 100);
INSERT INTO Produto_Receita VALUES(8,3, 5);
INSERT INTO Utilizador VALUES('Vasco', 'Av sempre em frente', 'M', 1);
INSERT INTO Receitas_Seguidas VALUES(1,1);
INSERT INTO Receitas_Seguidas VALUES(1,2);
INSERT INTO Premio VALUES(3000, 2000, 1000, 4000 );
INSERT INTO Premio VALUES(4000, 3000, 2000, 5000 );
INSERT INTO Premio VALUES(4000, 3000, 2000, 6000 );
INSERT INTO Evento VALUES('Evento A' ,'A minha casa', '2018-06-07', '2018-06-09', 1);
INSERT INTO Evento VALUES('Evento B' ,'A minha outra casa', '2018-06-07', '2018-06-09', 1);
INSERT INTO Evento VALUES('Evento C' ,'A minha outra casa2', '2018-06-07', '2018-06-09', 1);
INSERT INTO Evento VALUES('Evento D' ,'A minha outra casa2', '2018-06-07', '2018-06-09', 1);
INSERT INTO Evento VALUES('Evento E' ,'A minha outra casa2', '2018-06-07', '2018-06-09', 3);
INSERT INTO Patrocinador VALUES('Hammer Time .Lda', 'Av fé em Deus', 'Portugal', 'email@email.com');
INSERT INTO Patrocinador VALUES('Lemme smash', 'Av Sem fé em Deus', 'Portugal', 'email1@email.com');
INSERT INTO Patrocinador VALUES('The Way', 'Av perdeu fé em Deus', 'Portugal', 'email2@email.com');
INSERT INTO Patrocinador VALUES('Hammer Time .Lda1', 'Av fé em Deus', 'Portugal', 'email3@email.com');
INSERT INTO Patrocinador VALUES('Lemme smash2', 'Av Sem fé em Deus', 'Portugal', 'email4@email.com');
INSERT INTO Patrocinador VALUES('The Way3', 'Av perdeu fé em Deus', 'Portugal', 'email5@email.com');
INSERT INTO Tipo_Patrocinador VALUES('oficial');
INSERT INTO Tipo_Patrocinador VALUES('Não Oficial');
INSERT INTO Patrocinador_Evento VALUES(1,1,1, 5000);
INSERT INTO Patrocinador_Evento VALUES(1,2,2, 2500);
INSERT INTO Patrocinador_Evento VALUES(1,3,2, 2500);
INSERT INTO Patrocinador_Evento VALUES(2,1,1, 6000);
INSERT INTO Patrocinador_Evento VALUES(2,2,2, 4500);
INSERT INTO Patrocinador_Evento VALUES(2,3,2, 3500);
INSERT INTO Patrocinador_Evento VALUES(3,4,1, 6000);
INSERT INTO Patrocinador_Evento VALUES(3,5,2, 4500);
INSERT INTO Patrocinador_Evento VALUES(3,6,2, 4500);
INSERT INTO Patrocinador_Evento VALUES(4,4,1, 6000);
INSERT INTO Patrocinador_Evento VALUES(4,5,2, 4500);
INSERT INTO Patrocinador_Evento VALUES(4,6,2, 4500);
INSERT INTO Evento_Premio VALUES(1,1);
INSERT INTO Evento_Premio VALUES(2,2);
INSERT INTO Evento_Premio VALUES(3,3);
INSERT INTO Evento_Premio VALUES(4,3);
INSERT INTO Juri VALUES(1,1);
INSERT INTO Juri VALUES(1,2);
INSERT INTO Juri VALUES(1,3);
INSERT INTO Juri VALUES(2,1);
INSERT INTO Juri VALUES(2,2);
INSERT INTO Juri VALUES(2,3);
INSERT INTO Juri VALUES(3,4);
INSERT INTO Juri VALUES(3,5);
INSERT INTO Juri VALUES(3,6);
INSERT INTO Juri VALUES(4,4);
INSERT INTO Juri VALUES(4,5);
INSERT INTO Juri VALUES(4,6);

INSERT INTO Participa_evento VALUES(1,1,1);
INSERT INTO Participa_evento VALUES(1,2,1);
INSERT INTO Participa_evento VALUES(1,3,1);
INSERT INTO Participa_evento VALUES(2,1,1);
INSERT INTO Participa_evento VALUES(2,2,1);
INSERT INTO Participa_evento VALUES(2,3,1);
INSERT INTO Participa_evento VALUES(3,1,1);
INSERT INTO Participa_evento VALUES(3,2,1);
INSERT INTO Participa_evento VALUES(3,3,1);
INSERT INTO Participa_evento VALUES(4,6,1);
INSERT INTO Participa_evento VALUES(4,6,1);
INSERT INTO Participa_evento VALUES(4,6,1);


INSERT INTO Classificacoes VALUES (1,2,3,1);
INSERT INTO Classificacoes VALUES (3,2,1,2);
INSERT INTO Classificacoes VALUES (1,3,2,3);
INSERT INTO Classificacoes VALUES (6,6,6,4);
INSERT INTO Restaurante VALUES(1,'Comida Má');
INSERT INTO Restaurante_Receita VALUES(1,1);
