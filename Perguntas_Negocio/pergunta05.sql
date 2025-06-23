/*
================================================================================
-- Pergunta de Negócio:
-- "Quais clientes realizaram o maior número de pedidos?"
--
-- SQL único que mostra:
-- - Quantidade total de pedidos por cliente (Nível 1)
-- - Ordenação do maior para o menor (Nível 2)
-- - Indicação dos TOP 5 clientes (Nível 3)
================================================================================
*/

WITH pedidos_por_cliente AS (
    SELECT
        c.id_cliente,
        c.nome AS cliente,
        COUNT(p.id_pedido) AS total_de_pedidos
    FROM
        cliente c
    JOIN
        pedido p ON c.id_cliente = p.cliente_id
    GROUP BY
        c.id_cliente, c.nome
),

ranking_clientes AS (
    SELECT
        cliente,
        total_de_pedidos,
        DENSE_RANK() OVER (ORDER BY total_de_pedidos DESC) AS posicao_no_ranking
    FROM
        pedidos_por_cliente
)

SELECT
    cliente,
    total_de_pedidos,
    posicao_no_ranking,
    CASE 
        WHEN posicao_no_ranking <= 5 THEN 'TOP 5'
        ELSE 'Fora do TOP 5'
    END AS status_top_5
FROM
    ranking_clientes
ORDER BY
    total_de_pedidos DESC;
