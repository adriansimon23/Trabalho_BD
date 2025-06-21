<?php

// ** IMPORTANTE: SUBSTITUA "SEU_NOME_DO_SERVIDOR_AZURE_COMPLETO" PELO NOME REAL DO SEU SERVIDOR DO AZURE SQL. **
// Você precisa obter este nome APÓS a execução do seu script de criação do Azure CLI.
// Ele terá um formato parecido com: azuresql-server-123456789.database.windows.net

$serverName = "azuresql-server-43041051.database.windows.net"; // Exemplo: azuresql-server-458923485.database.windows.net
$databaseName = "dados";                          // Do seu script CLI: database="dados"
$uid = "admin_user";                              // Do seu script CLI: login="admin_user"
$pwd = "satc@2025";                               // Do seu script CLI: password="satc@2025"
$port = 1433;                A                     // Porta padrão para Azure SQL

try {
    // String de conexão (DSN - Data Source Name) para SQL Server via PDO
    $dsn = "sqlsrv:server=$serverName,$port;Database=$databaseName";

    // Opções de conexão PDO
    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // Lança exceções para erros
        PDO::SQLSRV_ATTR_ENCODING => PDO::SQLSRV_ENCODING_UTF8 // Garante UTF-8
    ];

    // Cria uma nova instância PDO
    $pdo = new PDO($dsn, $uid, $pwd, $options);

    // Opcional: Mensagem de sucesso (comente ou remova em produção)
    // echo "Conexão com o banco de dados estabelecida com sucesso!";

} catch (PDOException $e) {
    // Em caso de erro na conexão
    die("Erro na conexão com o banco de dados: " . $e->getMessage());
}

// A variável $pdo agora contém o objeto de conexão com o banco de dados

?>