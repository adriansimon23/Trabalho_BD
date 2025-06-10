<?php
include '../config/database.php';
include '../includes/header.php';

$message = '';
$message_type = '';

// Buscar produtos para o dropdown
$sql_produtos = "SELECT id_produto, nome FROM produto ORDER BY nome";
$stmt_produtos = sqlsrv_query($conn, $sql_produtos);
if ($stmt_produtos === false) {
    die(print_r(sqlsrv_errors(), true));
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $produto_id = $_POST['produto_id'];
    $tipo_movimento = $_POST['tipo_movimento'];
    $quantidade = $_POST['quantidade'];
    $data_movimento_str = $_POST['data_movimento'];
    $observacao = $_POST['observacao'];

    // Converte a string de data/hora para o formato adequado para SQL Server
    $data_movimento = new DateTime($data_movimento_str);

    $sql = "INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao) 
            VALUES (?, ?, ?, ?, ?)";
    $params = array($produto_id, $tipo_movimento, $quantidade, $data_movimento->format('Y-m-d H:i:s'), $observacao);
    $stmt = sqlsrv_query($conn, $sql, $params);

    if ($stmt === false) {
        $message = "Erro ao adicionar movimento: " . print_r(sqlsrv_errors(), true);
        $message_type = 'error';
    } else {
        $message = "Movimento adicionado com sucesso!";
        $message_type = 'success';
        // Redireciona para a página de listagem após 2 segundos
        header("refresh:2;url=index.php?message=" . urlencode($message));
    }
}
?>

<h2>Adicionar Novo Movimento de Estoque</h2>

<?php if ($message): ?>
    <div class="message <?php echo $message_type; ?>">
        <?php echo htmlspecialchars($message); ?>
    </div>
<?php endif; ?>

<form action="create.php" method="POST">
    <div>
        <label for="produto_id">Produto:</label>
        <select id="produto_id" name="produto_id" required>
            <option value="">Selecione um produto</option>
            <?php
            while ($row_produto = sqlsrv_fetch_array($stmt_produtos, SQLSRV_FETCH_ASSOC)) {
                echo "<option value='" . htmlspecialchars($row_produto['id_produto']) . "'>" . htmlspecialchars($row_produto['nome']) . "</option>";
            }
            sqlsrv_free_stmt($stmt_produtos);
            ?>
        </select>
    </div>
    <div>
        <label for="tipo_movimento">Tipo de Movimento:</label>
        <select id="tipo_movimento" name="tipo_movimento" required>
            <option value="">Selecione o tipo</option>
            <option value="ENTRADA">ENTRADA</option>
            <option value="SAIDA">SAIDA</option>
        </select>
    </div>
    <div>
        <label for="quantidade">Quantidade:</label>
        <input type="number" id="quantidade" name="quantidade" min="1" required>
    </div>
    <div>
        <label for="data_movimento">Data do Movimento:</label>
        <input type="datetime-local" id="data_movimento" name="data_movimento" value="<?php echo date('Y-m-d\TH:i'); ?>" required>
    </div>
    <div>
        <label for="observacao">Observação:</label>
        <textarea id="observacao" name="observacao" rows="4"></textarea>
    </div>
    <button type="submit">Adicionar Movimento</button>
</form>

<?php
sqlsrv_close($conn);
include '../includes/footer.php';
?>