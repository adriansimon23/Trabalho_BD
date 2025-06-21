<?php
include '../config/database.php';
include '../includes/header.php';

$message = '';
$message_type = '';
$movimento = null; // Variável para armazenar os dados do movimento

// Verifica se a conexão PDO foi estabelecida corretamente.
if (!isset($pdo) || !$pdo instanceof PDO) {
    die("Erro: Conexão com o banco de dados não estabelecida via PDO. Verifique database.php.");
}

// Determina o ID do movimento. Prioriza POST (se o formulário foi enviado), senão GET.
$id_movimento_current = null;
if (isset($_POST['id_movimento']) && !empty($_POST['id_movimento'])) {
    $id_movimento_current = $_POST['id_movimento'];
} elseif (isset($_GET['id']) && !empty($_GET['id'])) {
    $id_movimento_current = $_GET['id'];
}

// --- Lógica para buscar o movimento para edição ou após POST ---
if ($id_movimento_current !== null) {
    try {
        $sql_movimento = "SELECT id_movimento, produto_id, tipo_movimento, quantidade, data_movimento, observacao FROM movimento_estoque WHERE id_movimento = ?";
        $stmt_movimento = $pdo->prepare($sql_movimento);
        $stmt_movimento->execute([$id_movimento_current]);
        $movimento = $stmt_movimento->fetch(PDO::FETCH_ASSOC);

        if ($movimento === false) {
            $message = "Movimento não encontrado para o ID: " . htmlspecialchars($id_movimento_current);
            $message_type = 'error';
            $movimento = null; // Garante que $movimento seja null se não encontrado
        }

    } catch (PDOException $e) {
        $message = "Erro ao buscar movimento: " . $e->getMessage();
        $message_type = 'error';
        $movimento = null;
    }
} else {
    // Esta mensagem só aparecerá se não houver ID nem em GET nem em POST
    $message = "ID do movimento não especificado ou inválido.";
    $message_type = 'error';
}


// --- Lógica para buscar produtos para o dropdown ---
$produtos = [];
try {
    $sql_produtos = "SELECT id_produto, nome FROM produto ORDER BY nome";
    $stmt_produtos = $pdo->query($sql_produtos);
    $produtos = $stmt_produtos->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $message .= "<br>Erro ao buscar produtos: " . $e->getMessage();
    $message_type = ($message_type === '') ? 'error' : $message_type;
}

// --- Lógica para processar o formulário de atualização (POST request) ---
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $movimento !== null) { // Verifica se é POST e se um movimento foi carregado
    // Pega os dados do formulário POST
    $produto_id = $_POST['produto_id'];
    $tipo_movimento = $_POST['tipo_movimento'];
    $quantidade = $_POST['quantidade'];
    $data_movimento_str = $_POST['data_movimento'];
    $observacao = $_POST['observacao'];

    try {
        $data_movimento = new DateTime($data_movimento_str);

        $sql_update = "UPDATE movimento_estoque SET produto_id = ?, tipo_movimento = ?, quantidade = ?, data_movimento = ?, observacao = ? WHERE id_movimento = ?";
        $stmt_update = $pdo->prepare($sql_update);
        $stmt_update->execute([
            $produto_id,
            $tipo_movimento,
            $quantidade,
            $data_movimento->format('Y-m-d H:i:s'),
            $observacao,
            $movimento['id_movimento'] // Usar o ID do $movimento carregado, que é confiável
        ]);

        $message = "Movimento atualizado com sucesso!";
        $message_type = 'success';

        // Atualiza o objeto $movimento com os novos dados para que o formulário exiba o estado mais recente
        $movimento['produto_id'] = $produto_id;
        $movimento['tipo_movimento'] = $tipo_movimento;
        $movimento['quantidade'] = $quantidade;
        $movimento['data_movimento'] = $data_movimento;
        $movimento['observacao'] = $observacao;

        header("refresh:2;url=index.php?message=" . urlencode($message));
        exit();

    } catch (PDOException $e) {
        $message = "Erro ao atualizar movimento: " . $e->getMessage();
        $message_type = 'error';
    } catch (Exception $e) {
        $message = "Erro no formato da data: " . $e->getMessage();
        $message_type = 'error';
    }
}
?>

<main>
    <h2>Editar Movimento de Estoque</h2>

    <?php if ($message): ?>
        <div class="message <?php echo $message_type; ?>">
            <?php echo htmlspecialchars($message); ?>
        </div>
    <?php endif; ?>

    <?php if ($movimento): // Só exibe o formulário se um movimento foi encontrado ?>
        <form action="update.php" method="POST">
            <input type="hidden" name="id_movimento" value="<?php echo htmlspecialchars($movimento['id_movimento']); ?>">
            <div>
                <label for="produto_id">Produto:</label>
                <select id="produto_id" name="produto_id" required>
                    <option value="">Selecione um produto</option>
                    <?php
                    foreach ($produtos as $row_produto) {
                        $selected = ((string)$row_produto['id_produto'] === (string)$movimento['produto_id']) ? 'selected' : '';
                        echo "<option value='" . htmlspecialchars($row_produto['id_produto']) . "' " . $selected . ">" . htmlspecialchars($row_produto['nome']) . "</option>";
                    }
                    ?>
                </select>
            </div>
            <div>
                <label for="tipo_movimento">Tipo de Movimento:</label>
                <select id="tipo_movimento" name="tipo_movimento" required>
                    <option value="">Selecione o tipo</option>
                    <option value="ENTRADA" <?php echo ((string)$movimento['tipo_movimento'] === 'ENTRADA') ? 'selected' : ''; ?>>ENTRADA</option>
                    <option value="SAIDA" <?php echo ((string)$movimento['tipo_movimento'] === 'SAIDA') ? 'selected' : ''; ?>>SAIDA</option>
                </select>
            </div>
            <div>
                <label for="quantidade">Quantidade:</label>
                <input type="number" id="quantidade" name="quantidade" min="1" value="<?php echo htmlspecialchars($movimento['quantidade']); ?>" required>
            </div>
            <div>
                <label for="data_movimento">Data do Movimento:</label>
                <?php
                $data_formatada = '';
                if (isset($movimento['data_movimento'])) {
                    try {
                        $dt = ($movimento['data_movimento'] instanceof DateTime) ? $movimento['data_movimento'] : new DateTime($movimento['data_movimento']);
                        $data_formatada = $dt->format('Y-m-d\TH:i');
                    } catch (Exception $e) {
                        $data_formatada = '';
                    }
                }
                ?>
                <input type="datetime-local" id="data_movimento" name="data_movimento" value="<?php echo htmlspecialchars($data_formatada); ?>" required>
            </div>
            <div>
                <label for="observacao">Observação:</label>
                <textarea id="observacao" name="observacao" rows="4"><?php echo htmlspecialchars($movimento['observacao']); ?></textarea>
            </div>
            <button type="submit">Atualizar Movimento</button>
        </form>
    <?php else: // Se $movimento for null, não exibe o formulário ?>
        <p>Não foi possível carregar os dados para edição.</p>
    <?php endif; ?>
</main>

<?php
include '../includes/footer.php';
?>