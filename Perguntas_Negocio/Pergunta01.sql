/*
================================================================================
-- Pergunta de Negocio: 1
--
-- "Quais sao os nossos produtos de maior giro? Queremos identificar os produtos
-- cuja quantidade de movimentacoes de estoque (soma de todas as entradas e
-- saidas) esta acima da media geral. Isso nos ajudara a otimizar o layout do
-- armazem, priorizar a reposicao e entender quais itens demandam mais
-- atencao logistica."
--
================================================================================
--
-- 
--
-- A consulta principal agrupa por produto e conta quantas movimentacoes cada um
-- teve. A subconsulta na clausula HAVING calcula a media de movimentacoes por
-- produto. O resultado mostra apenas os produtos com performance logistica
-- acima da media.
--
*/
SELECT
    p.nome AS produto,
    COUNT(m.id_movimento) AS total_de_movimentacoes
FROM
    produto p
JOIN
    movimento_estoque m ON p.id_produto = m.produto_id
GROUP BY
    p.id_produto, p.nome
HAVING
    COUNT(m.id_movimento) > (
        --  Subconsulta: Calcula a media de movimentacoes por produto.
        SELECT
            AVG(CAST(total_movs AS FLOAT)) -- Usa CAST para garantir a precisao decimal na media.
        FROM (
            --  Primeiro, conta as movimentações para cada produto.
            SELECT
                COUNT(id_movimento) AS total_movs
            FROM
                movimento_estoque
            GROUP BY
                produto_id
        ) AS contagem_por_produto --
    ) -- 
ORDER BY
    total_de_movimentacoes DESC; -- 