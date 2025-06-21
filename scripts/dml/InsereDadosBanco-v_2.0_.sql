-- Desativar a verificação de chave estrangeira temporariamente para facilitar a inserção em lote.
-- Nota: Para SQL Server, o controle de constraints é feito de outra forma,
-- mas a ordem de inserção abaixo foi projetada para não causar problemas.

-- Inserindo dados na tabela: categoria
INSERT INTO categoria (nome, descricao) VALUES
('Eletrônicos', 'Dispositivos e acessórios eletrônicos.'),
('Livros', 'Livros impressos e digitais.'),
('Roupas', 'Vestuário masculino, feminino e infantil.'),
('Casa e Cozinha', 'Utensílios e decoração para o lar.'),
('Esportes e Lazer', 'Artigos para práticas esportivas e atividades ao ar livre.'),
('Brinquedos e Jogos', 'Brinquedos para todas as idades e jogos de tabuleiro.'),
('Saúde e Cuidados Pessoais', 'Produtos de higiene e cuidados com a saúde.'),
('Automotivo', 'Peças e acessórios para veículos.'),
('Pet Shop', 'Produtos para animais de estimação.'),
('Material de Escritório', 'Suprimentos para escritório e papelaria.'),
('Jardim e Piscina', 'Ferramentas e produtos para jardinagem e manutenção de piscinas.'),
('Beleza e Perfumaria', 'Cosméticos e fragrâncias.'),
('Alimentos e Bebidas', 'Produtos alimentícios e bebidas em geral.'),
('Filmes e Séries', 'DVDs e Blu-rays de filmes e séries de TV.'),
('Música', 'CDs, vinis e instrumentos musicais.');
GO

-- Inserindo dados na tabela: fornecedor
INSERT INTO fornecedor (nome, cnpj, telefone, email) VALUES
('TechDistribuidora S.A.', '11.222.333/0001-44', '(11) 98765-4321', 'contato@techdistribuidora.com'),
('Livraria Saber Ltda.', '22.333.444/0001-55', '(21) 91234-5678', 'vendas@livrariasaber.com.br'),
('Moda & Estilo Confecções', '33.444.555/0001-66', '(31) 95678-1234', 'comercial@modaeestilo.com'),
('Casa & Conforto Utilidades', '44.555.666/0001-77', '(41) 94321-8765', 'suporte@casaconforto.net'),
('Atleta Campeão Artigos Esportivos', '55.666.777/0001-88', '(51) 98765-1234', 'loja@atletacampeao.com'),
('Brinque Mais Comércio de Brinquedos', '66.777.888/0001-99', '(61) 91234-8765', 'faleconosco@brinquemais.com'),
('Vida Saudável Produtos Naturais', '77.888.999/0001-00', '(71) 95678-4321', 'sac@vidasaudavel.com.br'),
('Auto Peças Veloz', '88.999.000/0001-11', '(81) 94321-5678', 'pecas@autoveloz.com'),
('Mundo Pet Distribuidora', '99.000.111/0001-22', '(91) 98765-8765', 'atendimento@mundopet.com'),
('Papelaria Central', '10.111.222/0001-33', '(12) 91234-1234', 'pedidos@papelariacentral.com'),
('Jardim Florido Paisagismo', '12.222.333/0001-44', '(22) 95678-5678', 'contato@jardimflorido.com.br'),
('Essência Rara Perfumaria', '13.333.444/0001-55', '(32) 94321-1234', 'compras@essenciarara.com'),
('Empório Sabor do Campo', '14.444.555/0001-66', '(42) 98765-5678', 'vendas@emporiosabor.com'),
('Cine Arte Distribuidora', '15.555.666/0001-77', '(52) 91234-4321', 'filmes@cinearte.com'),
('Harmonia Musical', '16.666.777/0001-88', '(62) 95678-8765', 'loja@harmoniamusical.com');
GO

-- Inserindo dados na tabela: localizacao_estoque
INSERT INTO localizacao_estoque (nome, descricao) VALUES
('Corredor A1', 'Prateleiras 1-5, produtos de alta rotatividade.'),
('Corredor A2', 'Prateleiras 6-10, produtos de média rotatividade.'),
('Corredor B1', 'Seção de eletrônicos e frágeis.'),
('Corredor B2', 'Seção de vestuário e têxteis.'),
('Corredor C1', 'Produtos de grande porte e caixas master.'),
('Corredor C2', 'Área de expedição, produtos prontos para envio.'),
('Setor D1', 'Armazenamento de alimentos e perecíveis.'),
('Setor D2', 'Produtos controlados e de alto valor.'),
('Pátio Externo', 'Itens de jardinagem e de grande volume.'),
('Mezanino', 'Estoque de baixo giro e itens promocionais.'),
('Câmara Fria 1', 'Produtos que necessitam de refrigeração.'),
('Câmara Fria 2', 'Congelados e produtos de baixa temperatura.'),
('Estante E1', 'Livros e material de escritório.'),
('Estante E2', 'Brinquedos e jogos.'),
('Balcão de Retirada', 'Produtos aguardando retirada pelo cliente.');
GO

-- Inserindo dados na tabela: produto
INSERT INTO produto (nome, descricao, preco, fornecedor_id, categoria_id) VALUES
('Smartphone Xpto 256GB', 'Última geração com câmera tripla', 3999.90, 1, 1),
('Notebook Gamer Fire 16GB RAM', 'Placa de vídeo dedicada e SSD 512GB', 7500.00, 1, 1),
('O Senhor dos Anéis - Trilogia', 'Box com os três livros da saga', 129.90, 2, 2),
('Camiseta Básica Algodão Pima', 'Conforto e durabilidade para o dia a dia', 89.90, 3, 3),
('Panela de Pressão Elétrica 6L', 'Cozinhe com segurança e praticidade', 349.90, 4, 4),
('Bicicleta Aro 29 Alumínio 21V', 'Ideal para trilhas leves e passeios urbanos', 1200.00, 5, 5),
('LEGO City - Delegacia de Polícia', 'Kit com 743 peças para montar', 499.90, 6, 6),
('Protetor Solar FPS 50 200ml', 'Alta proteção contra raios UVA/UVB', 55.00, 7, 7),
('Óleo de Motor 5W30 Sintético', 'Lubrificante para motores a gasolina e etanol', 45.90, 8, 8),
('Ração Premium para Cães Adultos 15kg', 'Sabor carne e vegetais, com vitaminas', 189.90, 9, 9),
('Resma de Papel A4 500 folhas', 'Papel alcalino de alta qualidade', 28.50, 10, 10),
('Kit Jardinagem 3 Peças Tramontina', 'Pá, ancinho e garfo para jardim', 39.90, 11, 11),
('Perfume Francês Eau de Parfum 50ml', 'Fragrância floral amadeirada', 299.00, 12, 12),
('Azeite de Oliva Extra Virgem 500ml', 'Produzido em Portugal, acidez máxima 0,2%', 35.00, 13, 13),
('Blu-ray Vingadores: Ultimato', 'Edição de colecionador com 2 discos', 69.90, 14, 14);
GO

-- Inserindo dados na tabela: cliente
INSERT INTO cliente (nome, email, telefone, data_cadastro, cpf_cnpj, data_nascimento, genero, is_ativo) VALUES
('Carlos Silva', 'carlos.silva@example.com', '(11) 99999-8888', '2023-01-15', '111.222.333-44', '1985-05-20', 'M', 1),
('Ana Paula Souza', 'ana.souza@example.com', '(21) 98888-7777', '2023-02-20', '222.333.444-55', '1990-08-12', 'F', 1),
('João Pereira', 'joao.pereira@example.com', '(31) 97777-6666', '2023-03-10', '333.444.555-66', '1982-11-30', 'M', 1),
('Maria Oliveira', 'maria.oliveira@example.com', '(41) 96666-5555', '2023-04-05', '444.555.666-77', '1995-02-25', 'F', 1),
('Restaurante Sabor Divino Ltda', 'compras@sabordivino.com', '(51) 95555-4444', '2023-05-12', '12.345.678/0001-99', NULL, 'Outro', 1),
('Pedro Costa', 'pedro.costa@example.com', '(61) 94444-3333', '2023-06-18', '555.666.777-88', '1998-07-14', 'M', 1),
('Juliana Santos', 'juliana.santos@example.com', '(71) 93333-2222', '2023-07-22', '666.777.888-99', '1989-01-07', 'F', 1),
('Lucas Martins', 'lucas.martins@example.com', '(81) 92222-1111', '2023-08-30', '777.888.999-00', '2000-03-19', 'M', 0),
('Fernanda Lima', 'fernanda.lima@example.com', '(91) 91111-0000', '2023-09-14', '888.999.000-11', '1993-09-09', 'F', 1),
('Escritório de Advocacia & Associados', 'adm@advassociados.com', '(12) 90000-9999', '2023-10-25', '23.456.789/0001-00', NULL, 'Outro', 1),
('Ricardo Almeida', 'ricardo.almeida@example.com', '(22) 98989-8989', '2023-11-01', '999.000.111-22', '1979-04-28', 'M', 1),
('Camila Ribeiro', 'camila.ribeiro@example.com', '(32) 97878-7878', '2023-12-09', '000.111.222-33', '1991-06-15', 'F', 1),
('Gabriel Ferreira', 'gabriel.ferreira@example.com', '(42) 96767-6767', '2024-01-19', '111.222.333-54', '1988-12-01', 'M', 1),
('Amanda Barros', 'amanda.barros@example.com', '(52) 95656-5656', '2024-02-28', '222.333.444-65', '1999-10-23', 'F', 1),
('Bruno Gomes', 'bruno.gomes@example.com', '(62) 94545-4545', '2024-03-17', '333.444.555-76', '1980-02-11', 'M', 1);
GO

-- Inserindo dados na tabela: estoque
-- Populando o estoque inicial para cada produto
INSERT INTO estoque (produto_id, quantidade, localizacao_id) VALUES
(1, 50, 3),   -- Smartphone Xpto 256GB no Corredor B1
(2, 30, 3),   -- Notebook Gamer Fire 16GB RAM no Corredor B1
(3, 100, 13), -- O Senhor dos Anéis - Trilogia na Estante E1
(4, 200, 4),  -- Camiseta Básica Algodão Pima no Corredor B2
(5, 40, 2),   -- Panela de Pressão Elétrica 6L no Corredor A2
(6, 25, 5),   -- Bicicleta Aro 29 Alumínio 21V no Corredor C1
(7, 60, 14),  -- LEGO City - Delegacia de Polícia na Estante E2
(8, 300, 2),  -- Protetor Solar FPS 50 200ml no Corredor A2
(9, 500, 1),  -- Óleo de Motor 5W30 Sintético no Corredor A1
(10, 80, 7),  -- Ração Premium para Cães Adultos 15kg no Setor D1
(11, 1000, 13),-- Resma de Papel A4 500 folhas na Estante E1
(12, 150, 9), -- Kit Jardinagem 3 Peças Tramontina no Pátio Externo
(13, 70, 8),  -- Perfume Francês Eau de Parfum 50ml no Setor D2
(14, 250, 7), -- Azeite de Oliva Extra Virgem 500ml no Setor D1
(15, 120, 1); -- Blu-ray Vingadores: Ultimato no Corredor A1
GO

-- Inserindo dados na tabela: pedido
INSERT INTO pedido (data_pedido, status_id, cliente_id) VALUES
('2024-03-20 10:30:00', 3, 1), -- Entregue
('2024-03-22 14:00:00', 3, 2), -- Entregue
('2024-04-01 09:15:00', 3, 3), -- Entregue
('2024-04-05 11:00:00', 3, 4), -- Entregue
('2024-04-10 16:45:00', 2, 5), -- Enviado
('2024-04-12 18:20:00', 1, 6), -- Em Processamento
('2024-04-15 08:00:00', 0, 7), -- Pendente
('2024-04-18 13:10:00', 0, 9), -- Pendente
('2024-04-20 20:00:00', 4, 1), -- Cancelado
('2024-05-01 12:00:00', 3, 10),-- Entregue
('2024-05-03 15:30:00', 3, 11),-- Entregue
('2024-05-05 17:00:00', 2, 12),-- Enviado
('2024-05-08 10:00:00', 1, 13),-- Em Processamento
('2024-05-10 11:45:00', 0, 14),-- Pendente
('2024-05-11 09:30:00', 0, 15);-- Pendente
GO

-- Inserindo dados na tabela: item_pedido
INSERT INTO item_pedido (produto_id, pedido_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 3999.90), -- Pedido 1
(3, 2, 2, 129.90), -- Pedido 2
(4, 2, 3, 89.90),  -- Pedido 2
(5, 3, 1, 349.90), -- Pedido 3
(11, 3, 10, 28.50),-- Pedido 3
(14, 4, 5, 35.00), -- Pedido 4
(10, 5, 3, 189.90),-- Pedido 5
(6, 6, 1, 1200.00),-- Pedido 6
(7, 7, 1, 499.90), -- Pedido 7
(8, 8, 4, 55.00),  -- Pedido 8
(2, 9, 1, 7500.00),-- Pedido 9
(11, 10, 50, 28.50),-- Pedido 10
(12, 11, 2, 39.90),-- Pedido 11
(13, 12, 1, 299.00),-- Pedido 12
(9, 13, 2, 45.90), -- Pedido 13
(4, 14, 5, 89.90), -- Pedido 14
(15, 15, 3, 69.90);-- Pedido 15
GO

-- Inserindo dados na tabela: movimento_estoque
-- Movimentos de SAIDA baseados nos pedidos (simulação)
INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao) VALUES
(1, 'SAIDA', 1, '2024-03-21 09:00:00', 'Venda Pedido 1'),
(3, 'SAIDA', 2, '2024-03-23 10:00:00', 'Venda Pedido 2'),
(4, 'SAIDA', 3, '2024-03-23 10:01:00', 'Venda Pedido 2'),
(5, 'SAIDA', 1, '2024-04-02 11:00:00', 'Venda Pedido 3'),
(11, 'SAIDA', 10, '2024-04-02 11:01:00', 'Venda Pedido 3'),
(14, 'SAIDA', 5, '2024-04-06 14:00:00', 'Venda Pedido 4'),
(10, 'SAIDA', 3, '2024-04-11 08:30:00', 'Venda Pedido 5'),
-- Movimentos de ENTRADA (novas compras ou ajustes)
(1, 'ENTRADA', 20, '2024-04-15 10:00:00', 'Recebimento NF 1122'),
(2, 'ENTRADA', 10, '2024-04-15 10:05:00', 'Recebimento NF 1122'),
(3, 'ENTRADA', 50, '2024-04-16 11:30:00', 'Recebimento NF 3344'),
(4, 'ENTRADA', 100, '2024-04-17 14:00:00', 'Recebimento NF 5566'),
(9, 'ENTRADA', 200, '2024-04-18 16:00:00', 'Ajuste de inventário positivo'),
(11, 'ENTRADA', 500, '2024-04-19 09:45:00', 'Recebimento NF 7788'),
(14, 'ENTRADA', 120, '2024-04-20 13:00:00', 'Recebimento NF 9900'),
(6, 'ENTRADA', 10, '2024-04-22 15:20:00', 'Recebimento NF 1212');
GO

-- Inserindo dados na tabela: requisicao_compra
INSERT INTO requisicao_compra (fornecedor_id, data_emissao, data_previsao, status_id, observacao) VALUES
(1, '2024-03-01', '2024-03-15', 3, 'Compra de eletrônicos para reposição de estoque.'),
(2, '2024-03-05', '2024-03-20', 3, 'Pedido de livros best-sellers.'),
(3, '2024-03-10', '2024-03-25', 3, 'Coleção de inverno de camisetas.'),
(4, '2024-03-15', '2024-04-01', 2, 'Utensílios para cozinha. Recebido parcial.'),
(5, '2024-03-20', '2024-04-10', 3, 'Compra de bicicletas para a alta temporada.'),
(6, '2024-04-01', '2024-04-15', 3, 'Lançamentos de brinquedos.'),
(7, '2024-04-05', '2024-04-20', 1, 'Reposição de protetores solares.'),
(8, '2024-04-10', '2024-04-25', 1, 'Pedido mensal de lubrificantes.'),
(9, '2024-04-15', '2024-04-30', 0, 'Compra de ração em grande volume.'),
(10, '2024-04-20', '2024-05-05', 0, 'Material de escritório para o próximo semestre.'),
(11, '2024-04-25', '2024-05-10', 0, 'Ferramentas de jardinagem para a primavera.'),
(12, '2024-05-01', '2024-05-15', 3, 'Importação de perfumes.'),
(13, '2024-05-03', '2024-05-18', 2, 'Azeites e conservas. Aguardando restante.'),
(14, '2024-05-05', '2024-05-20', 1, 'Pedido de filmes clássicos e lançamentos.'),
(15, '2024-05-10', '2024-05-25', 0, 'Compra de violões e acessórios.');
GO

-- Inserindo dados na tabela: item_requisicao
INSERT INTO item_requisicao (requisicao_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 10, 3500.00),
(1, 2, 5, 6800.00),
(2, 3, 50, 90.00),
(3, 4, 200, 60.00),
(4, 5, 30, 280.00),
(5, 6, 20, 950.00),
(6, 7, 40, 400.00),
(7, 8, 150, 40.00),
(8, 9, 300, 35.00),
(9, 10, 100, 150.00),
(10, 11, 800, 22.00),
(11, 12, 100, 25.00),
(12, 13, 50, 220.00),
(13, 14, 200, 25.00),
(14, 15, 80, 50.00),
(15, 3, 30, 95.00); -- Compra adicional do mesmo produto em outra requisição
GO