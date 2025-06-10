<?php
include '../config/database.php';
include '../includes/header.php';

$message = '';
$message_type = '';
$movimento = null;

if (isset($_GET['id'])) {
    $id_movimento = $_GET['id'];

    // Buscar dados do movimento
    $sql_movimento = "SELECT * FROM movimento_estoque WHERE id_movimento = ?";
    $params_movimento = array($id_movimento);
    $stmt_movimento = sqlsrv_query($conn, $sql_movimento, $params_movimento);

    if ($stmt_movimento === false) {
        die(print_r(sqlsrv_errors(), true));
    }

    $movimento = sqlsrv_fetch_array($stmt_movimento, SQLSRV_FETCH_ASSOC);

    if ($movimento === null) {
        $message = "Movimento não encontrado.";
        $message_type = 'error';
    }
} else {
    $message = "ID do movimento não especificado.";
    $message_type = 'error';
}

// Buscar produtos para o dropdown
$sql_produtos = "SELECT id_produto, nome FROM produto ORDER BY nome";
$stmt_produtos = sqlsrv_query($conn, $sql_produtos);
if ($stmt_produtos === false) {
    die(print_r(sqlsrv_errors(), true));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $movimento !== null) {
    $id_movimento = $_POST['id_movimento'];
    $produto_id = $_POST['produto_id'];
    $tipo_movimento = $_POST['tipo_movimento'];
    $quantidade = $_POST['quantidade'];
    $data_movimento_str = $_POST['data_movimento'];
    $observacao = $_POST['observacao'];

    // Converte a string de data/hora para o formato adequado para SQL Server
    $data_movimento = new DateTime($data_movimento_str);

    $sql = "UPDATE movimento_estoque SET produto_id = ?, tipo_movimento = ?, quantidade = ?, data_movimento = ?, observacao = ? WHERE id_movimento = ?";
    $params = array($produto_id, $tipo_movimento, $quantidade, $data_movimento->format('Y-m-d H:i:s'), $observacao, $id_movimento);
    $stmt = sqlsrv_query($conn, $sql, $params);

    if ($stmt === false) {
        $message = "Erro ao atualizar movimento: " . print_r(sqlsrv_errors(), true);
        $message_type = 'error';
    } else {
        $message = "Movimento atualizado com sucesso!";
        $message_type = 'success';
        // Atualizar o objeto $movimento com os novos dados
        $movimento['produto_id'] = $produto_id;
        $movimento['tipo_movimento'] = $tipo_movimento;
        $movimento['quantidade'] = $quantidade;
        $movimento['data_movimento'] = $data_movimento; // Armazenar como DateTime para exibição
        $movimento['observacao'] = $observacao;
        // Redireciona para a página de listagem após 2 segundos
        header("refresh:2;url=index.php?message=" . urlencode($message));
    }
}
?>

<h2>Editar Movimento de Estoque</h2>

<?php if ($message): ?>
    <div class="message <?php echo $message_type; ?>">
        <?php echo htmlspecialchars($message); ?>
    </div>
<?php endif; ?>

<?php if ($movimento): ?>
    <form action="update.php" method="POST">
        <input type="hidden" name="id_movimento" value="<?php echo htmlspecialchars($movimento['id_movimento']); ?>">
        <div>
            <label for="produto_id">Produto:</label>
            <select id="produto_id" name="produto_id" required>
                <option value="">Selecione um produto</option>
                <?php
                while ($row_produto = sqlsrv_fetch_array($stmt_produtos, SQLSRV_FETCH_ASSOC)) {
                    $selected = ($row_produto['id_produto'] == $movimento['produto_id']) ? 'selected' : '';
                    echo "<option value='" . htmlspecialchars($row_produto['id_produto']) . "' " . $selected . ">" . htmlspecialchars($row_produto['nome']) . "</option>";
                }
                sqlsrv_free_stmt($stmt_produtos);
                ?>
            </select>
        </div>
        <div>
            <label for="tipo_movimento">Tipo de Movimento:</label>
            <select id="tipo_movimento" name="tipo_movimento" required>
                <option value="">Selecione o tipo</option>
                <option value="ENTRADA" <?php echo ($movimento['tipo_movimento'] == 'ENTRADA') ? 'selected' : ''; ?>>ENTRADA</option>
                <option value="SAIDA" <?php echo ($movimento['tipo_movimento'] == 'SAIDA') ? 'selected' : ''; ?>>SAIDA</option>
            </select>
        </div>
        <div>
            <label for="quantidade">Quantidade:</label>
            <input type="number" id="quantidade" name="quantidade" min="1" value="<?php echo htmlspecialchars($movimento['quantidade']); ?>" required>
        </div>
        <div>
            <label for="data_movimento">Data do Movimento:</label>
            <input type="datetime-local" id="data_movimento" name="data_movimento" value="<?php echo htmlspecialchars($movimento['data_movimento']->format('Y-m-d\TH:i')); ?>" required>
        </div>
        <div>
            <label for="observacao">Observação:</label>
            <textarea id="observacao" name="observacao" rows="4"><?php echo htmlspecialchars($movimento['observacao']); ?></textarea>
        </div>
        <button type="submit">Atualizar Movimento</button>
    </form>
<?php endif; ?>

<?php
sqlsrv_close($conn);
include '../includes/footer.php';
?>