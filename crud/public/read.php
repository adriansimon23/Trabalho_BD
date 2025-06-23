<?php
include '../config/database.php';
include '../includes/header.php';

$sql = "SELECT me.id_movimento, p.nome AS nome_produto, me.tipo_movimento, me.quantidade, me.data_movimento, me.observacao
        FROM movimento_estoque me
        JOIN produto p ON me.produto_id = p.id_produto
        ORDER BY me.data_movimento DESC";
$stmt = sqlsrv_query($conn, $sql);

if ($stmt === false) {
    die(print_r(sqlsrv_errors(), true));
}
?>

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
        while ($row = sqlsrv_fetch_array($stmt, SQLSRV_FETCH_ASSOC)) {
            echo "<tr>";
            echo "<td>" . htmlspecialchars($row['id_movimento']) . "</td>";
            echo "<td>" . htmlspecialchars($row['nome_produto']) . "</td>";
            echo "<td>" . htmlspecialchars($row['tipo_movimento']) . "</td>";
            echo "<td>" . htmlspecialchars($row['quantidade']) . "</td>";
            // Formata a data para exibição
            echo "<td>" . htmlspecialchars($row['data_movimento']->format('d/m/Y H:i:s')) . "</td>";
            echo "<td>" . htmlspecialchars($row['observacao']) . "</td>";
            echo "<td class='actions'>";
            echo "<a href='update.php?id=" . htmlspecialchars($row['id_movimento']) . "'>Editar</a>";
            echo "<a href='delete.php?id=" . htmlspecialchars($row['id_movimento']) . "' onclick='return confirm(\"Tem certeza que deseja excluir este movimento?\")' class='delete'>Excluir</a>";
            echo "</td>";
            echo "</tr>";
        }
        ?>
    </tbody>
</table>

<?php
sqlsrv_free_stmt($stmt);
sqlsrv_close($conn);
include '../includes/footer.php';
?>