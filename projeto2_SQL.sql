/************************************/
/***************PROJETO 2************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################

--Criar a tabela Departamentos
CREATE TABLE Departamentos(
	codigo INT PRIMARY KEY,
	nome VARCHAR (255) NOT NULL,
	orcamento DECIMAL (10,2) NOT NULL
)

--Criar tabela Funcionarios
CREATE TABLE Funcionarios (
	ssn INT PRIMARY KEY,
	nome VARCHAR (255) NOT NULL,
	sobrenome VARCHAR (255) NOT NULL,
	departamento INT NOT NULL FOREIGN KEY REFERENCES Departamentos(codigo)
)

--################################################################################################################
--ETAPA 2: POPULAR AS TABELAS
--################################################################################################################

--Popular a tabela Departamentos
INSERT INTO Departamentos(Codigo,Nome,Orcamento) VALUES(14,'IT',65000);
INSERT INTO Departamentos(Codigo,Nome,Orcamento) VALUES(37,'Accounting',15000);
INSERT INTO Departamentos(Codigo,Nome,Orcamento) VALUES(59,'Human Resources',240000);
INSERT INTO Departamentos(Codigo,Nome,Orcamento) VALUES(77,'Research',55000);

--Popular a tabela Funcionarios
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('123234877','Michael','Rogers',14);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('222364883','Carol','Smith',37);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('326587417','Joe','Stevens',37);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('332569843','George','ODonnell',77);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('546523478','John','Doe',59);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('631231482','David','Smith',77);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('654873219','Zacary','Efron',59);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO Funcionarios(SSN,Nome,Sobrenome,Departamento) VALUES('845657246','Kumar','Swamy',14);

--################################################################################################################
--ETAPA 3: 16 PERGUNTAS E RESPOSTAS
--################################################################################################################

--1. Selecione o sobrenome de todos os funcion�rios.
SELECT sobrenome 
FROM Funcionarios

--2. Selecione os sobrenomes distintos de todos os funcion�rios.
SELECT DISTINCT sobrenome 
FROM Funcionarios

--3. Selecione todos os dados de funcion�rios cujo sobrenome seja "Smith".
SELECT *
FROM Funcionarios
WHERE sobrenome = 'Smith'

--4. Selecione todos os dados de funcion�rios cujo sobrenome seja "Smith" ou "Doe".
SELECT *
FROM Funcionarios
WHERE sobrenome = 'Smith' OR sobrenome = 'Doe'

SELECT *
FROM Funcionarios
WHERE sobrenome IN ('Smith', 'Doe')

--5. Selecione todos os dados de funcion�rios cujo sobrenome tenha a letra �o�.
SELECT *
FROM Funcionarios
WHERE sobrenome LIKE '%o%'

--6. Selecione todos os dados de funcion�rios que trabalham no departamento 14.
SELECT *
FROM Funcionarios
WHERE departamento = 14

--7. Selecione todos os dados de funcion�rios que trabalham no departamento 37 ou departamento 77.
SELECT *
FROM Funcionarios
WHERE departamento = 37 OR departamento = 77 

SELECT *
FROM Funcionarios
WHERE departamento IN (37,77)

--8. Selecione todos os dados de funcion�rios cujo sobrenome comece com um "S".
SELECT *
FROM Funcionarios
WHERE sobrenome LIKE 's%' --Verificar a collation do banco. Se for case sensitive, � necess�rio colocar o S mai�sculo

--9. Selecione a soma dos or�amentos de todos os departamentos.
SELECT SUM(orcamento) as totalOrcamento
FROM Departamentos

--10. Selecione o n�mero de funcion�rios em cada departamento (voc� s� precisa mostrar o c�digo do departamento e o n�mero de funcion�rios).
SELECT departamento, COUNT(departamento) AS nFuncionarios
FROM Funcionarios
GROUP BY departamento

--11. Selecione todos os dados dos funcion�rios, incluindo os dados de cada departamento do funcion�rio.
SELECT *
FROM Funcionarios AS f
LEFT JOIN Departamentos AS d
ON f.departamento = d.codigo

--12. Selecione o nome e o sobrenome de cada funcion�rio, juntamente com o nome e o or�amento do departamento do funcion�rio.
SELECT f.nome, f.sobrenome, d.nome as departamento, d.orcamento
FROM Funcionarios AS f
LEFT JOIN Departamentos AS d
ON f.departamento = d.codigo

--13. Selecione o nome e o sobrenome dos funcion�rios que trabalham em departamentos com um or�amento superior a 60.000.
SELECT f.nome, f.sobrenome
FROM Funcionarios AS f
LEFT JOIN Departamentos AS d
ON f.departamento = d.codigo
WHERE d.orcamento > 60000

--[N�O ENTENDI]--14. Selecione os departamentos com um or�amento maior do que o or�amento m�dio de todos os departamentos.
SELECT  nome, orcamento
FROM Departamentos
WHERE orcamento > (select AVG(orcamento) from Departamentos)

/*

1- Por que n�o retorna dado?
SELECT  nome, orcamento
FROM Departamentos
GROUP BY nome, orcamento
HAVING orcamento >  (AVG(orcamento))

2- Por que n�o consigo fazer a CTE? Porque CTE n�o aceita fun��o escalar de agrega��o (https://docs.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver15#guidelines-for-creating-and-using-common-table-expressions)
   Por que n�o aceita fun��o de agrega��o?
WITH OrcamentoMedio AS(
	select AVG(orcamento) from Departamentos
)
SELECT  nome, orcamento
FROM Departamentos
WHERE orcamento > OrcamentoMedio

*/

WITH Medio AS(
	select AVG(orcamento) from Departamentos
)
SELECT  nome, orcamento
FROM Departamentos
WHERE orcamento > OrcamentoMedio

--15. Selecione os nomes dos departamentos com mais de dois funcion�rios.
SELECT d.nome, COUNT (f.departamento) AS totalFuncionarios
FROM Departamentos AS d
RIGHT JOIN Funcionarios AS f
ON d.codigo = f.departamento
GROUP BY d.nome
HAVING COUNT (f.departamento) > 2

--16. Selecione o nome e o sobrenome dos funcion�rios que trabalham nos departamentos com tr�s menores or�amentos.
WITH MenoresOrcamentos AS(
	SELECT TOP 3 * FROM Departamentos
	ORDER BY orcamento ASC
)
SELECT f.nome, f.sobrenome, d.nome AS Departamento
FROM Funcionarios AS f
RIGHT JOIN MenoresOrcamentos AS d
ON f.departamento = d.codigo