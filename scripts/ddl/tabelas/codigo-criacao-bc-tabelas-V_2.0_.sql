/*==============================================================*/
/* Tabela 1: categoria                                          */
/*==============================================================*/
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(500)
);
GO

/*==============================================================*/
/* Tabela 2: fornecedor                                         */
/*==============================================================*/
CREATE TABLE fornecedor (
    id_fornecedor INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(150) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) NOT NULL UNIQUE
);
GO

/*==============================================================*/
/* Tabela 3: produto                                            */
/*==============================================================*/
CREATE TABLE produto (
    id_produto INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(MAX),
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0),
    fornecedor_id INT NOT NULL,
    categoria_id INT NOT NULL
);
GO

/*==============================================================*/
/* Tabela 4: localizacao_estoque                                */
/*==============================================================*/
CREATE TABLE localizacao_estoque (
    id_localizacao INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(500)
);
GO

/*==============================================================*/
/* Tabela 5: estoque                                            */
/*==============================================================*/
CREATE TABLE estoque (
    id_estoque INT PRIMARY KEY IDENTITY(1, 1),
    produto_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0 CHECK (quantidade >= 0),
    localizacao_id INT NOT NULL,
    CONSTRAINT UQ_produto_localizacao UNIQUE (produto_id, localizacao_id)
);
GO

/*==============================================================*/
/* Tabela 6: cliente                                            */
/*==============================================================*/
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE NOT NULL DEFAULT GETDATE(),
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    data_nascimento DATE,
    genero VARCHAR(10) CHECK (genero IN ('M', 'F', 'Outro')),
    -- OTIMIZAÇÃO: Usando BIT para status binário. É mais eficiente.
    is_ativo BIT NOT NULL DEFAULT 1 -- 1 = Ativo, 0 = Inativo
);
GO

/*==============================================================*/
/* Tabela 7: pedido                                             */
/*==============================================================*/
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY IDENTITY(1, 1),
    data_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    -- OTIMIZAÇÃO: Usando TINYINT com CHECK para múltiplos status.
    -- 0=Pendente, 1=Em Processamento, 2=Enviado, 3=Entregue, 4=Cancelado
    status_id TINYINT NOT NULL DEFAULT 0 CHECK (status_id IN (0, 1, 2, 3, 4)),
    cliente_id INT NOT NULL
);
GO

/*==============================================================*/
/* Tabela 8: item_pedido                                        */
/*==============================================================*/
CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY IDENTITY(1, 1),
    produto_id INT NOT NULL,
    pedido_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10, 2) NOT NULL CHECK (preco_unitario >= 0)
);
GO

/*==============================================================*/
/* Tabela 9: movimento_estoque                                  */
/*==============================================================*/
CREATE TABLE movimento_estoque (
    id_movimento INT PRIMARY KEY IDENTITY(1, 1),
    produto_id INT NOT NULL,
    tipo_movimento VARCHAR(10) NOT NULL CHECK (tipo_movimento IN ('ENTRADA', 'SAIDA')),
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_movimento DATETIME NOT NULL DEFAULT GETDATE(),
    observacao VARCHAR(500)
);
GO

/*==============================================================*/
/* Tabela 10: requisicao_compra                                 */
/*==============================================================*/
CREATE TABLE requisicao_compra (
    id_requisicao INT PRIMARY KEY IDENTITY(1, 1),
    fornecedor_id INT NOT NULL,
    data_emissao DATE NOT NULL DEFAULT GETDATE(),
    data_previsao DATE,
    -- OTIMIZAÇÃO: Usando TINYINT com CHECK.
    -- 0=Aberta, 1=Enviada, 2=Recebida Parcialmente, 3=Concluída
    status_id TINYINT NOT NULL DEFAULT 0 CHECK (status_id IN (0, 1, 2, 3)),
    observacao VARCHAR(500)
);
GO

/*==============================================================*/
/* Tabela 11: item_requisicao                                   */
/*==============================================================*/
CREATE TABLE item_requisicao (
    id_item_req INT PRIMARY KEY IDENTITY(1, 1),
    requisicao_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10, 2) NOT NULL CHECK (preco_unitario >= 0)
);
GO



/****************************************************************/
/* CRIAÇÃO DAS VIEWS DE LEITURA                 */
/****************************************************************/

-- VIEW para a tabela de Pedidos, traduzindo o status_id para texto
CREATE VIEW vw_pedidos_detalhados AS
SELECT
    p.id_pedido,
    p.data_pedido,
    p.cliente_id,
    c.nome AS nome_cliente,
    p.status_id,
    CASE p.status_id
        WHEN 0 THEN 'Pendente'
        WHEN 1 THEN 'Em Processamento'
        WHEN 2 THEN 'Enviado'
        WHEN 3 THEN 'Entregue'
        WHEN 4 THEN 'Cancelado'
        ELSE 'Desconhecido'
    END AS status_descricao
FROM
    pedido p
JOIN
    cliente c ON p.cliente_id = c.id_cliente;
GO

-- VIEW para a tabela de Requisição de Compra, traduzindo o status_id
CREATE VIEW vw_requisicao_compra_detalhada AS
SELECT
    rc.id_requisicao,
    rc.fornecedor_id,
    f.nome AS nome_fornecedor,
    rc.data_emissao,
    rc.status_id,
    CASE rc.status_id
        WHEN 0 THEN 'Aberta'
        WHEN 1 THEN 'Enviada'
        WHEN 2 THEN 'Recebida Parcialmente'
        WHEN 3 THEN 'Concluída'
        ELSE 'Desconhecido'
    END AS status_descricao
FROM
    requisicao_compra rc
JOIN
    fornecedor f ON rc.fornecedor_id = f.id_fornecedor;
GO

-- VIEW para a tabela de Cliente, traduzindo o is_ativo
CREATE VIEW vw_clientes_detalhados AS
SELECT
    id_cliente,
    nome,
    email,
    telefone,
    data_cadastro,
    is_ativo,
    CASE is_ativo
        WHEN 1 THEN 'Ativo'
        WHEN 0 THEN 'Inativo'
    END AS status_descricao
FROM
    cliente;
GO

--  (descrições) -
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Cada produto pertence a uma categoria e a um fornecedor',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'produto';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Indica a quantidade atual de um produto em uma localização',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'estoque';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Um pedido pertence a um cliente. O status_id significa: 0=Pendente, 1=Em Processamento, 2=Enviado, 3=Entregue, 4=Cancelado.',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'pedido';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Item do pedido contendo o produto e sua quantidade',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'item_pedido';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Registra entrada ou saída de um produto',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'movimento_estoque';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Ordem de compra enviada a um fornecedor. O status_id significa: 0=Aberta, 1=Enviada, 2=Recebida Parcialmente, 3=Concluída.',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'requisicao_compra';
GO
EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Produtos solicitados em uma requisição de compra',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'item_requisicao';
GO

--  Foreign Keys
ALTER TABLE produto ADD FOREIGN KEY (categoria_id) REFERENCES categoria(id_categoria);
ALTER TABLE produto ADD FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id_fornecedor);
ALTER TABLE estoque ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto);
ALTER TABLE estoque ADD FOREIGN KEY (localizacao_id) REFERENCES localizacao_estoque(id_localizacao);
ALTER TABLE pedido ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente);
ALTER TABLE item_pedido ADD FOREIGN KEY (pedido_id) REFERENCES pedido(id_pedido);
ALTER TABLE item_pedido ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto);
ALTER TABLE movimento_estoque ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto);
ALTER TABLE requisicao_compra ADD FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id_fornecedor);
ALTER TABLE item_requisicao ADD FOREIGN KEY (requisicao_id) REFERENCES requisicao_compra(id_requisicao);
ALTER TABLE item_requisicao ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto);
GO