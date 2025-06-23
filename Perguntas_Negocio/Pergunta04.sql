/*
  4- Classificar os produtos mais vendidos de todos os tempos e comparar com o estoque atual.
 REGRA DE NEGÓCIO: A classificação é baseada na soma total de unidades vendidas na história.
 USO DE FUNÇÃO DE JANELA: A função RANK() é usada para criar o ranking dos "best-sellers".
 */
WITH EstoqueAtual AS (
    --  Calcula o estoque total atual para cada produto 
    SELECT
        produto_id,
        SUM(quantidade) AS quantidade_total_em_estoque
    FROM
        estoque
    GROUP BY
        produto_id
),
VendasHistoricas AS (
    --Calcula o total de vendas de cada produto em todo o histórico sem filtro de data
    SELECT
        produto_id,
        SUM(quantidade) AS total_vendido_historico
    FROM
        item_pedido
    GROUP BY
        produto_id
)
--Consulta principal que une os dados e cria o ranking.
SELECT
    p.id_produto,
    p.nome AS nome_produto,
    ISNULL(vh.total_vendido_historico, 0) AS total_vendido,
    ISNULL(ea.quantidade_total_em_estoque, 0) AS estoque_atual,

    
    -- USO DA FUNÇÃO DE JANELA 
    -- Classifica os produtos com base no total de vendas.
    -- O produto que mais vendeu na história receberá o ranking 1.
   
    RANK() OVER (ORDER BY ISNULL(vh.total_vendido_historico, 0) DESC) AS ranking_best_seller
FROM
    produto p
LEFT JOIN
    EstoqueAtual ea ON p.id_produto = ea.produto_id
LEFT JOIN
    VendasHistoricas vh ON p.id_produto = vh.produto_id
ORDER BY
    ranking_best_seller ASC; 