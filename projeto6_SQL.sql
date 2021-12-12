/************************************/
/***************PROJETO 6************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################
CREATE TABLE TB_armazens (
	codArmazem INT NOT NULL PRIMARY KEY,
	localizacao VARCHAR(255) NOT NULL ,
	capacidade INTEGER NOT NULL,
);

CREATE TABLE tb_caixas (
	codCaixa CHAR(4) NOT NULL PRIMARY KEY,
	conteudo VARCHAR(255) NOT NULL ,
	valor REAL NOT NULL ,
	FK_armazem INT NOT NULL FOREIGN KEY REFERENCES TB_armazens (codArmazem),
);



--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################

--Popular a tabela TB_armazens
INSERT INTO TB_armazens (codArmazem,Localizacao,Capacidade) VALUES(1,'Chicago',3);
INSERT INTO TB_armazens (codArmazem,Localizacao,Capacidade) VALUES(2,'Miami',4);
INSERT INTO TB_armazens (codArmazem,Localizacao,Capacidade) VALUES(3,'New York',7);
INSERT INTO TB_armazens (codArmazem,Localizacao,Capacidade) VALUES(4,'Los Angeles',2);
INSERT INTO TB_armazens (codArmazem,Localizacao,Capacidade) VALUES(5,'San Francisco',8);


--Popular a tabela tb_caixas
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('0MN7','Pedras',180,3);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('4H8P','Pedras',250,1);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('4RT3','Tesouras',190,4);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('7G3H','Pedras',200,1);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('8JN6','Papeis',75,1);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('8Y6U','Papeis',50,3);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('9J6F','Papeis',175,2);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('LL08','Pedras',140,4);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('P0H6','Tesouras',125,1);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('P2T6','Tesouras',150,2);
INSERT INTO tb_caixas(codCaixa,Conteudo,Valor,FK_armazem) VALUES('TU55','Papeis',90,5);



--################################################################################################################
--ETAPA 3: 11 PERGUNTAS E RESPOSTAS
--################################################################################################################

-------------------------------------
-------Treino seleção e filtro-------
-------------------------------------

--1. Selecionar todos os Armazéns.
SELECT *
FROM TB_armazens

--2. Selecione todos os Caixas com um valor maior que 150.
SELECT *
FROM tb_caixas
WHERE valor > 150

--3. Selecionar todos os Conteúdo distintos em todas as Caixas.
SELECT DISTINCT (conteudo)
FROM tb_caixas

--4. Selecionar o valor médio de todas as Caixas.
SELECT AVG (valor) AS mediaValorCaixa
FROM tb_caixas

--5. Selecionar o armazém Codigo e o valor médio das Caixas em cada armazém.
SELECT FK_armazem AS codArmazem, AVG(valor) AS mediaValorCaixa
FROM tb_caixas
GROUP BY FK_armazem

--6. Selecione apenas aqueles Armazens onde o valor médio das Caixas seja superior a --150.
SELECT FK_armazem AS codArmazem, AVG(valor) AS mediaValorCaixa
FROM tb_caixas
GROUP BY FK_armazem
HAVING AVG(valor) > 150

--7. Selecione o Codigo de cada caixa, junto com o Nome da cidade em que a caixa está --localizada.
SELECT c.codCaixa, a.localizacao
FROM tb_caixas AS c
LEFT JOIN TB_armazens as a
ON FK_armazem = codArmazem

--8. Selecione os Codigos de todas as Caixas localizadas em Chicago.
SELECT c.codCaixa, a.localizacao
FROM tb_caixas AS c
LEFT JOIN TB_armazens as a
ON FK_armazem = codArmazem
WHERE a.localizacao = 'Chicago'

--9. Selecione o armazém Codigos, juntamente com o número de Caixas em cada armazém.
SELECT FK_armazem AS codArmazem, COUNT(codCaixa) AS totalCaixas
FROM tb_caixas
GROUP BY FK_armazem

--10. Selecionar os Codigos de todos os Armazéns que estão saturados (um armazém fica saturado se o número de Caixas nele contido for superior à capacidade do armazém).
SELECT FK_armazem AS codArmazem, COUNT(codCaixa) AS totalCaixas, a.capacidade
FROM tb_caixas AS t
LEFT JOIN TB_armazens AS a
ON FK_armazem = codArmazem
GROUP BY FK_armazem, capacidade
HAVING COUNT(codCaixa) > A.capacidade

-------------------------------------
-------Treino coluna calculada-------
-------------------------------------

--1. Crie uma nova coluna com o nome de ‘Saturacao’. Se a quantidade de Caixas for superior a capacidade que o armazem possui, essa nova coluna terá o valor de “Saturado”, senão terá o valor de “Não Saturado”.
SELECT FK_armazem AS codArmazem, COUNT(codCaixa) AS totalCaixas, a.capacidade,
CASE
	WHEN COUNT(codCaixa) > A.capacidade THEN 'Saturado'
	ELSE 'Não Saturado'
END AS statusDeCapacidade
FROM tb_caixas AS t
LEFT JOIN TB_armazens AS a
ON FK_armazem = codArmazem
GROUP BY FK_armazem, capacidade



