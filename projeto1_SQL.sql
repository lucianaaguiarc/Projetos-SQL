/************************************/
/***************PROJETO 1************/
/************************************/


--ETAPA 1: MODELAR O BANCO
--################################################################################################################
--Criar a tabela Fabricantes
CREATE TABLE Fabricantes(
	codigo INT,
	nome VARCHAR (255) NOT NULL,
	PRIMARY KEY (codigo)
)

--Popular a tablela Fabricantes
INSERT INTO Fabricantes(Codigo,Nome) VALUES(1,'Sony');
INSERT INTO Fabricantes(Codigo,Nome) VALUES(2,'Creative Labs');
INSERT INTO Fabricantes(Codigo,Nome) VALUES(3,'Hewlett-Packard');
INSERT INTO Fabricantes(Codigo,Nome) VALUES(4,'Iomega');
INSERT INTO Fabricantes(Codigo,Nome) VALUES(5,'Fujitsu');
INSERT INTO Fabricantes(Codigo,Nome) VALUES(6,'Winchester');

--Criar tabela Produtos
CREATE TABLE Produtos (
	codigo INT,
	nome VARCHAR (255) NOT NULL,
	preco DECIMAL (5,2),
	fabricante INT NOT NULL FOREIGN KEY REFERENCES Fabricantes(codigo),
	PRIMARY KEY (codigo)
)

--Popular a tabela Produtos
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(1,'Hard drive',240,5);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(2,'Memory',120,6);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(3,'ZIP drive',150,4);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(4,'Floppy disk',5,6);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(5,'Monitor',240,1);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(6,'DVD drive',180,2);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(7,'CD drive',90,2);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(8,'Printer',270,3);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Produtos(Codigo,Nome,Preco,Fabricante) VALUES(10,'DVD burner',180,2);
--################################################################################################################

--ETAPA 2: 17 PERGUNTAS E RESPOSTAS

--1. Abra a tabela Produtos
SELECT * FROM Produtos

--2. Selecione os nomes de todos os produtos da loja.
SELECT nome
FROM Produtos

--3. Selecione os nomes e os preços de todos os produtos da loja.
SELECT nome,preco
FROM Produtos

--4. Selecione o nome dos produtos com preço menor ou igual a 200.
SELECT nome
FROM Produtos
WHERE preco <= 200

--5. Selecione todos os produtos com um preço entre 60 e 120.
SELECT nome
FROM Produtos
WHERE preco BETWEEN 60 AND 120

--6. Selecione o nome, o preço e crie uma nova coluna com o preço em centavos (ou seja, o preço deve ser multiplicado por 100).
SELECT nome, preco, preco*100
FROM Produtos

--7. Renomeie a nova coluna de preco em centavos para Preco_Centavos
SELECT nome, preco, preco*100 as Preco_Centavos
FROM Produtos

--8. Calcule o preço médio de todos os produtos.
SELECT AVG(preco) AS precoMedio
FROM Produtos

--9. Selecione o preço do produto mais barato.
SELECT MIN (preco) AS produtoMaisBarato
FROM Produtos

--10. Calcule o preço médio de todos os produtos com código do fabricante igual a 2.
SELECT AVG(preco) precoMedio
FROM Produtos
WHERE fabricante = 2

--11. Calcule o número de produtos que existem na base
SELECT COUNT (*) AS totalProdutos
FROM Produtos

--12. Calcule o número de produtos com um preço maior ou igual a 180.
SELECT COUNT (*) AS totalProdutos
FROM Produtos
WHERE preco >= 180

--13. Selecione o nome e o preço de todos os produtos com um preço maior ou igual a 180 e classifique primeiro por preço (em ordem decrescente) e, em seguida, por nome (em ordem crescente).
SELECT nome, preco
FROM Produtos
WHERE preco >= 180
ORDER BY preco DESC, nome ASC

--14. Selecione todos os dados dos produtos, incluindo todos os dados do fabricante de cada produto.
SELECT * 
FROM Produtos AS p
LEFT JOIN Fabricantes as f
ON p.fabricante = f.codigo

--15. Selecione o nome do produto, preço e nome do fabricante de todos os produtos.
SELECT p.nome as produto,
	   p.preco, 
	   f.nome as fabricante
FROM Produtos AS p
LEFT JOIN Fabricantes as f
ON p.fabricante = f.codigo

--16. Selecione o nome do fabricante com o preço médio dos produtos de cada fabricante
SELECT f.nome AS fabricante,
	   avg(p.preco) AS precoMedio
FROM Produtos AS p
LEFT JOIN Fabricantes AS f
ON p.fabricante = f.codigo
GROUP BY f.nome

--17. Selecione os nomes dos fabricantes cujos produtos têm um preço médio maior ou igual a 150.
SELECT f.nome,
	   avg(p.preco) AS precoMedio
FROM PRODUTOS as p
LEFT JOIN Fabricantes as f
ON p.fabricante = f.codigo
GROUP BY f.nome
HAVING AVG(p.preco) >= 150
