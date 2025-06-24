<?php
// Inclui o arquivo de conexão
require_once 'conexao.php';

// Busca os produtos para preencher o dropdown
$produtos_result = $conexao->query("SELECT id_produto, nome FROM produto ORDER BY nome");

// Busca todos os movimentos para exibir na tabela
// Usamos JOIN para mostrar o nome do produto em vez do ID
$movimentos_sql = "SELECT m.*, p.nome AS nome_produto
                   FROM movimento_estoque m
                   JOIN produto p ON m.produto_id = p.id_produto
                   ORDER BY m.data_movimento DESC";
$movimentos_result = $conexao->query($movimentos_sql);
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>CRUD - Movimento de Estoque</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <div class="container">
        <h1>Gerenciar Movimento de Estoque</h1>

        <form action="processa_movimento.php" method="post" class="form-crud">
            <input type="hidden" name="acao" id="acao" value="adicionar">
            <input type="hidden" name="id_movimento" id="id_movimento" value="">

            <div class="form-group">
                <label for="produto_id">Produto:</label>
                <select name="produto_id" id="produto_id" required>
                    <option value="">Selecione um produto</option>
                    <?php while ($produto = $produtos_result->fetch_assoc()): ?>
                        <option value="<?php echo $produto['id_produto']; ?>"><?php echo htmlspecialchars($produto['nome']); ?></option>
                    <?php endwhile; ?>
                </select>
            </div>
            <div class="form-group">
                <label for="tipo_movimento">Tipo de Movimento:</label>
                <select name="tipo_movimento" id="tipo_movimento" required>
                    <option value="ENTRADA">Entrada</option>
                    <option value="SAIDA">Saída</option>
                </select>
            </div>
            <div class="form-group">
                <label for="quantidade">Quantidade:</label>
                <input type="number" name="quantidade" id="quantidade" min="1" required>
            </div>
            <div class="form-group">
                <label for="observacao">Observação:</label>
                <input type="text" name="observacao" id="observacao" maxlength="500">
            </div>
            <div class="form-group">
                <button type="submit" id="btn-submit">Salvar Movimento</button>
                <button type="button" id="btn-cancelar" style="display:none;" onclick="cancelarEdicao()">Cancelar</button>
            </div>
        </form>

        <hr>

        <h2>Movimentos Recentes</h2>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Produto</th>
                    <th>Tipo</th>
                    <th>Qtd</th>
                    <th>Data</th>
                    <th>Obs.</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($mov = $movimentos_result->fetch_assoc()): ?>
                <tr>
                    <td><?php echo $mov['id_movimento']; ?></td>
                    <td><?php echo htmlspecialchars($mov['nome_produto']); ?></td>
                    <td><?php echo $mov['tipo_movimento']; ?></td>
                    <td><?php echo $mov['quantidade']; ?></td>
                    <td><?php echo date('d/m/Y H:i', strtotime($mov['data_movimento'])); ?></td>
                    <td><?php echo htmlspecialchars($mov['observacao']); ?></td>
                    <td>
                        <a href="javascript:void(0);" onclick="prepararEdicao(
                            '<?php echo $mov['id_movimento']; ?>',
                            '<?php echo $mov['produto_id']; ?>',
                            '<?php echo $mov['tipo_movimento']; ?>',
                            '<?php echo $mov['quantidade']; ?>',
                            '<?php echo htmlspecialchars(addslashes($mov['observacao'])); ?>'
                        )">Editar</a>
                        <a href="processa_movimento.php?acao=excluir&id=<?php echo $mov['id_movimento']; ?>" onclick="return confirm('Tem certeza que deseja excluir este movimento?');">Excluir</a>
                    </td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

    <script>
        function prepararEdicao(id, produtoId, tipo, qtd, obs) {
            // Preenche o formulário com os dados do item a ser editado
            document.getElementById('acao').value = 'editar';
            document.getElementById('id_movimento').value = id;
            document.getElementById('produto_id').value = produtoId;
            document.getElementById('tipo_movimento').value = tipo;
            document.getElementById('quantidade').value = qtd;
            document.getElementById('observacao').value = obs;

            // Muda o texto do botão e mostra o botão de cancelar
            document.getElementById('btn-submit').innerText = 'Atualizar Movimento';
            document.getElementById('btn-cancelar').style.display = 'inline-block';
            window.scrollTo(0, 0); // Rola a tela para o topo
        }

        function cancelarEdicao() {
            // Limpa o formulário e restaura o estado inicial
            document.getElementById('acao').value = 'adicionar';
            document.getElementById('id_movimento').value = '';
            document.querySelector('.form-crud').reset(); // Limpa todos os campos

            document.getElementById('btn-submit').innerText = 'Salvar Movimento';
            document.getElementById('btn-cancelar').style.display = 'none';
        }
    </script>
</body>
</html>