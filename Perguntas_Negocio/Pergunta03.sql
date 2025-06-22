SELECT 
    p.nome AS NomeProduto,
    c.nome AS Categoria,
    me.tipo_movimento,
    me.quantidade,
    me.data_movimento,
    p.preco AS PrecoProduto
FROM movimento_estoque me
INNER JOIN produto p ON me.produto_id = p.id_produto
INNER JOIN categoria c ON p.categoria_id = c.id_categoria
WHERE 
    -- 1º Nível de Filtro: Tipo de movimentação
    me.tipo_movimento = 'SAIDA'

    -- 2º Nível de Filtro: Categoria do produto
    AND c.nome = 'Eletrônicos'

    -- 3º Nível de Filtro: Preço mínimo do produto
    AND p.preco > 1000.00
ORDER BY me.data_movimento DESC;
