-- A ordem de exclusão é inversa à da criação para respeitar as Foreign Keys.
    DELETE FROM item_requisicao;
    DELETE FROM item_pedido;
    DELETE FROM movimento_estoque;
    DELETE FROM requisicao_compra;
    DELETE FROM pedido;
    DELETE FROM estoque;
    DELETE FROM produto;
    DELETE FROM cliente;
    DELETE FROM categoria;
    DELETE FROM fornecedor;
    DELETE FROM localizacao_estoque;

    -- Reseta o valor de autoincremento (IDENTITY) de cada tabela para começar do 1.
    DBCC CHECKIDENT ('item_requisicao', RESEED, 0);
    DBCC CHECKIDENT ('item_pedido', RESEED, 0);
    DBCC CHECKIDENT ('movimento_estoque', RESEED, 0);
    DBCC CHECKIDENT ('requisicao_compra', RESEED, 0);
    DBCC CHECKIDENT ('pedido', RESEED, 0);
    DBCC CHECKIDENT ('estoque', RESEED, 0);
    DBCC CHECKIDENT ('produto', RESEED, 0);
    DBCC CHECKIDENT ('cliente', RESEED, 0);
    DBCC CHECKIDENT ('categoria', RESEED, 0);
    DBCC CHECKIDENT ('fornecedor', RESEED, 0);
    DBCC CHECKIDENT ('localizacao_estoque', RESEED, 0);
    
    