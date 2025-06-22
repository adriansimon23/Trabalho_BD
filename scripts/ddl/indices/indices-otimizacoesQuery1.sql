/*==============================================================*/
/*  ÍNDICES                                        */
/*==============================================================*/

-- Tabela: produto

-- Chaves estrangeiras são frequentemente usadas em JOINs.
-- Indexar fornecedor_id e categoria_id melhorará a performance de buscas
-- que juntam produto com fornecedor e categoria.

CREATE INDEX idx_produto_fornecedor_id ON produto(fornecedor_id);
GO
CREATE INDEX idx_produto_categoria_id ON produto(categoria_id);
GO
-- Justificativa: Para buscas rápidas de produtos pelo nome.
CREATE INDEX idx_produto_nome ON produto(nome);
GO

-- Tabela: pedido
--  Chave estrangeira para otimizar JOINs com a tabela cliente
-- e para buscar rapidamente todos os pedidos de um cliente específico.
CREATE INDEX idx_pedido_cliente_id ON pedido(cliente_id);---------
GO


--  Para acelerar a filtragem de pedidos por data.
CREATE INDEX idx_pedido_data_pedido ON pedido(data_pedido);
GO
--  Para consultas que filtram por status do pedido.
CREATE INDEX idx_pedido_status_id ON pedido(status_id);
GO

-- Tabela: item_pedido
-- Justificativa: Chaves estrangeiras para otimizar JOINs com pedido e produto.
-- Essencial para montar os detalhes de um pedido.
CREATE INDEX idx_item_pedido_pedido_id ON item_pedido(pedido_id);
GO
CREATE INDEX idx_item_pedido_produto_id ON item_pedido(produto_id);
GO

-- Tabela: movimento_estoque
-- Justificativa: Chave estrangeira e principal coluna de filtro para histórico.
CREATE INDEX idx_movimento_estoque_produto_id ON movimento_estoque(produto_id);
GO

-- Para filtrar por tipo de movimento (ENTRADA/SAIDA).
CREATE INDEX idx_movimento_estoque_tipo_movimento ON movimento_estoque(tipo_movimento);
GO



--aqui deleta o indice cliente para teste de performance 
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_pedido_cliente_id' AND object_id = OBJECT_ID('pedido'))
BEGIN
    DROP INDEX idx_pedido_cliente_id ON pedido;
    PRINT 'Índice idx_pedido_cliente_id removido.';
END
GO

-- Consulta de teste
SELECT *
FROM pedido
WHERE cliente_id = 15; --

-- Ranking por Número de Pedidos
-- Este ranking mostra os clientes mais frequentes, ou seja, aqueles que
-- compram mais vezes, independentemente do valor.
================================================================================
*/
SELECT
    cli.nome AS cliente,
    COUNT(ped.id_pedido) AS total_de_pedidos
FROM
    cliente cli
JOIN
    pedido ped ON cli.id_cliente = ped.cliente_id
GROUP BY
    cli.id_cliente, cli.nome
ORDER BY
    total_de_pedidos DESC;


	CREATE INDEX idx_pedido_cliente_id ON pedido (cliente_id);

	DROP INDEX idx_pedido_cliente_id ON pedido;

