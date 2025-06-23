/*
================================================================================


Quem foram os 5 maiores clientes por volume de compras em cada mês e qual foi a variação percentual 
do valor das suas compras em relação ao mês anterior

-- SQL único que mostra:
-- Quantidade total de vendas por cliente e mês (Nível 1)
-- Cálculo da variação percentual e valor do mês anterior (Nível 2)
-- Ordenação e indicação dos TOP 5 clientes mensais com variação (Nível 3)
================================================================================
================================================================================
*/



IF OBJECT_ID('dbo.sp_analise_top_clientes_mensal', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_analise_top_clientes_mensal;
GO

CREATE PROCEDURE dbo.sp_analise_top_clientes_mensal
    @p_data_referencia DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    -- Se data não for informada, usa a data atual
    IF @p_data_referencia IS NULL
        SET @p_data_referencia = GETDATE();

    -- Define intervalo de análise: últimos 6 meses até o mês anterior
    DECLARE @inicio_mes_atual DATE = DATEADD(MONTH, DATEDIFF(MONTH, 0, @p_data_referencia), 0);
    DECLARE @inicio_periodo_analise DATE = DATEADD(MONTH, -6, @inicio_mes_atual);

    -- Tabela temporária para armazenar os pedidos com valor total por pedido
    CREATE TABLE #PedidosValor (
        id_pedido INT,
        data_pedido DATE,
        cliente_id INT,
        valor_total DECIMAL(18,2)
    );

    INSERT INTO #PedidosValor (id_pedido, data_pedido, cliente_id, valor_total)
    SELECT
        p.id_pedido,
        p.data_pedido,
        p.cliente_id,
        SUM(ip.quantidade * ip.preco_unitario)
    FROM pedido p
    JOIN item_pedido ip ON p.id_pedido = ip.pedido_id
    WHERE p.data_pedido >= @inicio_periodo_analise
      AND p.data_pedido < @inicio_mes_atual
    GROUP BY p.id_pedido, p.data_pedido, p.cliente_id;

    -- Tabela temporária para agregar vendas por cliente e mês
    CREATE TABLE #VendasMensais (
        id_cliente INT,
        nome_cliente VARCHAR(150),
        ano_mes CHAR(7),  -- formato 'yyyy-MM'
        valor_total_vendas DECIMAL(18,2)
    );

    INSERT INTO #VendasMensais (id_cliente, nome_cliente, ano_mes, valor_total_vendas)
    SELECT
        c.id_cliente,
        c.nome,
        CONVERT(CHAR(7), pv.data_pedido, 120) AS ano_mes,
        SUM(pv.valor_total)
    FROM #PedidosValor pv
    JOIN cliente c ON pv.cliente_id = c.id_cliente
    GROUP BY c.id_cliente, c.nome, CONVERT(CHAR(7), pv.data_pedido, 120);

    -- Variável para armazenar resultados finais
    CREATE TABLE #RankingFinal (
        ano_mes CHAR(7),
        nome_cliente VARCHAR(150),
        valor_total_vendas DECIMAL(18,2),
        vendas_mes_anterior DECIMAL(18,2),
        variacao_percentual DECIMAL(5,2),
        rank_mensal INT
    );

    -- Cursor para calcular variação e ranking por mês e cliente
    DECLARE @ano_mes CHAR(7), @id_cliente INT, @nome_cliente VARCHAR(150),
            @valor_total DECIMAL(18,2), @vendas_mes_anterior DECIMAL(18,2),
            @variacao DECIMAL(5,2), @rank INT;

    -- Para facilitar a consulta da venda do mês anterior
    -- Podemos usar uma consulta simples com JOIN para pegar o mês anterior

    INSERT INTO #RankingFinal (ano_mes, nome_cliente, valor_total_vendas, vendas_mes_anterior, variacao_percentual, rank_mensal)
    SELECT
        v1.ano_mes,
        v1.nome_cliente,
        v1.valor_total_vendas,
        ISNULL(v2.valor_total_vendas, 0) AS vendas_mes_anterior,
        CASE
            WHEN ISNULL(v2.valor_total_vendas, 0) > 0 THEN
                ROUND(((v1.valor_total_vendas - v2.valor_total_vendas) * 100.0) / v2.valor_total_vendas, 2)
            WHEN v1.valor_total_vendas > 0 THEN
                100.00
            ELSE
                NULL
        END AS variacao_percentual,
        NULL  -- rank será calculado abaixo
    FROM #VendasMensais v1
    LEFT JOIN #VendasMensais v2 ON v2.id_cliente = v1.id_cliente
        AND v2.ano_mes = FORMAT(DATEADD(MONTH, -1, CAST(v1.ano_mes + '-01' AS DATE)), 'yyyy-MM');

    -- Atualizar ranking mensal (rank_mensal) usando variável e loop simples

    -- Criar índice para facilitar ordenação
    CREATE INDEX idx_ano_mes ON #RankingFinal(ano_mes);

    DECLARE @current_ano_mes CHAR(7);
    DECLARE ranking_cursor CURSOR FOR
        SELECT DISTINCT ano_mes FROM #RankingFinal ORDER BY ano_mes;

    OPEN ranking_cursor;
    FETCH NEXT FROM ranking_cursor INTO @current_ano_mes;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @rank_count INT = 0;

        -- Atualiza o ranking para o mês corrente
        UPDATE #RankingFinal
        SET rank_mensal = ranked.rank
        FROM (
            SELECT
                nome_cliente,
                ROW_NUMBER() OVER (ORDER BY valor_total_vendas DESC) AS rank
            FROM #RankingFinal
            WHERE ano_mes = @current_ano_mes
        ) AS ranked
        WHERE #RankingFinal.ano_mes = @current_ano_mes
          AND #RankingFinal.nome_cliente = ranked.nome_cliente;

        FETCH NEXT FROM ranking_cursor INTO @current_ano_mes;
    END
    CLOSE ranking_cursor;
    DEALLOCATE ranking_cursor;

    -- Mostrar os TOP 5 clientes com variação por mês (pivot simplificado)
    SELECT
        ano_mes,
        MAX(CASE WHEN rank_mensal = 1 THEN nome_cliente END) AS Top1,
        MAX(CASE WHEN rank_mensal = 1 THEN CAST(variacao_percentual AS VARCHAR(10)) + '%' END) AS Var1,
        MAX(CASE WHEN rank_mensal = 2 THEN nome_cliente END) AS Top2,
        MAX(CASE WHEN rank_mensal = 2 THEN CAST(variacao_percentual AS VARCHAR(10)) + '%' END) AS Var2,
        MAX(CASE WHEN rank_mensal = 3 THEN nome_cliente END) AS Top3,
        MAX(CASE WHEN rank_mensal = 3 THEN CAST(variacao_percentual AS VARCHAR(10)) + '%' END) AS Var3,
        MAX(CASE WHEN rank_mensal = 4 THEN nome_cliente END) AS Top4,
        MAX(CASE WHEN rank_mensal = 4 THEN CAST(variacao_percentual AS VARCHAR(10)) + '%' END) AS Var4,
        MAX(CASE WHEN rank_mensal = 5 THEN nome_cliente END) AS Top5,
        MAX(CASE WHEN rank_mensal = 5 THEN CAST(variacao_percentual AS VARCHAR(10)) + '%' END) AS Var5
    FROM #RankingFinal
    WHERE rank_mensal <= 5
    GROUP BY ano_mes
    ORDER BY ano_mes;

    -- Limpeza
    DROP TABLE #PedidosValor;
    DROP TABLE #VendasMensais;
    DROP TABLE #RankingFinal;
END;
GO

EXEC dbo.sp_analise_top_clientes_mensal '2024-05-01';


-- nota: professor estava em viagem a trabalho em são paulo seguei na sexta 20:00, e sabádo amanheci com uma febre forte que
-- continou até o dia de hoje(23/06) ao meio quando consegui mecher no trabalho novamente, peguei uma pergunta do meu colega 
--wesley e atualizei para ficar com minha autoria.