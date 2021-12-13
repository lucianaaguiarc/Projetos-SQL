/************************************/
/***************PROJETO 6************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################
CREATE TABLE tb_Lead(
	lead_id INT PRIMARY KEY,
	created_date DATE,
	industry VARCHAR(25)
)

CREATE TABLE tb_Account(
	account_id INT PRIMARY KEY,
	created_date DATE,
	lead_id INT
)

CREATE TABLE tb_Opportunity(
	opportunity_id INT,
	close_date DATE,
	stage VARCHAR(25),
	account_id INT
)

CREATE TABLE tb_Revenue(
	account_id INT,
	revenue_2017 DECIMAL (10,2),
	revenue_2018 DECIMAL (10,2)
)

CREATE TABLE tb_Team(
	account_id INT, 
	team VARCHAR(25),
	region VARCHAR(25)
)

--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################




--################################################################################################################
--ETAPA 3: 6 PERGUNTAS E RESPOSTAS
--################################################################################################################

--1. Qual é o número de leads criados em março de 2019?
SELECT COUNT (lead_id) AS total_leads
FROM   tb_lead
WHERE  created_date BETWEEN ( CAST('2019-03-01' AS DATE) ) AND ( CAST ('2019-03-31' AS DATE) ) 



-- 2. Para cada lead associado a uma conta, qual é o lead_id, account_id e o número de dias entre o lead created_date e a account_created_date?
SELECT l.lead_id,
       a.account_id,
       DATEDIFF(DAY, l.created_date, a.created_date) AS days_diff
FROM   tb_lead AS l
       INNER JOIN tb_account AS a
               ON l.lead_id = a.lead_id 


-- 3. Qual é o número médio de dias entre a criação do lead e as datas de criação da conta?
SELECT AVG(DATEDIFF(DAY, l.created_date, a.created_date)) AS media_criacao
FROM   tb_lead AS l
       INNER JOIN tb_account AS a
               ON l.lead_id = a.lead_id 


-- 4. Qual é a taxa geral de crescimento de receita ano a ano para cada região de 2017 a 2018? Ordene os resultados em ordem crescente pelo nome da região.
SELECT t.region,
       ( SUM(r.revenue_2018) / SUM(r.revenue_2017) ) AS taxa_crescimento
FROM   tb_team AS t
       INNER JOIN tb_revenue AS r
               ON t.account_id = r.account_id
ORDER  BY t.region ASC 


-- 5. Quantas contas não têm oportunidades associadas a elas?SELECT COUNT(O.account_id)
FROM tb_account AS a
     LEFT JOIN tb_opportunity AS o
		ON A.account_id = O.account_id 
WHERE o.account_id IS NULL