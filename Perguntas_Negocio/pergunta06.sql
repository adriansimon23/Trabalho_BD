

-- 6 Quais produtos tiveram divergência entre o preço atual e o último valor comprado do fornecedor?

SELECT 
    p.nome AS NomeProduto,
    MAX(ir.preco_unitario) AS PrecoAnterior,
    p.preco AS PrecoAtual,
    MAX(rc.data_emissao) AS UltimaRequisicao
FROM item_requisicao ir
JOIN produto p ON ir.produto_id = p.id_produto
JOIN requisicao_compra rc ON ir.requisicao_id = rc.id_requisicao
GROUP BY p.nome, p.preco
HAVING MAX(ir.preco_unitario) <> p.preco
ORDER BY UltimaRequisicao DESC;


-- Atualiza o preço de 5 produtos aleatórios com variação entre -20% e +20%
UPDATE p
SET preco = ROUND(
    p.preco * (1 + (CAST((ABS(CHECKSUM(NEWID())) % 41) - 20 AS FLOAT) / 100.0)), 
    2
)
FROM (
    SELECT TOP 5 id_produto
    FROM produto
    ORDER BY NEWID()
) AS aleatorio
JOIN produto p ON p.id_produto = aleatorio.id_produto;
