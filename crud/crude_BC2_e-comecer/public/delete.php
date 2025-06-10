<?php
include '../config/database.php';

if (isset($_GET['id'])) {
    $id_movimento = $_GET['id'];

    $sql = "DELETE FROM movimento_estoque WHERE id_movimento = ?";
    $params = array($id_movimento);
    $stmt = sqlsrv_query($conn, $sql, $params);

    if ($stmt === false) {
        $message = "Erro ao excluir movimento: " . print_r(sqlsrv_errors(), true);
        header("Location: index.php?message=" . urlencode($message));
    } else {
        $message = "Movimento excluído com sucesso!";
        header("Location: index.php?message=" . urlencode($message));
    }
} else {
    $message = "ID do movimento não especificado.";
    header("Location: index.php?message=" . urlencode($message));
}

sqlsrv_close($conn);
?>