/************************************/
/***************PROJETO 3************/
/************************************/

--################################################################################################################
--ETAPA 1: MODELAR O BANCO
--################################################################################################################
CREATE TABLE tb_alunos(
	matricula INT PRIMARY KEY,
	nomeAluno VARCHAR(30) NOT NULL,
	genero CHAR(3),
	notaEst DECIMAL (5,2),
	notaPort DECIMAL (5,2),
	localEscola VARCHAR(30) NOT NULL,
	nomeProfessor VARCHAR(50) NOT NULL
);


--################################################################################################################
--ETAPA 2: POPULAR A TABELA
--################################################################################################################
INSERT INTO tb_alunos (Matricula, nomeAluno, Genero, notaEst, notaPort, localEscola, nomeProfessor)

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
--ETAPA 3: 15 PERGUNTAS E RESPOSTAS
--################################################################################################################

-------------------------------------
----Treino de sele��o de dados-------
-------------------------------------

--1. Selecione apenas as colunas nome_aluno, nota_est e nota_port.
SELECT nomeAluno, NotaEst, NotaPort
FROM tb_alunos

--2. Selecione todas as colunas exceto a coluna g�nero.
SELECT nomeAluno, NotaEst, NotaPort, localEscola, nomeProfessor
FROM tb_alunos

--OU

SELECT * INTO tb_alunos_sem_coluna_genero 
FROM tb_alunos

SELECT * FROM tb_alunos_sem_coluna_genero

ALTER TABLE tb_alunos_sem_coluna_genero DROP COLUMN genero

SELECT * FROM tb_alunos_sem_coluna_genero

DROP TABLE tb_alunos_sem_coluna_genero

--3. Mantenha todas as colunas mas reordene e coloque a coluna g�nero como a primeira.
SELECT genero,nomeAluno, NotaEst, NotaPort, localEscola, nomeProfessor
FROM tb_alunos




-------------------------------------
----Treino de ordena��o de dados-----
-------------------------------------
--O par�metro ORDER BY usa a forma ascendente como ordena��o padr�o

--1. Ordene os dados por nota_est do maior para o menor.
SELECT * 
FROM tb_alunos
ORDER BY notaEst DESC

--2. Ordene os dados pelo nome da primeira at� a �ltima letra do alfabeto (A a Z).
SELECT * 
FROM tb_alunos
ORDER BY nomeAluno ASC

--3. Ordene os dados pelo g�nero, sendo o g�nero masculino o primeiro.
SELECT * 
FROM tb_alunos
ORDER BY genero DESC

--4. Ordene os dados por escola e depois por professor
SELECT * 
FROM tb_alunos
ORDER BY localEscola, nomeProfessor

-------------------------------------
-----Treino de filtro de dados-------
-------------------------------------

--1. Filtre os dados para estudantes que s�o do g�nero masculino e s�o da escola do sul.
SELECT * 
FROM tb_alunos
WHERE genero = 'MAS' AND localEscola = 'sul'

--2. Filtre os dados para estudantes que tiraram 4 ou mais em estat�stica.
SELECT nomeAluno, notaEst, notaPort
FROM tb_alunos
WHERE notaEst >= 4

--3. Use o filtro para mostrar quantos estudantes tiveram uma nota em estat�stica de 4 ou mais e nota de portugu�s de 3 ou mais.
SELECT nomeAluno, notaEst, notaPort
FROM tb_alunos
WHERE notaEst >= 4 AND notaPort >= 3

--4. Filtre os estudantes que tiraram 3 ou menos em estat�stica ou tiraram mais de 4 em portugu�s.
SELECT nomeAluno, notaEst, notaPort
FROM tb_alunos
WHERE notaEst <= 3 OR notaPort > 4

--5. Filtre os nomes Larissa, Alexandre e Val�ria.
SELECT nomeAluno
FROM tb_alunos
WHERE nomeAluno IN ('Larissa', 'Alexandre', 'Valeria') --Val�ria foi inserido sem acento no banco e a collationdo banco � CI_AS


--6. Filtre quem n�o tem notas em estat�stica.

--http://www.w3big.com/pt/sql/sql-null-values.html
--https://ramkedem.com/en/sql-server-is-null/

SELECT nomeAluno, notaEst
FROM tb_alunos
WHERE notaEst IS NULL

/*
A query abaixo n�o retorna dado. Veja o porqu� em: https://ramkedem.com/en/sql-server-is-null/
SELECT nomeAluno, notaEst
FROM tb_alunos
WHERE notaEst = NULL
*/
--7. Filtre s� os que tiveram nota em estat�stica.
SELECT nomeAluno, notaEst
FROM tb_alunos
WHERE notaEst IS NOT NULL

--8. Filtre quem teve nota em estat�stica diferente de 0.
--Como o valor null n�o � pass�vel de compara��o, ele n�o � retornado na query 

SELECT nomeAluno, notaEst
FROM tb_alunos
WHERE notaEst <> 0

--NULL n�o � o mesmo que um valor vazio, � considerado desconhecido, da� NULL=NULL � uma opera��o falsa
--NULL � um missing value ou valor faltante