-- Dados de exemplo

-- Categorias
INSERT INTO Categoria (nome) VALUES ('Eletrônicos'), ('Roupas'), ('Livros');

-- Fornecedores
INSERT INTO Fornecedor (nome, contato, telefone) VALUES
('Tech Supplies', 'tecsup@forn.com', '(11) 2222-3333'),
('Moda Brasil', 'moda@forn.com', '(21) 9999-8888');

-- Produtos
INSERT INTO Produto (nome, descricao, preco, id_categoria, id_fornecedor) VALUES
('Fone Bluetooth', 'Fone sem fio com microfone', 199.99, 1, 1),
('Camiseta Branca', 'Camiseta básica de algodão', 39.90, 2, 2),
('Livro SQL', 'Aprenda SQL em 7 dias', 59.90, 3, 1);

-- Localização Estoque
INSERT INTO Localizacao_Estoque (nome_local, descricao) VALUES
('Depósito A', 'Área principal de armazenamento'),
('Depósito B', 'Estoque secundário');

-- Estoque
INSERT INTO Estoque (id_produto, quantidade, id_localizacao) VALUES
(1, 50, 1),
(2, 120, 1),
(3, 30, 2);

-- Pedidos
INSERT INTO Pedido (data, status, total) VALUES
('2024-06-01', 'Pendente', 239.89),
('2024-06-02', 'Concluído', 99.80);

-- Itens do Pedido
INSERT INTO Item_Pedido (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 1, 199.99),
(1, 2, 1, 39.90),
(2, 3, 1, 59.90),
(2, 2, 1, 39.90);

-- Movimentações
INSERT INTO Movimentacao_Estoque (id_produto, tipo_movimento, quantidade, data_hora, id_localizacao) VALUES
(1, 'Entrada', 50, '2024-05-25 10:00:00', 1),
(1, 'Saida', 1, '2024-06-01 11:00:00', 1),
(2, 'Entrada', 120, '2024-05-20 08:30:00', 1),
(2, 'Saida', 2, '2024-06-02 15:20:00', 1);
