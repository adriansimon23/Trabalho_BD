
--Inserindo Categorias
INSERT INTO categoria (nome, descricao) VALUES 
('Eletrônicos', 'Dispositivos eletrônicos e gadgets'),
('Roupas', 'Vestuário para todas as idades'),
('Alimentos', 'Produtos alimentícios e bebidas'),
('Móveis', 'Móveis para casa e escritório'),
('Brinquedos', 'Brinquedos e jogos para crianças');

go


--Inserindo Fornecedores
INSERT INTO fornecedor (nome, cnpj, telefone, email) VALUES 
('Fornecedor A', '12.345.678/0001-90', '(11) 91234-5678', 'fornecedorA@example.com'),
('Fornecedor B', '98.765.432/0001-01', '(21) 98765-4321', 'fornecedorB@example.com'),
('Fornecedor C', '11.222.333/0001-02', '(31) 99876-5432', 'fornecedorC@example.com');
go

--Inserindo Produtos

INSERT INTO produto (nome, descricao, preco, fornecedor_id, categoria_id) VALUES 
('Smartphone XYZ', 'Smartphone com 128GB de armazenamento', 1999.99, 1, 1),
('Camiseta Estampada', 'Camiseta de algodão com estampa', 49.90, 2, 2),
('Cerveja Artesanal', 'Cerveja feita com ingredientes naturais', 15.00, 3, 3),
('Sofá de Couro', 'Sofá confortável de couro', 2999.99, 1, 4),
('Boneca de Pano', 'Boneca de pano feita à mão', 39.90, 2, 5),
('Laptop ABC', 'Laptop com 16GB de RAM e 512GB SSD', 4999.99, 1, 1),
('Calça Jeans', 'Calça jeans de alta qualidade', 89.90, 2, 2),
('Suco Natural', 'Suco de frutas naturais', 5.00, 3, 3),
('Mesa de Jantar', 'Mesa de jantar de madeira', 1499.99, 1, 4),
('Quebra-Cabeça', 'Quebra-cabeça de 1000 peças', 29.90, 2, 5);

go

-- Inserindo Localizações de Estoque

INSERT INTO localizacao_estoque (nome, descricao) VALUES 
('A1', 'Prateleira 1 do Armazém'),
('B2', 'Prateleira 2 do Armazém'),
('C3', 'Prateleira 3 do Armazém');

go

-- Inserindo Estoque

INSERT INTO estoque (produto_id, quantidade, localizacao_id) VALUES 
(1, 50, 1),
(2, 100, 2),
(3, 200, 3),
(4, 20, 1),
(5, 150, 2),
(6, 30, 3),
(7, 80, 1),
(8, 300, 2),
(9, 10, 3),
(10, 60, 1);

go

--Inserindo Clientes

INSERT INTO cliente (nome, email, telefone, data_cadastro, cpf_cnpj, data_nascimento, genero, status) VALUES 
('João Silva', 'joao@example.com', '(11) 91234-5678', GETDATE(), '123.456.789-00', '1985-05-15', 'M', 'ATIVO'),
('Maria Oliveira', 'maria@example.com', '(21) 98765-4321', GETDATE(), '987.654.321-00', '1990-10-20', 'F', 'ATIVO'),
('Carlos Pereira', 'carlos@example.com', '(31) 99876-5432', GETDATE(), '111.222.333-44', '1980-02-28', 'M', 'ATIVO');

go

--Inserindo Pedidos
INSERT INTO pedido (data_pedido, status, cliente_id) VALUES 
(GETDATE(), 'Pendente', 1),
(GETDATE(), 'Pendente', 2),
(GETDATE(), 'Pendente', 3);
go

--Inserindo Itens de Pedido

INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES 
(1, 1, 1, 1999.99),
(2, 1, 2, 49.90),
(3, 2, 3, 15.00),
(4, 2, 1, 2999.99),
(5, 3, 1, 39.90);
go

--Inserindo Movimentações de Estoque
INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao) VALUES 
(1, 'ENTRADA', 50, GETDATE(), 'Recebimento de novos produtos'),
(2, 'SAIDA', 10, GETDATE(), 'Venda de produtos');

go

--Inserindo Requisições de Compra
INSERT INTO requisicao_compra (fornecedor_id, data_emissao, data_previsao, status, observacao) VALUES 
(1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 'A', 'Requisição de novos produtos'),
(2, GETDATE(), DATEADD(DAY, 10, GETDATE()), 'A', 'Requisição de roupas');

go

-- Inserindo Itens de Requisição

INSERT INTO item_requisicao (requisicao_id, produto_id, quantidade, preco_unitario) VALUES 
(1, 1, 10, 1999.99),
(1, 2, 20, 49.90);

go