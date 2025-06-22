DECLARE @DataLimite DATE = '2025-06-19';  -- Defina a data limite desejada

SELECT 
    p.id_produto AS ProdutoID,
    p.nome AS NomeProduto,
    p.preco AS PrecoProduto,
    COUNT(m.id_movimento) AS TotalMovimentacoes
FROM produto p
INNER JOIN movimento_estoque m ON p.id_produto = m.produto_id
WHERE m.data_movimento <= @DataLimite  -- Considera movimentações até a data desejada
GROUP BY p.id_produto, p.nome, p.preco
ORDER BY p.preco DESC;  -- Ordena pelo preço do produto (maior para menor)
