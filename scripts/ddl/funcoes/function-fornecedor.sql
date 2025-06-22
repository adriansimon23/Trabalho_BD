/****** Object:  UserDefinedFunction [dbo].[fn_top_fornecedor_produtos]    Script Date: 22/06/2025 12:04:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_top_fornecedor_produtos]()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 
        f.id_fornecedor,
        f.nome AS nome_fornecedor,
        COUNT(p.id_produto) AS quantidade_produtos
    FROM 
        fornecedor f
    JOIN 
        produto p ON f.id_fornecedor = p.fornecedor_id
    GROUP BY 
        f.id_fornecedor, f.nome
    ORDER BY 
        quantidade_produtos DESC;
GO


