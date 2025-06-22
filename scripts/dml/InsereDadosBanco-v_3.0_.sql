 -- Inserindo tabelas de base (15 registros cada)
    INSERT INTO categoria (nome, descricao) VALUES
    ('Celulares', 'Smartphones e acessórios'),
    ('Informática', 'Notebooks, PCs e periféricos'),
    ('Games', 'Consoles, jogos e acessórios'),
    ('Moda', 'Roupas, calçados e acessórios'),
    ('Casa e Decoração', 'Móveis, decoração e utilidades'),
    ('Eletrodomésticos', 'Geladeiras, fogões, etc.'),
    ('Livros', 'Livros de diversos gêneros'),
    ('Esportes', 'Artigos esportivos'),
    ('Beleza', 'Cosméticos e perfumaria'),
    ('Ferramentas', 'Ferramentas manuais e elétricas'),
    ('Brinquedos', 'Brinquedos para todas as idades'),
    ('Automotivo', 'Peças e acessórios para carros'),
    ('Pet Shop', 'Produtos para animais de estimação'),
    ('Alimentos', 'Mercearia e bebidas'),
    ('Saúde', 'Vitaminas e equipamentos');

    INSERT INTO localizacao_estoque (nome, descricao) VALUES
    ('Corredor A1', 'Eletrônicos de alto giro'),
    ('Corredor A2', 'Eletrônicos de baixo giro'),
    ('Corredor B1', 'Moda e vestuário'),
    ('Corredor C1', 'Casa e Decoração'),
    ('Corredor D1', 'Livros e Mídia'),
    ('Corredor E1', 'Esportes e Lazer'),
    ('Corredor F1', 'Ferramentas'),
    ('Área Volumosos 1', 'Eletrodomésticos e Móveis'),
    ('Estante G1-P1', 'Perfumaria'),
    ('Estante G2-P2', 'Brinquedos'),
    ('Estante H1-P1', 'Automotivo'),
    ('Estante H2-P2', 'Pet Shop'),
    ('Refrigerado 1', 'Alimentos perecíveis'),
    ('Quarentena', 'Produtos aguardando conferência'),
    ('Expedição', 'Produtos prontos para envio');

    -- Alguns fornecedores são mais importantes que outros.
    -- 
    INSERT INTO fornecedor (nome, cnpj, telefone, email) VALUES
    ('Distribuidora Tech Masters Ltda.', '83.435.186/0001-20', '(11) 98765-4321', 'contato@techmasters.com.br'), -- Fornecedor principal de tecnologia
    ('Global Suprimentos S.A.', '47.653.219/0001-88', '(21) 99876-5432', 'vendas@globalsuprimentos.com'), -- Fornecedor geral
    ('Editora Saber e Ler', '12.345.678/0001-99', '(31) 98888-7777', 'pedidos@sabereler.net'),
    ('Importadora Fashion BR', '98.765.432/0001-10', '(41) 97777-6666', 'comercial@fashionbr.com.br'),
    ('Casa & Conforto Utilidades', '23.456.789/0001-01', '(51) 96666-5555', 'contato@casaconforto.com'),
    ('Atleta Campeão Artigos', '87.654.321/0001-23', '(11) 95555-4444', 'vendas@atletacampeao.com.br'),
    ('Beleza Pura Cosméticos', '54.321.678/0001-45', '(81) 94444-3333', 'compras@belezapura.com'),
    ('ConstruFácil Ferramentas', '32.165.498/0001-67', '(19) 93333-2222', 'contato@construfacil.com.br'),
    ('Brinque Mais Distribuidora', '65.498.732/0001-89', '(62) 92222-1111', 'comercial@brinquemais.com'),
    ('Auto Peças Veloz', '49.873.216/0001-00', '(71) 91111-0000', 'vendas@pecasveloz.com.br'),
    ('Pet Feliz Rações', '28.652.149/0001-31', '(11) 98765-1122', 'contato@petfeliz.com'),
    ('Mercado do Sabor', '00.280.273/0001-37', '(11) 4004-0000', 'compras@sabor.com.br'),
    ('Vida Saudável Suplementos', '72.381.189/0001-10', '(51) 3345-1234', 'vendas_br@vidasaudavel.com'),
    ('Genius Games', '57.671.268/0001-09', '(11) 3345-6789', 'br.comercial@geniusgames.com'),
    ('PC Builder Peças', '33.253.333/0001-70', '(21) 3525-2000', 'comercial@pcbuilder.com.br'); -- Fornecedor importante de Hardware

    -- 
    INSERT INTO produto (nome, descricao, preco, fornecedor_id, categoria_id) VALUES
    ('Smartphone X Pro', 'O mais rápido do mercado, 256GB', 4500.90, 1, 1),      -- Produto popular do Fornecedor 1
    ('Notebook Y Gamer', 'Notebook com placa de vídeo dedicada, 16GB RAM', 7899.00, 1, 2), -- Produto popular do Fornecedor 1
    ('Teclado Mecânico RGB', 'Teclado para gamers e programadores', 350.50, 15, 2),   -- Produto popular do Fornecedor 15
    ('Placa de Vídeo ZTX', 'Placa de vídeo de alta performance', 3200.00, 15, 2), -- Fornecedor 15
    ('Cadeira de Escritório Ergo', 'Cadeira ergonômica com suporte lombar', 980.00, 2, 5),
    ('Refrigerador Duplex 450L', 'Refrigerador frost free', 3199.00, 2, 6),
    ('Smart TV 4K 55"', 'Televisor com HDR e apps integrados', 2800.00, 1, 6), -- Fornecedor 1
    ('Fone de Ouvido Bass+', 'Fone com cancelamento de ruído', 450.00, 1, 1), -- Fornecedor 1
    ('Livro: SQL para Leigos', 'Aprenda SQL do zero', 49.90, 3, 7),
    ('Console PlayBox One', 'Console de última geração', 4200.00, 14, 3),
    ('Camisa Gola Polo', 'Camisa de algodão, diversas cores', 89.90, 4, 4),
    ('Tênis de Corrida Runner', 'Tênis leve para corrida', 299.99, 6, 8),
    ('Perfume Floral Intense 50ml', 'Perfume feminino floral', 199.00, 7, 9),
    ('Furadeira de Impacto 500W', 'Furadeira para uso doméstico', 180.00, 8, 10),
    ('Boneco Super Herói', 'Boneco articulado de 30cm', 79.90, 9, 11);

    -- Inserindo o saldo inicial de estoque para cada produto.
    INSERT INTO estoque (produto_id, quantidade, localizacao_id) VALUES
    (1, 100, 1), (2, 50, 1), (3, 200, 1), (4, 40, 2), (5, 80, 8), (6, 30, 8),
    (7, 45, 8), (8, 150, 1), (9, 300, 5), (10, 60, 1), (11, 250, 3), (12, 180, 6),
    (13, 110, 9), (14, 90, 7), (15, 120, 10);

    -- Clientes com diferentes perfis de compra.
    -- 'Carlos Santana' e 'Empresa XYZ' serão os que mais compram.
    INSERT INTO cliente (nome, email, telefone, data_cadastro, cpf_cnpj, data_nascimento, genero, is_ativo) VALUES
    ('Carlos Santana', 'carlos.santana@example.com', '(11) 91234-5678', '2023-01-15', '123.456.789-01', '1985-05-20', 'M', 1), -- Cliente VIP
    ('Ana Julia Almeida', 'ana.julia@example.com', '(21) 98765-4321', '2023-02-20', '987.654.321-02', '1992-11-30', 'F', 1),
    ('Empresa XYZ Logistica', 'compras@xyzlog.com.br', '(41) 3333-4444', '2023-03-10', '01.234.567/0001-88', NULL, 'Outro', 1), -- Cliente VIP
    ('Beatriz Costa', 'beatriz.costa@example.com', '(31) 99999-8888', '2023-04-05', '111.222.333-44', '1998-07-22', 'F', 1),
    ('Lucas Martins', 'lucas.martins@example.com', '(51) 98888-7777', '2023-05-12', '444.555.666-77', '2001-01-15', 'M', 0), -- Cliente inativo
    ('Fernanda Oliveira', 'fernanda.o@example.com', '(81) 97777-6666', '2023-06-18', '777.888.999-00', '1989-03-10', 'F', 1),
    ('Ricardo Pereira', 'ricardo.p@example.com', '(71) 96666-5555', '2023-07-25', '222.333.444-55', '1976-12-01', 'M', 1),
    ('Construtora Alfa Ltda.', 'financeiro@alfa.com', '(19) 3456-7890', '2023-08-01', '88.777.666/0001-55', NULL, 'Outro', 1),
    ('Juliana Santos', 'juliana.santos@example.com', '(62) 95555-4444', '2023-09-14', '555.666.777-88', '1995-09-08', 'F', 1),
    ('Marcos Andrade', 'marcos.a@example.com', '(92) 94444-3333', '2023-10-30', '888.999.000-11', '1980-02-25', 'M', 1),
    ('Sofia Lima', 'sofia.lima@example.com', '(11) 91111-2222', '2023-11-05', '333.444.555-66', '2003-06-14', 'F', 1),
    ('Gustavo Ribeiro', 'gustavo.r@example.com', '(21) 92222-3333', '2023-12-01', '666.777.888-99', '1990-10-18', 'M', 1),
    ('Escola Aprender Mais', 'diretoria@aprendermais.edu.br', '(31) 3210-9876', '2024-01-08', '10.987.654/0001-32', NULL, 'Outro', 1),
    ('Larissa Mendes', 'larissa.mendes@example.com', '(41) 93333-4444', '2024-01-15', '999.000.111-22', '1987-04-03', 'F', 1),
    ('Felipe Azevedo', 'felipe.azevedo@example.com', '(51) 94444-5555', '2024-02-02', '121.232.343-45', '1993-08-11', 'M', 1);

    -- 
    -- Clientes 1 e 3 fazem várias compras. Produtos 1, 2 e 3 são os mais vendidos.
    -- Pedido 1 (Carlos Santana)
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-01-20 10:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (1, 1, 1, 4500.90), (8, 1, 1, 450.00);
    -- Pedido 2 (Ana Julia)
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-02-15 14:30:00', 3, 2);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (12, 2, 1, 299.99);
    -- Pedido 3 (Empresa XYZ) - Compra grande
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-03-10 09:00:00', 3, 3);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (2, 3, 5, 7899.00), (5, 3, 10, 980.00);
    -- Pedido 4 (Ricardo Pereira)
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-03-12 11:00:00', 3, 7);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 4, 2, 350.50);
    -- Pedido 5 (Carlos Santana) - Segunda compra
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);

	INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);
	INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);
	INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);
	INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);
	INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-01 18:00:00', 3, 1);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (3, 5, 1, 350.50), (9, 5, 3, 49.90);

    -- Pedido 6 (Empresa XYZ) - Segunda compra
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-05 15:00:00', 3, 3);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (1, 6, 10, 4500.90);
    -- Mais 9 pedidos aleatórios para dar volume
    INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES ('2024-04-10 10:20:00', 3, 4), ('2024-04-11 11:30:00', 3, 6), ('2024-04-12 12:40:00', 3, 8), ('2024-04-13 13:50:00', 3, 9), ('2024-04-14 14:00:00', 3, 10), ('2024-04-15 15:10:00', 3, 11), ('2024-04-16 16:20:00', 3, 12), ('2024-04-17 17:30:00', 2, 14), ('2024-04-18 18:40:00', 1, 15);
    INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES (7, 7, 1, 2800.00), (11, 8, 2, 89.90), (14, 9, 1, 180.00), (15, 10, 3, 79.90), (6, 11, 1, 3199.00), (4, 12, 1, 3200.00), (10, 13, 1, 4200.00), (1, 14, 1, 4500.90), (2, 15, 1, 7899.00);

    --  Movimentação de Estoque
    --
    INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao)
    SELECT produto_id, 'SAIDA', quantidade, ped.data_pedido, 'Venda Pedido ' + CAST(i.pedido_id AS VARCHAR)
    FROM item_pedido i
    JOIN pedido ped ON i.pedido_id = ped.id_pedido;
    -- ENTRADAS (Reposição dos itens mais vendidos)
    INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao) VALUES
    (1, 'ENTRADA', 50, '2024-01-10', 'Recebimento Fornecedor 1'),
    (2, 'ENTRADA', 30, '2024-01-10', 'Recebimento Fornecedor 1'),
    (3, 'ENTRADA', 100, '2024-01-10', 'Recebimento Fornecedor 15'),
    (1, 'ENTRADA', 50, '2024-04-01', 'Recebimento Fornecedor 1'),
    (3, 'ENTRADA', 50, '2024-04-01', 'Recebimento Fornecedor 15');

    -- CENÁRIO: Requisições de Compra para justificar as entradas
    INSERT INTO requisicao_compra (fornecedor_id, data_emissao, data_previsao, status_id, observacao) VALUES
    (1, '2024-01-02', '2024-01-10', 3, 'Reposição de início de ano'),
    (15, '2024-01-02', '2024-01-10', 3, 'Reposição de início de ano'),
    (1, '2024-03-25', '2024-04-01', 3, 'Reposição de estoque de alta demanda'),
    (15, '2024-03-25', '2024-04-01', 3, 'Reposição de teclados');
    INSERT INTO item_requisicao (requisicao_id, produto_id, quantidade, preco_unitario) VALUES
    (1, 1, 50, 3800.00), (1, 2, 30, 6500.00), (2, 3, 100, 280.00), (3, 1, 50, 3850.00), (4, 3, 50, 285.00);

 