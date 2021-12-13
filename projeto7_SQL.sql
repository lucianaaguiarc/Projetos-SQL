/************************************/
/***************PROJETO 6************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################

CREATE TABLE tb_trabalhador(
	id_trabalhador INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	nome CHAR(25),
	sobrenome CHAR (25),
	salario INT,
	data_ingresso DATETIME,
	departamento CHAR(25)
)

CREATE TABLE tb_bonus(

	valor_bonus INT,
	data_bonus DATETIME,
	FK_bonus_trabalhador INT FOREIGN KEY  REFERENCES tb_trabalhador (id_trabalhador)
)

CREATE TABLE tb_funcao(
	funcao_cargo CHAR(25),
	FK_funcao_trabalhador INT FOREIGN KEY REFERENCES tb_trabalhador (id_trabalhador)

)

--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################

--Popular a tabela TB_trabalhador
INSERT INTO tb_trabalhador VALUES ('Monika', 'Arora', 100000, CAST('2020-02-14 09:00:00.000' AS DATETIME), 'RH')
INSERT INTO tb_trabalhador VALUES ('Niharika', 'Verma', 80000, CAST('2011-06-14 09:00:00.000' AS DATETIME), 'Admin')
INSERT INTO tb_trabalhador VALUES ('Vishal', 'Singhal', 300000, CAST('2020-02-14 09:00:00.000' AS DATETIME), 'RH')
INSERT INTO tb_trabalhador VALUES ('Amitabh', 'Singh', 500000, CAST('2020-02-14 09:00:00.000' AS DATETIME), 'Admin')
INSERT INTO tb_trabalhador VALUES ('Vivek', 'Bhati', 500000, CAST('2020-06-14 09:00:00.000' AS DATETIME), 'Account')
INSERT INTO tb_trabalhador VALUES ('Vipul', 'Diwan', 200000,  CAST('2011-06-14 09:00:00.000' AS DATETIME), 'Account')
INSERT INTO tb_trabalhador VALUES ('Satish', 'Kumar', 75000, CAST('2020-01-14 09:00:00.000' AS DATETIME), 'RH')
INSERT INTO tb_trabalhador VALUES ('Geetika', 'Chauhan', 90000, CAST('2011-04-14 09:00:00.000' AS DATETIME), 'RH')

--Popular a tabela tb_bonus
INSERT INTO tb_bonus VALUES (5000, CAST ('2020-02-16' AS DATE), 1)
INSERT INTO tb_bonus VALUES (3000, CAST ('2011-06-16' AS DATE), 2)
INSERT INTO tb_bonus VALUES (4000, CAST ('2020-02-16' AS DATE), 3)
INSERT INTO tb_bonus VALUES (4500, CAST ('2020-02-18' AS DATE), 1)
INSERT INTO tb_bonus VALUES (3500, CAST ('2011-06-18' AS DATE), 2)


--Popular a tabela tb_funcao

INSERT INTO tb_funcao VALUES('Manager', 1)
INSERT INTO tb_funcao VALUES('Executive', 2)
INSERT INTO tb_funcao VALUES('Executive', 8)
INSERT INTO tb_funcao VALUES('Manager', 5)
INSERT INTO tb_funcao VALUES('Asst. Manager', 4)
INSERT INTO tb_funcao VALUES('Executive', 7)
INSERT INTO tb_funcao VALUES('Lead', 6)
INSERT INTO tb_funcao VALUES('Lead', 3)


--################################################################################################################
--ETAPA 3: 6 PERGUNTAS E RESPOSTAS
--################################################################################################################

-- 1. Mostre os funcionários que têm o salário acima da média
SELECT id_trabalhador, nome, salario  
FROM tb_trabalhador
WHERE salario > (SELECT AVG (salario) FROM tb_trabalhador)

-- 2 Qual o salário médio e o bônus médio por função?SELECT f.funcao_cargo,
       AVG(t.salario)     AS media_salario,
       AVG(b.valor_bonus) AS media_bonus
FROM   tb_funcao AS f
       LEFT JOIN tb_trabalhador AS t
              ON f.fk_funcao_trabalhador = t.id_trabalhador
       LEFT JOIN tb_bonus AS b
              ON b.fk_bonus_trabalhador = t.id_trabalhador
GROUP BY F.funcao_cargo;-- 3. Crie uma nova coluna com o nome de Salario_Medio. Se o salário for acima da -- média, o valor da linha será ‘Acima da média’, caso contrário, será abaixo da média.
-- Depois mostre a quantidade de salários acima e abaixo da média.WITH cte_situacao
     AS (SELECT CASE
                  WHEN salario > (SELECT AVG (salario)
                                  FROM   tb_trabalhador) THEN 'Acima da média'
                  ELSE 'Abaixo da média'
                END AS situacao_salario
         FROM   tb_trabalhador)
SELECT situacao_salario,
       COUNT (situacao_salario) AS contagem
FROM   cte_situacao
GROUP  BY situacao_salario 

-- 4. Filtre quem recebeu bônus na data de 16-02-20.	SELECT t.nome,
       b.data_bonus
FROM   tb_trabalhador AS t
       INNER JOIN tb_bonus AS b
               ON t.id_trabalhador = b.fk_bonus_trabalhador
WHERE  b.data_bonus > '2020-02-16'  --5. Mostre o nome do funcionário, data de ingresso, data que recebeu bônus, valor do bônus e a diferença de dias entre a data de ingresso e a data que recebeu bônus (não interessa quem não recebeu). SELECT t.nome, t.data_ingresso, b.data_bonus, b.valor_bonus,CAST( DATEDIFF (DAY, t.data_ingresso, b.data_bonus) AS CHAR (2))+ 'horas' as diferenca_bonus_ingresso FROM tb_trabalhador as t INNER JOIN tb_bonus AS b on t.id_trabalhador = b.FK_bonus_trabalhador -- 6.Cada bônus representou qual o percentual do salário?  SELECT t.nome, b.valor_bonus, t.salario, (CAST(b.valor_bonus AS FLOAT) / CAST(t.salario AS FLOAT)*100) as porcentagem_bonus_salario FROM tb_trabalhador as t INNER JOIN tb_bonus AS b on t.id_trabalhador = b.FK_bonus_trabalhador