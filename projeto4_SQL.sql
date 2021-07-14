/************************************/
/***************PROJETO 3************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################
CREATE TABLE tb_alunos2 (
					matricula INT PRIMARY KEY,
					nomeAluno VARCHAR(30) NOT NULL,
					genero CHAR(3),
					notaEst DECIMAL (5,2),
					notaPort DECIMAL (5,2),
					localEscola VARCHAR(30) NOT NULL,
					nomeProfessor VARCHAR(50) NOT NULL);

--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################
INSERT INTO tb_alunos2 (matricula, nomeAluno, genero, notaEst, notaPort, localEscola, nomeProfessor)

VALUES  (1, 'Fabricio', 'MAS', 4, 1, 'sul', 'Johnson'),
		(2, 'Alexandre', 'MAS', 3, 5, 'sul', 'Johnson'),
		(3, 'Larissa',NULL ,3,NULL , 'sul', 'Johnson'),
		(4, 'Monica ','FEM' , 4, 4, 'sul', 'Johnson'),
		(5, 'Veronica','MAS' , 4, 4, 'norte', 'Smith'),
		(6, 'Joao','FEM' , NULL, 4, 'norte', 'Smith'),
		(7, 'Valeria','MAS' , 5, 1, 'norte', 'Smith'),
		(8, 'Elvira','FEM' , 4, 5, 'sul', 'Fernanda'),
		(9, 'Pedro','FEM' , 5, 4, 'sul', 'Fernanda');
			   
--################################################################################################################
--ETAPA 3: 8 PERGUNTAS E RESPOSTAS
--################################################################################################################

-------------------------------------
----Treino de coluna calculada-------
-------------------------------------
--1. Crie uma nova coluna chamada de Pais onde todos os valores sejam iguais a �Brasil�� 

--Caso seja uma coluna apenas para essa consulta:
SELECT * ,  'Brasil' as pais
FROM tb_alunos2 

-- Caso seja uma altera��o na tabela
ALTER TABLE tb_alunos2
ADD pais varchar (6) NOT NULL 
CONSTRAINT df_pais DEFAULT 'Brasil';

SELECT * FROM tb_alunos2

/*Execute o script abaixo caso queira testar a cria��o da coluna pais com valores nulos
ALTER TABLE tb_alunos2 
DROP CONSTRAINT df_pais;
ALTER TABLE tb_alunos2 DROP COLUMN pais
SELECT * FROM tb_alunos2
*/

--OU, no caso da coluna aceitar valores null

ALTER TABLE tb_alunos2
ADD pais varchar (6) NOT NULL 
CONSTRAINT df_pais DEFAULT 'Brasil'
WITH VALUES;

SELECT * FROM tb_alunos2

/*
--Testes para lidar com erros de constraints
 --Vamos fazer o teste abaixo:
ALTER TABLE tb_alunos2 ADD pais varchar(50) DEFAULT 'Brasil'
SELECT * FROM tb_alunos2
--N�o inseriu o valor definido, porque est� fora da sintaxe do SQL SERVER

--Tente executar os script abaixo
ALTER TABLE tb_alunos2 DROP pais
ALTER TABLE tb_alunos2 DROP COLUMN pais

--N�o � poss�vel dropar colunas que sejam constraints, por isso, vamos �s solu��es abaixo:
-------------------------------------------------------------------------------------------------------------------------------
--Solu��o 1:
--Copie o valor da constraint da query que exclui a coluna abaixo:
ALTER TABLE tb_alunos2 DROP COLUMN pais

--Exclua a constraint
ALTER TABLE tb_alunos2 
DROP CONSTRAINT DF__tb_alunos2__pais__75A278F5;

--Exclua a coluna
ALTER TABLE tb_alunos2 DROP COLUMN pais

--Valide a opera��o
SELECT * FROM tb_alunos2
-------------------------------------------------------------------------------------------------------------------------------

--Solu��o 2
--Execute os dois primeiros passos juntos

--PASSO 1: Armazenar o nome da constraint em uma vari�vel
DECLARE @const VARCHAR (255)
SET @const = (SELECT NAME FROM  sys.objects WHERE object_id = 1989582126)

--PASSO 2: Exclua a constraint
EXECUTE ('ALTER TABLE tb_alunos2  DROP CONSTRAINT ' + @const)

--PASSO 3: Exclua a coluna
ALTER TABLE tb_alunos2 DROP COLUMN pais

--PASSO 4: Valide a opera��o
SELECT * FROM tb_alunos2
-------------------------------------------------------------------------------------------------------------------------------
*/


--2. Tanto as notas de estat�stica quanto as de portugu�s foram na verdade de 50. Crie uma nova vari�vel com o nome de nota_est_real que seja 10 vezes seu valor original.

--Caso seja uma coluna apenas para essa consulta:
SELECT * ,  notaEst * 10 as nota_est_real
FROM tb_alunos2 

-- Caso seja uma altera��o na tabela, como fazer?

--3. Crie uma nova coluna �estat_PRO� que � um indicador se o estudante ganhou um 4 ou mais na sua nota em estat�stica. Se ele tirou 4 ou mais, a nova coluna ser� �estat_PRO�, sen�o ser� �Reprovado�.

SELECT * ,
CASE
	WHEN notaEst > 4 THEN 'Aprovado'
	ELSE 'Reprovado'
END AS estat_PRO			
FROM tb_alunos2 

-------------------------------------
-------- Treino de agrega��o --------
-------- e sumariza��o de dados------
-------------------------------------

--1. Encontre a m�dia da nota de portugu�s para todos os alunos.
SELECT avg(notaPort) as mediaPortugues
FROM tb_alunos2 


--2. Encontre a nota m�xima de estat�stica de todos os estudantes.
SELECT max(notaEst) as maiorNotaEst
FROM tb_alunos2 

-------------------------------------
-------- Treino de agrega��o, -------
-------- sumariza��o e agupamento----
------------de dados-----------------
-------------------------------------

--1. Encontre a nota m�nima de estat�stica para cada escola.
SELECT localEscola, MIN(notaEst) AS notaMinima
FROM tb_alunos2
GROUP BY localEscola

--2. Encontre a nota m�dia de estat�stica para cada professor.
SELECT nomeProfessor, avg(notaEst) AS mediaEst
FROM tb_alunos2
GROUP BY nomeProfessor

--3. Encontre por g�nero o n�mero de estudantes, o m�nimo e a m�dia das notas de estat�stica.
SELECT genero, count(nomeAluno) AS totalALunos, MIN(notaEst) AS menorNotaEst, AVG(notaEst) AS mediaNotaEst
FROM tb_alunos2
GROUP BY genero

