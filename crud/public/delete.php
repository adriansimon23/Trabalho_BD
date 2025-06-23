<?php
// Inclui o arquivo de conexão PDO. Ele já define $pdo.
include '../config/database.php';

// Verifica se a conexão PDO foi estabelecida corretamente.
if (!isset($pdo) || !$pdo instanceof PDO) {
    die("Erro: Conexão com o banco de dados não estabelecida via PDO. Verifique database.php.");
}

$message = '';

if (isset($_GET['id'])) {
    $id_movimento = $_GET['id'];

    try {
        // Prepara a consulta DELETE usando prepared statement
        $sql = "DELETE FROM movimento_estoque WHERE id_movimento = ?";
        $stmt = $pdo->prepare($sql);
        $stmt->execute([$id_movimento]);

        // rowCount() retorna o número de linhas afetadas pela última instrução SQL.
        if ($stmt->rowCount() > 0) {
            $message = "Movimento excluído com sucesso!";
        } else {
            $message = "Nenhum movimento encontrado com o ID especificado para exclusão.";
        }

        header("Location: index.php?message=" . urlencode($message));
        exit(); // Importante para parar a execução após o redirecionamento

    } catch (PDOException $e) {
        // Captura e exibe erros de PDO
        $message = "Erro ao excluir movimento: " . $e->getMessage();
        header("Location: index.php?message=" . urlencode($message));
        exit(); // Importante para parar a execução após o redirecionamento
    }
} else {
    $message = "ID do movimento não especificado para exclusão.";
    header("Location: index.php?message=" . urlencode($message));
    exit(); // Importante para parar a execução após o redirecionamento
}

// Não há sqlsrv_close para PDO. A conexão é fechada automaticamente.
?>