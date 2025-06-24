<?php
// Configurações do banco de dados
$servidor = "localhost";
$usuario = "root"; // Usuário padrão do XAMPP
$senha = ""; // Senha padrão do XAMPP é vazia
$banco = "crud ecommerce"; // O nome do banco que criamos

// Cria a conexão
$conexao = new mysqli($servidor, $usuario, $senha, $banco);

// Verifica a conexão
if ($conexao->connect_error) {
    die("Falha na conexão: " . $conexao->connect_error);
}
?>