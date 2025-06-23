<?php
// Inclui o arquivo de conexão com o banco de dados (PDO).
include '../config/database.php';
include '../includes/header.php';

// Verifica se a conexão PDO foi estabelecida corretamente.
if (!isset($pdo) || !$pdo instanceof PDO) {
    die("Erro: Conexão com o banco de dados não estabelecida via PDO. Verifique database.php.");
}

// SQL para selecionar os movimentos de estoque e o nome do produto relacionado.
$sql = "SELECT me.id_movimento, p.nome AS nome_produto, me.tipo_movimento, me.quantidade, me.data_movimento, me.observacao
        FROM movimento_estoque me
        JOIN produto p ON me.produto_id = p.id_produto
        ORDER BY me.data_movimento DESC";

try {
    // Executa a consulta SQL usando PDO
    $stmt = $pdo->query($sql);

    // Verifica se a execução da consulta falhou.
    if (!$stmt) {
        die("Erro ao preparar/executar a consulta SQL.");
    }
} catch (PDOException $e) {
    die("Erro ao executar a consulta: " . $e->getMessage());
}
?>

<main>
    <h2>Lista de Movimentos de Estoque</h2>

    <?php if (isset($_GET['message'])): ?>
        <div class="message success">
            <?php echo htmlspecialchars($_GET['message']); ?>
        </div>
    <?php endif; ?>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Produto</th>
                <th>Tipo de Movimento</th>
                <th>Quantidade</th>
                <th>Data do Movimento</th>
                <th>Observação</th>
                <th class="actions">Ações</th>
            </tr>
        </thead>
        <tbody>
            <?php
            // Itera sobre os resultados da consulta e exibe cada linha na tabela usando PDO.
            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                echo "<tr>";
                echo "<td>" . htmlspecialchars($row['id_movimento']) . "</td>";
                echo "<td>" . htmlspecialchars($row['nome_produto']) . "</td>";
                echo "<td>" . htmlspecialchars($row['tipo_movimento']) . "</td>";
                echo "<td>" . htmlspecialchars($row['quantidade']) . "</td>";
                echo "<td>";
                // As datas do PDO vêm como string por padrão. Converte para DateTime para formatar.
                if (isset($row['data_movimento'])) {
                    try {
                        $dt = new DateTime($row['data_movimento']);
                        echo htmlspecialchars($dt->format('d/m/Y H:i:s'));
                    } catch (Exception $e) {
                        echo "Data Inválida";
                    }
                } else {
                    echo "N/A";
                }
                echo "</td>";
                echo "<td>" . htmlspecialchars($row['observacao']) . "</td>";
                echo "<td class='actions'>";
                // === ATENÇÃO AQUI: O LINK DE EDIÇÃO PASSA O ID ===
                echo "<a href='update.php?id=" . htmlspecialchars($row['id_movimento']) . "'>Editar</a>";
                echo "<a href='delete.php?id=" . htmlspecialchars($row['id_movimento']) . "' onclick='return confirm(\"Tem certeza que deseja excluir este movimento?\")' class='delete'>Excluir</a>";
                echo "</td>";
                echo "</tr>";
            }
            ?>
        </tbody>
    </table>
</main>

<?php
// No PDO, os recursos do statement são liberados automaticamente.
// A conexão $pdo também é fechada automaticamente quando o script termina.
// include '../includes/footer.php';
// Removendo include '../includes/footer.php' se ele já contiver o fechamento $pdo = null;
// ou se não quiser fechar explicitamente.

// Certifique-se de que o footer é incluído DEPOIS de fechar o HTML principal
include '../includes/footer.php';
?>