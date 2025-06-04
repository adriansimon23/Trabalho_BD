/*==============================================================*/
/* Tabela 1: categoria                                           */
/*==============================================================*/
CREATE TABLE categoria (
  id_categoria INT PRIMARY KEY IDENTITY(1, 1),
  nome VARCHAR(100),
  descricao TEXT
)
GO

/*==============================================================*/
/* Tabela 2: fornecedor                                           */
/*==============================================================*/

CREATE TABLE fornecedor (
  id_fornecedor INT PRIMARY KEY IDENTITY(1, 1),
  nome VARCHAR(150),
  cnpj VARCHAR(20),
  telefone VARCHAR(20),
  email VARCHAR(100)
)
GO

/*==============================================================*/
/* Tabela 3: produto                                         */
/*==============================================================*/


CREATE TABLE produto (
  id_produto INT PRIMARY KEY IDENTITY(1, 1),
  nome VARCHAR(150),
  descricao TEXT,
  preco DECIMAL(10, 2),
  fornecedor_id INT,
  categoria_id INT
)
GO

/*==============================================================*/
/* Tabela 4: localizar no estoque                                        */
/*==============================================================*/

CREATE TABLE localizacao_estoque (
  id_localizacao INT PRIMARY KEY IDENTITY(1, 1),
  nome VARCHAR(100),
  descricao TEXT
)
GO

/*==============================================================*/
/* Tabela 5: estoque                                           */
/*==============================================================*/

CREATE TABLE estoque (
  id_estoque INT PRIMARY KEY IDENTITY(1, 1),
  produto_id INT,
  quantidade INT,
  localizacao_id INT
)
GO


/*==============================================================*/
/* Tabela 6: cliente                                         */
/*==============================================================*/

CREATE TABLE cliente (
  id_cliente INT PRIMARY KEY IDENTITY(1, 1),
  nome VARCHAR(150),
  email VARCHAR(100) UNIQUE,
  telefone VARCHAR(20),
  data_cadastro DATETIME,
  cpf_cnpj VARCHAR(20),
  data_nascimento DATE,
  genero VARCHAR(10) CHECK (genero IN ('M', 'F', 'Outro')),
  status VARCHAR(10) CHECK (status IN ('ATIVO', 'INATIVO'))
)
GO

/*==============================================================*/
/* Tabela 7: pedido                                           */
/*==============================================================*/

CREATE TABLE pedido (
  id_pedido INT PRIMARY KEY IDENTITY(1, 1),
  data_pedido DATETIME,
  status VARCHAR(50),
  cliente_id INT
)
GO

/*==============================================================*/
/* Tabela 8: qual item pedido                                        */
/*==============================================================*/


CREATE TABLE item_pedido (
  id_item INT PRIMARY KEY IDENTITY(1, 1),
  produto_id INT,
  pedido_id INT,
  quantidade INT,
  preco_unitario DECIMAL(10, 2)
)
GO


/*==============================================================*/
/* Tabela 9: movimentação do estoque                                          */
/*==============================================================*/

CREATE TABLE movimento_estoque (
  id_movimento INT PRIMARY KEY IDENTITY(1, 1),
  produto_id INT,
  tipo_movimento VARCHAR(10) CHECK (tipo_movimento IN ('ENTRADA', 'SAIDA')),
  quantidade INT,
  data_movimento DATETIME,
  observacao TEXT
)
GO

/*==============================================================*/
/* Tabela 10: requisição da compra                                         */
/*==============================================================*/

CREATE TABLE requisicao_compra (
  id_requisicao INT PRIMARY KEY IDENTITY(1, 1),
  fornecedor_id INT,
  data_emissao DATETIME,
  data_previsao DATE,
  status VARCHAR(10) CHECK (status IN ('A', 'E', 'P', 'C')),
  observacao TEXT
)
GO


/*==============================================================*/
/* Tabela 11: o item da requisição                                         */
/*==============================================================*/

CREATE TABLE item_requisicao (
  id_item_req INT PRIMARY KEY IDENTITY(1, 1),
  requisicao_id INT,
  produto_id INT,
  quantidade INT,
  preco_unitario DECIMAL(10, 2)
)
GO



--  (descrições)
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
@value = 'Um pedido pertence a um cliente',
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
@value = 'Significado para status ABERTA;ENVIADA;PARCIAL;CONCLUIDA;CANCELADA. Ordem de compra enviada a um fornecedor',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'requisicao_compra';
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Produtos solicitados em uma requisição de compra',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'item_requisicao';
GO

-- Foreign Keys
ALTER TABLE produto ADD FOREIGN KEY (categoria_id) REFERENCES categoria(id_categoria)
GO

ALTER TABLE produto ADD FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id_fornecedor)
GO

ALTER TABLE estoque ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
GO

ALTER TABLE estoque ADD FOREIGN KEY (localizacao_id) REFERENCES localizacao_estoque(id_localizacao)
GO

ALTER TABLE pedido ADD FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente)
GO

ALTER TABLE item_pedido ADD FOREIGN KEY (pedido_id) REFERENCES pedido(id_pedido)
GO

ALTER TABLE item_pedido ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
GO

ALTER TABLE movimento_estoque ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
GO

ALTER TABLE requisicao_compra ADD FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id_fornecedor)
GO

ALTER TABLE item_requisicao ADD FOREIGN KEY (requisicao_id) REFERENCES requisicao_compra(id_requisicao)
GO

ALTER TABLE item_requisicao ADD FOREIGN KEY (produto_id) REFERENCES produto(id_produto)
GO
