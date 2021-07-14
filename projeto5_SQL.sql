/************************************/
/***************PROJETO 5************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################

CREATE TABLE tb_filmes (
	codigo INT PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	classificacao VARCHAR(255)
);

CREATE TABLE tb_cinemas (
	codigo INTEGER PRIMARY KEY,
	nomeCinema VARCHAR(255) NOT NULL,
	codFilme INT FOREIGN KEY REFERENCES tb_filmes(Codigo)
);
--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################

--Popular a tabela tb_filmes

INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(1,'Citizen Kane','Sugestão Parental');
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(2,'Singin'' in the Rain','Audiência Geral');
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(3,'The Wizard of Oz','Audiência Geral');
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(4,'The Quiet Man',NULL);
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(5,'North by Northwest',NULL);
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(6,'The Last Tango in Paris','Maior de 18 anos');
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(7,'Some Like it Hot','Maior de 13 anos');
INSERT INTO tb_filmes (Codigo,Titulo,Classificacao) VALUES(8,'A Night at the Opera',NULL);
--Popular a tabela tb_cinemas

INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(1,'Odeon',5);
INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(2,'Imperial',1);
INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(3,'Majestic',NULL);
INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(4,'Royale',6);
INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(5,'Paraiso',3);
INSERT INTO tb_cinemas(Codigo,nomeCinema,codFilme) VALUES(6,'Nickelodeon',NULL);

--################################################################################################################
--ETAPA 3: 11 PERGUNTAS E RESPOSTAS
--################################################################################################################

-------------------------------------
-------Treino seleção e filtro-------
-------------------------------------

--1. Selecione o título de todos os filmes.
SELECT titulo
FROM tb_filmes

--2. Mostrar todas as classificações distintas que existem na tabela Filmes.
SELECT DISTINCT classificacao
FROM tb_filmes

--3. Mostrar a quantidade de classificações que existem.
SELECT COUNT (classificacao) AS totalClassificacoesDiferentes
FROM tb_filmes
--Coincidentemente retorna o valor 5, porque o NULL não entra como contagem
--daí como há 5 valores preenchidos e 3 vazios, bate a conta, como mostra o retorno da query abaixo:
SELECT  DISTINCT COUNT(classificacao) AS totalClassificacoesDiferentes, classificacao
FROM tb_filmes
GROUP BY classificacao
--Mas na verdade a resposta correta seriam 4 classificações
--já que são 4 distintas + as nulas que não entram na contagem
--Pontanto a resposta correta é retornada de acordo com a query abaixo:
SELECT COUNT (DISTINCT classificacao) AS totalClassificacoesDiferentes
FROM tb_filmes
--Por questões de visualização, teste a query abaixo:
SELECT COUNT (DISTINCT classificacao) AS totalClassificacoesDiferentes, classificacao 
FROM tb_filmes
GROUP BY classificacao

--4. Mostrar todos os filmes não classificados.
SELECT titulo, classificacao
FROM tb_filmes
WHERE classificacao IS NULL

--5. Selecione todas as salas de cinema que estão exibindo um filme no momento.
SELECT nomeCinema, codFilme
FROM tb_cinemas
WHERE codFilme IS NOT NULL

--6. Selecione todos os dados de todos os cinemas e, adicionalmente, os dados do filme que está sendo exibido na sala de cinema.
SELECT *
FROM tb_cinemas AS c
LEFT JOIN tb_filmes AS f
ON c.codFilme = f.codigo

--7. Selecione os cinemas que tenham filmes (com os nomes dos filmes)
SELECT c.nomeCinema, f.titulo
FROM tb_cinemas AS c
INNER JOIN tb_filmes AS f
ON c.codFilme = f.codigo

--8. Selecione todos os dados de todos os filmes e, se o filme estiver sendo exibido em um cinema, mostre o nome cinema.
SELECT f.*, c.nomeCinema
FROM tb_filmes AS f
LEFT JOIN tb_cinemas AS c
ON c.codFilme = f.codigo

--9. Exibir os títulos de filmes que atualmente não estão sendo exibidos em nenhuma sala.
SELECT f.titulo
FROM tb_filmes AS f
LEFT JOIN tb_cinemas AS c
ON  f.codigo = c.codFilme
WHERE c.codFilme IS NULL

/* 

Faça os testes abaixo para verificar as saídas

SELECT F.codigo, f.titulo
FROM tb_filmes AS f
RIGHT JOIN tb_cinemas AS c
ON  f.codigo = c.codFilme
WHERE c.codFilme IS NULL

SELECT F.codigo, f.titulo
FROM tb_filmes AS f
INNER JOIN tb_cinemas AS c
ON  f.codigo = c.codFilme
WHERE c.codFilme IS NULL

SELECT F.codigo, f.titulo
FROM tb_filmes AS f
FULL JOIN tb_cinemas AS c
ON  f.codigo = c.codFilme
WHERE c.codFilme IS NULL

*/
-------------------------------------
-------Treino coluna calculada-------
-------------------------------------
--1. Crie uma nova coluna chamada nova_classificação. E coloque todos com classificação “Livre”.
SELECT *, 'Livre' as nova_classificação
FROM tb_filmes


--2. Crie uma nova coluna chamada nova_classificacao2. Se a Classificação for “Audiência Geral”, então é “Livre”. Caso contrário é igual a coluna Classificação.SELECT *,
CASE 
	WHEN classificacao = 'Audiência Geral' THEN 'Livre'
	ELSE classificacao
END AS nova_classificacao2
FROM tb_filmes
