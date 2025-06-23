<?php
// Inclui o arquivo de configuração do banco de dados para estabelecer a conexão.
// A variável $pdo (objeto PDO) estará disponível após esta inclusão.
include '../config/database.php';
// Inclui o cabeçalho da página (HTML inicial, navegação).
include '../includes/header.php';

$message = '';
$message_type = '';

// 1. Buscar produtos para o dropdown usando PDO
$sql_produtos = "SELECT id_produto, nome FROM produto ORDER BY nome";
$stmt_produtos = null; // Inicializa a variável para evitar Warning caso a query falhe

try {
    // Executa a consulta. query() é para consultas SELECT simples que não precisam de parâmetros.
    $stmt_produtos = $pdo->query($sql_produtos);
    // Verifica se a consulta retornou resultados
    if ($stmt_produtos === false) {
        throw new PDOException("Erro ao executar a consulta de produtos.");
    }
} catch (PDOException $e) {
    // Captura e exibe erros de PDO. Em produção, você registraria isso em um log.
    die("Erro ao buscar produtos: " . $e->getMessage());
}

// 2. Processar o formulário quando enviado (método POST)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Coleta os dados do formulário
    $produto_id = $_POST['produto_id'];
    $tipo_movimento = $_POST['tipo_movimento'];
    $quantidade = $_POST['quantidade'];
    $data_movimento_str = $_POST['data_movimento'];
    $observacao = $_POST['observacao'];

    // Converte a string de data/hora para o formato adequado para SQL Server (DateTime é ótimo para isso)
    $data_movimento = new DateTime($data_movimento_str);
    $data_formatada_sql = $data_movimento->format('Y-m-d H:i:s'); // Formato 'YYYY-MM-DD HH:MM:SS'

    // SQL para inserção usando placeholders nomeados para PDO
    $sql_insert = "INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, data_movimento, observacao)
                   VALUES (:produto_id, :tipo_movimento, :quantidade, :data_movimento, :observacao)";

    try {
        // Prepara a instrução SQL. Isso ajuda a prevenir SQL Injection.
        $stmt_insert = $pdo->prepare($sql_insert);

        // Binda os parâmetros. Usamos bindParam para vincular variáveis por referência.
        $stmt_insert->bindParam(':produto_id', $produto_id, PDO::PARAM_INT);
        $stmt_insert->bindParam(':tipo_movimento', $tipo_movimento, PDO::PARAM_STR);
        $stmt_insert->bindParam(':quantidade', $quantidade, PDO::PARAM_INT);
        $stmt_insert->bindParam(':data_movimento', $data_formatada_sql, PDO::PARAM_STR); // Data é uma string para SQLSRV driver
        $stmt_insert->bindParam(':observacao', $observacao, PDO::PARAM_STR);

        // Executa a instrução preparada
        $stmt_insert->execute();

        $message = "Movimento adicionado com sucesso!";
        $message_type = 'success';
        // Redireciona para a página de listagem após 2 segundos
        header("refresh:2;url=index.php?message=" . urlencode($message));
        exit(); // É importante chamar exit() após um header() para evitar que o restante do script seja executado.

    } catch (PDOException $e) {
        $message = "Erro ao adicionar movimento: " . $e->getMessage();
        $message_type = 'error';
    }
}
?>

<h2>Adicionar Novo Movimento de Estoque</h2>

<?php if ($message): // Exibe mensagens de sucesso ou erro ?>
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
            // 3. Loop para preencher o dropdown de produtos
            if ($stmt_produtos) { // Verifica se a consulta foi bem-sucedida
                // fetchAll() pega todos os resultados de uma vez, mas para um dropdown
                // você pode iterar diretamente sobre o statement para grandes conjuntos de dados.
                // Usaremos fetch() dentro de um loop for/while aqui.
                while ($row_produto = $stmt_produtos->fetch(PDO::FETCH_ASSOC)) {
                    echo "<option value='" . htmlspecialchars($row_produto['id_produto']) . "'>" . htmlspecialchars($row_produto['nome']) . "</option>";
                }
            }
            // Não há necessidade de sqlsrv_free_stmt() ou sqlsrv_close() com PDO.
            // O PDO gerencia os recursos e a conexão é fechada automaticamente no final do script
            // ou quando o objeto $pdo sai do escopo.
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
// Não é necessário chamar sqlsrv_close($conn); aqui, pois estamos usando PDO.
// A conexão PDO será fechada automaticamente quando o script terminar.
// Se você realmente precisar fechar explicitamente (raro para scripts curtos), defina $pdo = null;
include '../includes/footer.php';
?>