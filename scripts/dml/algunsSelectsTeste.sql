SELECT e.quantidade, l.nome AS localizacao, p.nome AS produto
FROM estoque e
JOIN localizacao_estoque l ON e.localizacao_id = l.id_localizacao
JOIN produto p ON e.produto_id = p.id_produto;



SELECT ped.id_pedido, cli.nome AS cliente, i.quantidade, p.nome AS produto
FROM pedido ped
JOIN cliente cli ON ped.cliente_id = cli.id_cliente
JOIN item_pedido i ON ped.id_pedido = i.pedido_id
JOIN produto p ON i.produto_id = p.id_produto;



SELECT p.nome AS produto, f.nome AS fornecedor, c.nome AS categoria
FROM produto p
JOIN fornecedor f ON p.fornecedor_id = f.id_fornecedor
JOIN categoria c ON p.categoria_id = c.id_categoria;


SELECT * FROM item_requisicao;

SELECT * FROM requisicao_compra;

SELECT * FROM movimento_estoque;

SELECT * FROM item_pedido;
SELECT * FROM pedido;


SELECT * FROM cliente;

SELECT * FROM estoque;

SELECT * FROM localizacao_estoque;

SELECT * FROM produto;

SELECT * FROM fornecedor;

SELECT * FROM categoria;