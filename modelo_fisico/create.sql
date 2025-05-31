-- Criação das tabelas do sistema de estoque para e-commerce
-- SGBD: SQL Server

CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(150) NOT NULL,
    contato VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE Produto (
    id_produto INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY IDENTITY(1,1),
    data DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    total DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Item_Pedido (
    id_item_pedido INT PRIMARY KEY IDENTITY(1,1),
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Localizacao_Estoque (
    id_localizacao INT PRIMARY KEY IDENTITY(1,1),
    nome_local VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE Estoque (
    id_estoque INT PRIMARY KEY IDENTITY(1,1),
    id_produto INT NOT NULL UNIQUE,
    quantidade INT NOT NULL,
    id_localizacao INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_localizacao) REFERENCES Localizacao_Estoque(id_localizacao)
);

CREATE TABLE Movimentacao_Estoque (
    id_movimentacao INT PRIMARY KEY IDENTITY(1,1),
    id_produto INT NOT NULL,
    tipo_movimento VARCHAR(10) CHECK (tipo_movimento IN ('Entrada', 'Saida')),
    quantidade INT NOT NULL,
    data_hora DATETIME NOT NULL,
    id_localizacao INT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto),
    FOREIGN KEY (id_localizacao) REFERENCES Localizacao_Estoque(id_localizacao)
);
