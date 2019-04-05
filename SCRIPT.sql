/*
TRABALHO FINAL BANCO DE DADOS II
PROFESSOR: GUILHERME ANZOLIN
ALUNOS: ADRIAN ALVES, DANIEL FLAMIA E DANTON BERTUOL
*/

/*Criacao do Banco*/
DROP DATABASE IF EXISTS TrabalhoFinal;
CREATE DATABASE TrabalhoFinal;
USE TrabalhoFinal;
SET SQL_SAFE_UPDATES=0;

/* --- TABELAS --- */

/*1 - Criacao da Tabela de Clientes*/
CREATE TABLE cliente(
	idCli INT NOT NULL AUTO_INCREMENT,
	nomeCli VARCHAR(60) NOT NULL,
	sobrenomeCli VARCHAR(100) NOT NULL,
	logradouroCli VARCHAR(100),
	bairroCli VARCHAR(100),
	cidadeCli VARCHAR(100) NOT NULL,
	ufCli VARCHAR(2),
	rgCli BIGINT,
	cpfCli BIGINT NOT NULL,
	telefoneCli BIGINT NOT NULL,
	emailCli VARCHAR(70),
	PRIMARY KEY (idCli)
);

/*2 - Criacao da Tabela de Funcionarios*/
CREATE TABLE funcionario(
	idFun INT NOT NULL AUTO_INCREMENT,
	nomeFun VARCHAR(60) NOT NULL,
	sobrenomeFun VARCHAR(100) NOT NULL,
	logradouroFun VARCHAR(100) NOT NULL,
	bairroFun VARCHAR(100),
	cidadeFun VARCHAR(100) NOT NULL,
	ufFun VARCHAR(2),
	rgFun BIGINT NOT NULL,
	cpfFun BIGINT NOT NULL,
	telefoneFun BIGINT NOT NULL,
	emailFun VARCHAR(120),
	salarioFun DOUBLE NOT NULL,
	comentarioFun VARCHAR(150),
	statusFun CHAR(1) NOT NULL,
	PRIMARY KEY (idFun)
);

/*3 - Criacao da Tabela de Fornecedores*/
CREATE TABLE fornecedor(
	idFor INT NOT NULL AUTO_INCREMENT,
	nomeFor VARCHAR(60) NOT NULL,
	cnpjFor BIGINT NOT NULL,
	cidadeFor VARCHAR(100) NOT NULL,
	ufFor VARCHAR(2) NOT NULL,
	logradouroFor VARCHAR(100) NOT NULL,
	cepFor INT NOT NULL,
	bairroFor VARCHAR(80),
	numFor INT,
	telefoneFor BIGINT NOT NULL,
	emailFor VARCHAR(200),
	PRIMARY KEY (idFor)
);

/*4 - Criacao da Tabela de Vendas*/
CREATE TABLE venda(
	idVen INT NOT NULL AUTO_INCREMENT,
	dataVen DATE NOT NULL,
	precoParcialVen FLOAT NOT NULL,
	descontoVen INT,
	precoTotVen DOUBLE,
	idClienteVen INT,
	idFuncionarioVen INT,
	PRIMARY KEY(idVen),
	FOREIGN KEY (idClienteVen) REFERENCES cliente (idCli),
	FOREIGN KEY (idFuncionarioVen) REFERENCES funcionario (idFun)
);

/*5 - Criacao da Tabela das Marcas dos Veiculos*/
CREATE TABLE marca(
	idMar INT NOT NULL AUTO_INCREMENT,
	descricaoMar VARCHAR(50),
	PRIMARY KEY (idMar)
);

/*6 - Criacao da Tabela de Veiculos*/
CREATE TABLE veiculo(
	idVei INT NOT NULL AUTO_INCREMENT,
	modeloVei VARCHAR(100) NOT NULL,
	corVei VARCHAR(25) NOT NULL,
	fabVei YEAR,
	anoModVei YEAR NOT NULL,
	placaVei VARCHAR(7) NOT NULL,
	comentarioVei VARCHAR(150),
	idMarcaVei INT,
	idClienteVei INT,
	PRIMARY KEY (idVei),
	FOREIGN KEY (idMarcaVei) REFERENCES marca (idMar),
	FOREIGN KEY (idClienteVei) REFERENCES cliente (idCli)
);

/*7 - Criacao da Tabela de Servicos (venda)*/
CREATE TABLE servico(
	idSer INT NOT NULL AUTO_INCREMENT,
	descricaoSer VARCHAR(200) NOT NULL,
	dataSer DATE NOT NULL,
	valorParcialSer FLOAT NOT NULL,
	descontoSer INT,
	valorTotalSer DOUBLE,
	idVeiculoSer INT,
	PRIMARY KEY (idSer),
	FOREIGN KEY (idVeiculoSer) REFERENCES veiculo (idVei)
);

/*8 - Criacao da Tabela de Produtos*/
CREATE TABLE produto(
	idPro INT NOT NULL AUTO_INCREMENT,
	descricaoPro VARCHAR(200) NOT NULL,
	quantidadePro INT NOT NULL,
	precoCustoPro DOUBLE NOT NULL,
	precoVendaPro DOUBLE NOT NULL,
	idFornecedorPro INT,
	PRIMARY KEY (idPro),
	FOREIGN KEY (idFornecedorPro) REFERENCES fornecedor (idFor)
);

/*9 - Criacao da Tabela dos Itens de Venda*/
CREATE TABLE itemVenda(
	idITv INT NOT NULL AUTO_INCREMENT,
	quantidadeITv INT NOT NULL,
	precoUnitITv FLOAT NOT NULL,
	idVendaITv INT,
	idProdutoITv INT,
	PRIMARY KEY (idITv),
	FOREIGN KEY (idVendaITv) REFERENCES venda (idVen),
	FOREIGN KEY (idProdutoITv) REFERENCES produto (idPro)
);

/*10 - Criacao da Tabela da Categoria dos Servicos*/
CREATE TABLE categoriaServico(
	idCAs INT NOT NULL AUTO_INCREMENT,
	descricaoCAs VARCHAR(50) NOT NULL,
	valorUnitCAs FLOAT NOT NULL,
	PRIMARY KEY (idCAs)
);

/*11 - Criacao da Tabela dos Itens de Servicos*/
CREATE TABLE itemServico(
	idITs INT NOT NULL AUTO_INCREMENT,
	quantidadeITs INT NOT NULL,
	precoUnitITs FLOAT NOT NULL,
	idServicoITs INT,
	idCategoriaITs INT,
	idFuncionarioITs INT,
	PRIMARY KEY (idITs),
	FOREIGN KEY (idServicoITs) REFERENCES servico (idSer),
	FOREIGN KEY (idCategoriaITs) REFERENCES categoriaServico (idCAs),
	FOREIGN KEY (idFuncionarioITs) REFERENCES funcionario (idFun)
);

/* --- STORES PROCEDURES --- */

/*Procedure 1 - Insere Clientes*/
DELIMITER $
CREATE PROCEDURE INSERE_CLIENTE(	
	IN nomeCli VARCHAR(60),
	IN sobrenomeCli VARCHAR(100), 
	IN logradouroCli VARCHAR(100),
	IN bairroCli VARCHAR(100),
	IN cidadeCli VARCHAR(100),
	IN ufCli VARCHAR(2), 
	IN rgCli BIGINT,
	IN cpfCli BIGINT,
	IN telefoneCli BIGINT, 
	IN emailCli VARCHAR(70))
BEGIN 
	INSERT INTO cliente VALUES (null, nomeCli, sobrenomeCli, logradouroCli, bairroCli, cidadeCli, ufCli, rgCli, cpfCli, telefoneCli, emailCli); 
END $
DELIMITER ; 
CALL INSERE_CLIENTE('Danton', 'Bertuol', 'Rua Nossa Senhora', 'Centro', 'Machadinho', 'RS', 4345432, 83743939852, 99312332, 'dantonbertuol@hotmail.com');
CALL INSERE_CLIENTE('Daniel', 'Flamia', 'Avenida Brasil', 'Interior', 'Machadinho', 'RS', 4351732, 84739402394, 99317432, 'danielflamia@hotmail.com');
CALL INSERE_CLIENTE('Adrian', 'Alves', 'Rua Marechal', 'Centro', 'Machadinho', 'RS', 0305032, 23403294832,99313213 , 'adrianalves@hotmail.com');
CALL INSERE_CLIENTE('Felipe', 'Turra', 'Rua Joaçabense', 'Centro', 'Machadinho', 'RS', 4323495, 65843294752,99315342 , 'felipeturra@hotmail.com');
CALL INSERE_CLIENTE('Marcos', 'Flamia', 'Rua Capinzalense', 'Centro', 'Joaçaba', 'SC', 1326442, 23495942042, 99984752, 'marcosflamia@hotmail.com');
CALL INSERE_CLIENTE('Marcos', 'Grezele', 'Avenida Santissimo', 'Centro', 'Joaçaba', 'SC', 4441438, 12312393321, 99047568, 'marcosgrezele@hotmail.com');
CALL INSERE_CLIENTE('Julia', 'Menon', 'Avenia JK', 'Interior', 'Joaçaba', 'SC', 8464932, 31232932132, 99354354, 'juliamenon@hotmail.com');
CALL INSERE_CLIENTE('Catarina', 'Vestipalem', 'Avenida Frei Teofilo', 'Interior', 'Joaçaba', 'SC', 1309540, 31231241242, 99341212, 'catarinavestipalem@hotmail.com');
CALL INSERE_CLIENTE('Lurdes', 'Vicente', 'Rua Travessa B', 'Interior', 'Joaçaba', 'SC', 3405602, 31283901283, 99313490, 'lurdesvicente@hotmail.com');
CALL INSERE_CLIENTE('Silvester', 'Stallone', 'Avenida Rio Grande', 'Centro', 'Capinzal', 'SC', 1205043, 31239128332, 99386554, 'silvesterstallone@hotmail.com');
CALL INSERE_CLIENTE('Daniela', 'Bertuol', 'Rua General', 'Centro', 'Capinzal', 'SC', 2304402, 37182379124, 96312334, 'danielabertuol@hotmail.com');
CALL INSERE_CLIENTE('Ingrid', 'Guimarães', 'Rua Bom Parto', 'Centro', 'Capinzal', 'SC', 8735893, 37198237126, 99817345, 'ingridguimaraes@hotmail.com');

/*Procedure 2 - Insere Funcionarios*/
DELIMITER $
CREATE PROCEDURE INSERE_FUNCIONARIO(	
	IN nomeFun VARCHAR(60),
	IN sobrenomeFun VARCHAR(100),
	IN logradouroFun VARCHAR(100),
	IN bairroFun VARCHAR(100),
	IN cidadeFun VARCHAR(100),
	IN ufFun VARCHAR(2),
	IN rgFun BIGINT,
	IN cpfFun BIGINT,
	IN telefoneFun BIGINT,
	IN emailFun VARCHAR(120),
	IN salarioFun DOUBLE,
	IN comentarioFun VARCHAR(150),
	IN statusFun CHAR(1))
BEGIN 
	INSERT INTO funcionario VALUES (null, nomeFun, sobrenomeFun, logradouroFun, bairroFun, cidadeFun, ufFun, rgFun, cpfFun, telefoneFun, emailFun, salarioFun, comentarioFun, statusFun); 
END $
DELIMITER ; 
CALL INSERE_FUNCIONARIO('Jorge', 'Bertuol', 'Rua Nossa Senhora', 'Centro', 'Machadinho', 'RS', 4345432, 83743939852, 99312332, 'dantonbertuol@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Frederico', 'Flamia', 'Avenida Brasil', 'Interior', 'Machadinho', 'RS', 4351732, 84739402394, 99317432, 'danielflamia@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Alana', 'Alves', 'Rua Marechal', 'Centro', 'Machadinho', 'RS', 0305032, 23403294832,99313213 , 'adrianalves@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('João', 'Turra', 'Rua Joaçabense', 'Centro', 'Machadinho', 'RS', 4323495, 65843294752,99315342 , 'felipeturra@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Leonir', 'Flamia', 'Rua Capinzalense', 'Centro', 'Joaçaba', 'SC', 1326442, 23495942042, 99984752, 'marcosflamia@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('José', 'Grezele', 'Avenida Santissimo', 'Centro', 'Joaçaba', 'SC', 4441438, 12312393321, 99047568, 'marcosgrezele@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Juliana', 'Menon', 'Avenia JK', 'Interior', 'Joaçaba', 'SC', 8464932, 31232932132, 99354354, 'juliamenon@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Bernardete', 'Vestipalem', 'Avenida Frei Teofilo', 'Interior', 'Joaçaba', 'SC', 1309540, 31231241242, 99341212, 'catarinavestipalem@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Silvino', 'Vicente', 'Rua Travessa B', 'Interior', 'Joaçaba', 'SC', 3405602, 31283901283, 99313490, 'lurdesvicente@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Tiago', 'Stallone', 'Avenida Rio Grande', 'Centro', 'Capinzal', 'SC', 1205043, 31239128332, 99386554, 'silvesterstallone@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Joana', 'Bertuol', 'Rua General', 'Centro', 'Capinzal', 'SC', 2304402, 37182379124, 96312334, 'danielabertuol@hotmail.com',1000.00,'Bom','A');
CALL INSERE_FUNCIONARIO('Paula', 'Guimarães', 'Rua Bom Parto', 'Centro', 'Capinzal', 'SC', 8735893, 37198237126, 99817345, 'ingridguimaraes@hotmail.com',1000.00,'Bom','A');

/*Procedure 3 - Insere Fornecedores*/
DELIMITER $
CREATE PROCEDURE INSERE_FORNECEDOR(	
	IN nomeFor VARCHAR(60),
	IN cnpjFor BIGINT,
	IN cidadeFor VARCHAR(100),
	IN ufFor VARCHAR(2),
	IN logradouroFor VARCHAR(100),
	IN cepFor INT,
	IN bairroFor VARCHAR(80),
	IN numFor INT,
	IN telefoneFor BIGINT,
	IN emailFor VARCHAR(200))
BEGIN 
	INSERT INTO fornecedor VALUES (null, nomeFor, cnpjFor, cidadeFor, ufFor, logradouroFor, cepFor, bairroFor, numFor, telefoneFor, emailFor); 
END $
DELIMITER ; 
CALL INSERE_FORNECEDOR('Experts', 12324125236342, 'Capinzal', 'SC', 'Rua José Bonifácio', 99880000, 'Centro', 102, 99422345, 'experts@hotmail.com');
CALL INSERE_FORNECEDOR('DinDon', 12324125236342, 'Florianopolis', 'SC', 'Avenida Brasil', 99883100, 'Centro', 434, 87432345, 'dindon@hotmail.com');
CALL INSERE_FORNECEDOR('ProParts', 123241892312342, 'Erechim', 'RS', 'Rua JK', 95880000, 'Centro',1234 , 98875432, 'proparts@hotmail.com');
CALL INSERE_FORNECEDOR('ExtremeParts', 12324125232342, 'Passo Fundo', 'RS', 'Rua Adelino', 99770000, 'Centro', 5424, 95322345, 'extremeparts@hotmail.com');
CALL INSERE_FORNECEDOR('Vale das Peças', 12324126546342, 'Joaçaba', 'SC', 'Rua Independencia', 94380000, 'Centro', 1233, 96544823, 'valedaspecas@hotmail.com');

/*Procedure 4 - Insere Venda*/
DELIMITER $
CREATE PROCEDURE INSERE_VENDA(	
	IN dataVen DATE,
	IN precoParcialVen FLOAT,
	IN descontoVen INT,
	IN idClienteVen INT,
	IN idFuncionarioVen INT)
BEGIN 
	INSERT INTO venda VALUES (null, dataVen, precoParcialVen, descontoVen, (precoParcialVen*((1)-(descontoVen/100))), idClienteVen, idFuncionarioVen);
END $
DELIMITER ; 
CALL INSERE_VENDA('2015-11-10', 20, 20, 1, 1);
CALL INSERE_VENDA('2015-11-10', 30, 20, 1, 2);
CALL INSERE_VENDA('2015-11-10', 40, 20, 2, 3);
CALL INSERE_VENDA('2015-12-12', 50, 20, 2, 4);
CALL INSERE_VENDA('2015-12-12', 60, 20, 3, 5);
CALL INSERE_VENDA('2016-01-28', 70, 20, 3, 6);
CALL INSERE_VENDA('2016-01-28', 80, 20, 4, 7);
CALL INSERE_VENDA('2016-01-28', 90, 20, 4, 8);
CALL INSERE_VENDA('2016-02-21', 100, 20, 5, 9);
CALL INSERE_VENDA('2016-02-21', 110, 20, 5, 10);
CALL INSERE_VENDA('2016-02-21', 120, 20, 6, 11);
CALL INSERE_VENDA('2016-03-11', 130, 20, 6, 12);
CALL INSERE_VENDA('2016-03-11', 140, 20, 7, 3);
CALL INSERE_VENDA('2016-03-11', 150, 20, 7, 4);
CALL INSERE_VENDA('2016-04-18', 160, 20, 8, 5);
CALL INSERE_VENDA('2016-04-18', 170, 20, 8, 6);
CALL INSERE_VENDA('2016-04-18', 180, 20, 9, 7);
CALL INSERE_VENDA('2016-06-23', 190, 20, 12, 8);
CALL INSERE_VENDA('2016-06-23', 200, 20, 10, 9);
CALL INSERE_VENDA('2016-06-23', 210, 20, 11, 10);

/*Procedure 5 - Insere Marca*/
DELIMITER $
CREATE PROCEDURE INSERE_MARCA(	
	IN descricaoMar VARCHAR(50))
BEGIN 
	INSERT INTO marca VALUES (null, descricaoMar); 
END $
DELIMITER ; 
CALL INSERE_MARCA('Renault');
CALL INSERE_MARCA('Mercedes');
CALL INSERE_MARCA('Fiat');
CALL INSERE_MARCA('Hyundai');
CALL INSERE_MARCA('Honda');

/*Procedure 6 - Insere Veiculo*/
DELIMITER $
CREATE PROCEDURE INSERE_VEICULO(	
	IN modeloVei VARCHAR(100),
	IN corVei VARCHAR(25),
	IN fabVei YEAR,
	IN anoModVei YEAR,
	IN placaVei VARCHAR(7),
	IN comentarioVei VARCHAR(150),
	IN idMarcaVei INT,
	IN idClienteVei INT)
BEGIN 
	INSERT INTO veiculo VALUES (null, modeloVei, corVei, fabVei, anoModVei, placaVei, comentarioVei, idMarcaVei, idClienteVei); 
END $
DELIMITER ; 
CALL INSERE_VEICULO('Punto', 'Vermelho', 2016, 2016, 'AAA-123', 'comentario', 3, 1);
CALL INSERE_VEICULO('Uno', 'Branco', 2016, 2016, 'AAA-123', 'comentario', 3, 2);
CALL INSERE_VEICULO('C180', 'Branco', 2016, 2016, 'AAA-123', 'comentario', 2, 3);
CALL INSERE_VEICULO('CLS', 'Preto', 2016, 2016, 'AAA-123', 'comentario', 2, 4);
CALL INSERE_VEICULO('Sandero', 'Preto', 2016, 2016, 'AAA-123', 'comentario', 1, 5);
CALL INSERE_VEICULO('Duster', 'Branco', 2016, 2016, 'AAA-123', 'comentario', 1, 6);
CALL INSERE_VEICULO('I30', 'Prata', 2016, 2016, 'AAA-123', 'comentario', 4, 7);
CALL INSERE_VEICULO('IX35', 'Prata', 2016, 2016, 'AAA-123', 'comentario', 4, 8);
CALL INSERE_VEICULO('Civic', 'Preto', 2016, 2016, 'AAA-123', 'comentario', 5, 9);
CALL INSERE_VEICULO('City', 'Prata', 2016, 2016, 'AAA-123', 'comentario', 5, 10);
CALL INSERE_VEICULO('Strada', 'Vermelho', 2016, 2016, 'AAA-123', 'comentario', 3, 11);
CALL INSERE_VEICULO('Toro', 'Bordo', 2016, 2016, 'AAA-123', 'comentario', 3, 12);


/*Procedure 7 - Insere Servico*/
DELIMITER $
CREATE PROCEDURE INSERE_SERVICO(
	IN descricaoSer VARCHAR(200),
	IN dataSer DATE,
	IN valorParcialSer FLOAT,
	IN descontoSer INT,
	IN idVeiculoSer INT)
BEGIN 
	INSERT INTO servico VALUES (null, descricaoSer, dataSer, valorParcialSer, descontoSer, (valorParcialSer*((1)-descontoSer/100)), idVeiculoSer); 
END $
DELIMITER ; 
CALL INSERE_SERVICO('Pintura', '2016-10-28', 50, 5, 1);
CALL INSERE_SERVICO('Pintura', '2016-10-28', 100, 5, 2); 
CALL INSERE_SERVICO('Geometria', '2016-09-23', 120, 5, 3); 
CALL INSERE_SERVICO('Geometria', '2016-09-21', 140, 5, 4); 
CALL INSERE_SERVICO('Balanceamento', '2016-08-30', 140, 5, 5);
CALL INSERE_SERVICO('Limpeza dos Bicos', '2016-08-25', 160, 5, 6);
CALL INSERE_SERVICO('Instalação de Kit Esportivo', '2016-08-06', 170, 5, 7); 
CALL INSERE_SERVICO('Instalação de Som', '2016-07-21', 180, 5, 8); 
CALL INSERE_SERVICO('Instalação de Som', '2016-07-20', 190, 5, 9); 
CALL INSERE_SERVICO('Pintura', '2016-06-28', 200, 5, 10);  
CALL INSERE_SERVICO('Geometria', '2016-06-28', 220, 5, 11);
CALL INSERE_SERVICO('Balanceamento', '2016-06-15', 210, 5, 12); 
CALL INSERE_SERVICO('Pintura', '2016-06-08', 240, 5, 1); 
CALL INSERE_SERVICO('Geometria', '2016-05-28', 250, 5, 2); 
CALL INSERE_SERVICO('Balanceamento', '2016-05-19', 260, 5, 3);  
CALL INSERE_SERVICO('Instalação de Kit Esportivo', '2016-05-10', 100, 5, 4);
CALL INSERE_SERVICO('Pintura', '2016-04-28', 140, 5, 5); 
CALL INSERE_SERVICO('Geometria', '2016-04-20', 150, 5, 6); 
CALL INSERE_SERVICO('Balanceamento', '2016-04-05', 180, 5, 7); 
CALL INSERE_SERVICO('Pintura', '2016-03-10', 195, 5, 8);    

/*Procedure 8 - Insere Produto*/
DELIMITER $
CREATE PROCEDURE INSERE_PRODUTO(
	IN descricaoPro VARCHAR(200),
	IN quantidadePro INT,
	IN precoCustoPro DOUBLE,
	IN precoVendaPro DOUBLE,
	IN idFornecedorPro INT)
BEGIN 
	INSERT INTO produto VALUES (null, descricaoPro, quantidadePro, precoCustoPro, precoVendaPro, idFornecedorPro); 
END $
DELIMITER ; 
CALL INSERE_PRODUTO('Kit Turbo', 10, 800, 1000, 1);
CALL INSERE_PRODUTO('Kit Som Automotivo', 15, 1500, 3000, 2);
CALL INSERE_PRODUTO('Tinta', 100, 30, 50, 3);
CALL INSERE_PRODUTO('Suspensão a Ar', 20, 700, 1500, 4);
CALL INSERE_PRODUTO('Amortecedor', 50, 150, 300, 5); 

/*Procedure 9 - Insere Item da Venda*/
DELIMITER $
CREATE PROCEDURE INSERE_ITEM_VENDA(
	IN quantidadeITv INT,
	IN precoUnitITv FLOAT,
	IN idVendaITv INT,
	IN idProdutoITv INT)
BEGIN 
	INSERT INTO itemVenda VALUES (null, quantidadeITv, precoUnitITv, idVendaITv, idProdutoITv ); 
END $
DELIMITER ; 
CALL INSERE_ITEM_VENDA(1, 1000, 1, 1); 
CALL INSERE_ITEM_VENDA(2, 3000, 2, 2); 
CALL INSERE_ITEM_VENDA(3, 50, 3, 3); 
CALL INSERE_ITEM_VENDA(4, 1500, 4, 4); 
CALL INSERE_ITEM_VENDA(5, 300, 5, 5); 
CALL INSERE_ITEM_VENDA(1, 1000, 6, 1); 
CALL INSERE_ITEM_VENDA(2, 3000, 7, 2); 
CALL INSERE_ITEM_VENDA(3, 50, 8, 3); 
CALL INSERE_ITEM_VENDA(4, 1500, 9, 4); 
CALL INSERE_ITEM_VENDA(5, 300, 10, 5); 
CALL INSERE_ITEM_VENDA(1, 1000, 11, 1); 
CALL INSERE_ITEM_VENDA(2, 3000, 12, 2); 
CALL INSERE_ITEM_VENDA(3, 50, 13, 3); 
CALL INSERE_ITEM_VENDA(4, 1500, 14, 4); 
CALL INSERE_ITEM_VENDA(5, 300, 15, 5); 
CALL INSERE_ITEM_VENDA(1, 1000, 16, 1); 
CALL INSERE_ITEM_VENDA(2, 3000, 17, 2); 
CALL INSERE_ITEM_VENDA(3, 50, 18, 3); 
CALL INSERE_ITEM_VENDA(4, 1500, 19, 4); 
CALL INSERE_ITEM_VENDA(5, 300, 20, 5); 

/*Procedure 10 - Insere Categoria do Servico*/
DELIMITER $
CREATE PROCEDURE INSERE_CATEGORIA_SERVICO(
	IN descricaoCAs VARCHAR(50),
	IN valorUnitCAs FLOAT)
BEGIN 
	INSERT INTO categoriaServico VALUES (null, descricaoCAs, valorUnitCAs); 
END $
DELIMITER ; 
CALL INSERE_CATEGORIA_SERVICO('Geral', 10); 

/*Procedure 11 - Insere Item do Servico*/
DELIMITER $
CREATE PROCEDURE INSERE_ITEM_SERVICO(
	IN quantidadeITs INT,
	IN precoUnitITs FLOAT,
	IN idServicoITs INT,
	IN idCategoriaITs INT,
	IN idFuncionarioITs INT)
BEGIN 
	INSERT INTO itemServico VALUES (null, quantidadeITs, precoUnitITs, idServicoITs, idCategoriaITs, idFuncionarioITs); 
END $
DELIMITER ; 
CALL INSERE_ITEM_SERVICO(1, 50, 1, 1, 1);
CALL INSERE_ITEM_SERVICO(2, 100, 2, 1, 2); 
CALL INSERE_ITEM_SERVICO(3, 120, 3, 1, 3); 
CALL INSERE_ITEM_SERVICO(4, 140, 4, 1, 4); 
CALL INSERE_ITEM_SERVICO(5, 140, 5, 1, 5);  
CALL INSERE_ITEM_SERVICO(1, 160, 6, 1, 6);
CALL INSERE_ITEM_SERVICO(2, 170, 7, 1, 7); 
CALL INSERE_ITEM_SERVICO(3, 180, 8, 1, 8); 
CALL INSERE_ITEM_SERVICO(4, 190, 9, 1, 9); 
CALL INSERE_ITEM_SERVICO(5, 200, 10, 1, 10);  
CALL INSERE_ITEM_SERVICO(1, 220, 11, 1, 11);
CALL INSERE_ITEM_SERVICO(2, 210, 12, 1, 12); 
CALL INSERE_ITEM_SERVICO(3, 240, 13, 1, 1); 
CALL INSERE_ITEM_SERVICO(4, 250, 14, 1, 2); 
CALL INSERE_ITEM_SERVICO(5, 260, 15, 1, 3);  
CALL INSERE_ITEM_SERVICO(1, 100, 16, 1, 4);
CALL INSERE_ITEM_SERVICO(2, 140, 17, 1, 5); 
CALL INSERE_ITEM_SERVICO(3, 150, 18, 1, 6); 
CALL INSERE_ITEM_SERVICO(4, 180, 19, 1, 7); 
CALL INSERE_ITEM_SERVICO(5, 195, 20, 1, 8);  

select * from cliente;
select * from funcionario;
select * from venda;
select * from fornecedor;
select * from produto;
select * from itemServico;
select * from servico;
select * from categoriaServico;
select * from veiculo;
select * from marca;
select * from itemVenda;

-- Functions

-- Function que recebe o id de um cliente e um intervalo de datas (inicial e final) e retorna o valor total de vendas;
DELIMITER $
CREATE FUNCTION totalSales(id INTEGER, iDate DATE, fDate DATE)
RETURNS DOUBLE
    BEGIN
		RETURN (SELECT sum(v.precoTotVen) FROM venda v INNER JOIN cliente c ON v.idClienteVen = c.idCli WHERE c.idCli = id AND v.dataVen BETWEEN iDate AND fDate); 
    END $
DELIMITER ;
SELECT totalSales(1, '2016-08-01', '2016-10-30');

-- Function que recebe o id de um cliente e um intervalo de datas (inicial e final) e retorna o valor total de serviços;
DELIMITER $
CREATE FUNCTION totalServices(id INTEGER, iDate DATE, fDate DATE)
RETURNS DOUBLE
    BEGIN
		RETURN (SELECT sum(servico.valorTotalSer) FROM servico 
		INNER JOIN veiculo ON veiculo.idVei=servico.idVeiculoSer 
		INNER JOIN cliente ON cliente.idCli=veiculo.idClienteVei WHERE cliente.idCli = id AND servico.dataSer BETWEEN iDate AND fDate); 
    END $
DELIMITER ;
SELECT totalServices(1, '2016-08-01', '2016-10-30');

-- function que recebe o id de um cliente e um intervalo de datas (inicial e final) e retorna o valor total de vendas e serviços
DELIMITER $
CREATE FUNCTION venda_por_cliente(id INT,dataInicial DATE,dataFinal DATE)
RETURNS DOUBLE
	BEGIN
		RETURN ((SELECT totalServices(id,dataInicial,dataFinal)+totalSales(id,dataInicial,dataFinal)));
	END $
DELIMITER $
SELECT venda_por_cliente(1,'2016-11-01','2016-11-30');



-- Procedure que a partir de uma listagem de todos os funcionários atualize o salário de cada um com um incremento de 2% do total faturado em um período, utilizando cursor;
DELIMITER $
CREATE PROCEDURE incSalary(IN dIn DATE, IN dFi DATE)
BEGIN
DECLARE fim INTEGER DEFAULT 0;
        DECLARE cod INTEGER;
        DECLARE sal DOUBLE;
        DECLARE tServ DOUBLE;
        DECLARE tSale DOUBLE;
        DECLARE totalCollected CURSOR FOR SELECT idFun, salarioFun FROM funcionario;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;
        
        OPEN totalCollected;
        
        loop1 : LOOP
FETCH totalCollected INTO cod, sal;
            
            IF fim THEN
LEAVE loop1;
END IF;
            
            SET tSale = (SELECT SUM(precoTotVen) FROM venda v INNER JOIN funcionario f ON v.idFuncionarioVen = f.idFun WHERE f.idFun = cod AND v.dataVen BETWEEN dIn AND dFi);
            SET tServ = (SELECT SUM(precoUnitITs) FROM itemServico i INNER JOIN funcionario f ON i.idFuncionarioITs = f.idFun INNER JOIN servico s ON s.idSer = i.idServicoITs WHERE f.idFun = cod AND s.dataSer BETWEEN dIn AND dFi);
            SET sal = (sal + ((tSale + tServ) * 0.02));
            UPDATE funcionario SET salarioFun = sal WHERE idFun = cod;
            
END LOOP loop1;
        
        CLOSE totalCollected;
END $
DELIMITER ;
CALL incSalary('2016-10-01','2016-10-30');
SELECT * from funcionario;


/* --- VIEWS --- */

/*View 1 - Vendas dos Clientes*/
CREATE VIEW VENDAS_CLIENTE AS
	SELECT cliente.nomeCli, venda.dataVen, produto.descricaoPro, itemVenda.quantidadeITv, venda.precoTotVen 
	FROM venda
	INNER JOIN cliente ON cliente.idCli = venda.idClienteVen
	INNER JOIN itemVenda ON itemVenda.idVendaItv = venda.idVen
	INNER JOIN produto ON itemVenda.idProdutoITv = produto.idPro;
SELECT * FROM VENDAS_CLIENTE;

/*View 2 - Servicos dos Clientes*/
CREATE VIEW SERVICO_CLIENTE AS
	SELECT cliente.nomeCli, servico.dataSer, servico.descricaoSer, itemServico.quantidadeITs, servico.valorTotalSer 
	FROM servico
	INNER JOIN itemServico ON itemServico.idServicoIts = servico.idSer
	INNER JOIN categoriaServico ON itemServico.idCategoriaIts = categoriaServico.idCas
	INNER JOIN veiculo ON veiculo.idVei = servico.idVeiculoSer
	INNER JOIN cliente ON cliente.idCli = veiculo.idClienteVei;
SELECT * FROM SERVICO_CLIENTE;

/*View 3 - Top 10 Clientes*/
#DROP VIEW top10;
CREATE VIEW top10
	AS (SELECT (c.nomeCli) FROM servico s 
	INNER JOIN veiculo ON veiculo.idVei=s.idVeiculoSer
    INNER JOIN cliente c ON c.idCli=veiculo.idClienteVei
	INNER JOIN venda v ON v.idVen = c.idCli
	ORDER BY (s.valorTotalSer + v.precoTotVen) DESC LIMIT 0,10);
select * from top10;