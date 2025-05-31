# Dicionário de Dados

| Tabela                 | Campo             | Tipo de Dado         | Descrição                                     |
|------------------------|-------------------|-----------------------|-----------------------------------------------|
| Categoria              | id_categoria      | INT                   | Identificador da categoria (PK)               |
|                        | nome              | VARCHAR(100)          | Nome da categoria                             |
| Fornecedor             | id_fornecedor     | INT                   | Identificador do fornecedor (PK)              |
|                        | nome              | VARCHAR(150)          | Nome do fornecedor                            |
|                        | contato           | VARCHAR(100)          | Nome do contato principal                     |
|                        | telefone          | VARCHAR(20)           | Telefone do fornecedor                        |
| Produto                | id_produto        | INT                   | Identificador do produto (PK)                 |
|                        | nome              | VARCHAR(150)          | Nome do produto                               |
|                        | descricao         | TEXT                  | Descrição do produto                          |
|                        | preco             | DECIMAL(10,2)         | Preço unitário do produto                     |
|                        | id_categoria      | INT                   | FK para Categoria                             |
|                        | id_fornecedor     | INT                   | FK para Fornecedor                            |
| Pedido                 | id_pedido         | INT                   | Identificador do pedido (PK)                  |
|                        | data              | DATE                  | Data do pedido                                |
|                        | status            | VARCHAR(50)           | Status do pedido                              |
|                        | total             | DECIMAL(10,2)         | Valor total do pedido                         |
| Item_Pedido            | id_item_pedido    | INT                   | Identificador do item (PK)                    |
|                        | id_pedido         | INT                   | FK para Pedido                                |
|                        | id_produto        | INT                   | FK para Produto                               |
|                        | quantidade        | INT                   | Quantidade do produto                         |
|                        | preco_unitario    | DECIMAL(10,2)         | Preço unitário no momento da venda            |
| Localizacao_Estoque    | id_localizacao    | INT                   | Identificador da localização (PK)             |
|                        | nome_local        | VARCHAR(100)          | Nome do local                                 |
|                        | descricao         | TEXT                  | Descrição adicional                           |
| Estoque                | id_estoque        | INT                   | Identificador do estoque (PK)                 |
|                        | id_produto        | INT                   | FK para Produto                               |
|                        | quantidade        | INT                   | Quantidade em estoque                         |
|                        | id_localizacao    | INT                   | FK para Localizacao_Estoque                   |
| Movimentacao_Estoque   | id_movimentacao   | INT                   | Identificador da movimentação (PK)            |
|                        | id_produto        | INT                   | FK para Produto                               |
|                        | tipo_movimento    | VARCHAR(10)           | Tipo: Entrada ou Saída                        |
|                        | quantidade        | INT                   | Quantidade movimentada                        |
|                        | data_hora         | DATETIME              | Data e hora da movimentação                   |
|                        | id_localizacao    | INT                   | FK para Localizacao_Estoque                   |
