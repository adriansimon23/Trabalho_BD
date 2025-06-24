<?php
require_once 'conexao.php';

// --- Lógica para ADICIONAR ou EDITAR ---
if (isset($_POST['acao'])) {
    // Escapa os dados para segurança
    $acao = $_POST['acao'];
    $produto_id = $_POST['produto_id'];
    $tipo_movimento = $_POST['tipo_movimento'];
    $quantidade = $_POST['quantidade'];
    $observacao = $_POST['observacao'];

    if ($acao == 'adicionar') {
        // Operação de Adição (INSERT)
        $sql = "INSERT INTO movimento_estoque (produto_id, tipo_movimento, quantidade, observacao) VALUES (?, ?, ?, ?)";
        $stmt = $conexao->prepare($sql);
        // "isss" significa que os parâmetros são: integer, string, integer, string
        $stmt->bind_param("isis", $produto_id, $tipo_movimento, $quantidade, $observacao);

    } elseif ($acao == 'editar') {
        // Operação de Atualização (UPDATE)
        $id_movimento = $_POST['id_movimento'];
        $sql = "UPDATE movimento_estoque SET produto_id = ?, tipo_movimento = ?, quantidade = ?, observacao = ? WHERE id_movimento = ?";
        $stmt = $conexao->prepare($sql);
        $stmt->bind_param("isisi", $produto_id, $tipo_movimento, $quantidade, $observacao, $id_movimento);
    }

    if ($stmt->execute()) {
        // Sucesso
    } else {
        // Erro
        echo "Erro ao executar a operação: " . $stmt->error;
    }
    $stmt->close();
}

// --- Lógica para EXCLUIR ---
if (isset($_GET['acao']) && $_GET['acao'] == 'excluir') {
    $id_movimento = $_GET['id'];
    // Operação de Exclusão (DELETE)
    $sql = "DELETE FROM movimento_estoque WHERE id_movimento = ?";
    $stmt = $conexao->prepare($sql);
    $stmt->bind_param("i", $id_movimento);

    if ($stmt->execute()) {
        // Sucesso
    } else {
        // Erro
        echo "Erro ao excluir o registro: " . $stmt->error;
    }
    $stmt->close();
}

$conexao->close();

// Redireciona de volta para a página principal após a operação
header('Location: index.php');
exit();
?>