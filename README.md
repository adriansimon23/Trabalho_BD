#Projeto Final Banco de Dados 2 - sistema de Estoque para E-commerce - GRUPO E

Este projeto consiste na criação de um modelo físico de um banco de dados para um sistema de estoque para E-commerce.
O CRUD foi desenvolvido em liguagem `.php` com servidor `Apache`, criando um CRUD para cadastro dos itens produtos, onde a aplicacao faz conexão com o banco de dados através via `PDO` com driver `sqlsrv` habilitado e realiza operações de adição (Create/insert), leitura(read), , aualização(Update) e deleção(Detet) dos dados, usando todos os conceitos e dinâmicas práticas de SQL desenvolvidas nas atividades de sala de aula.

## Integrantes:

- Adrian Simon
- Lucas Vigarani
- Jorge Luiz
- Miguel Arcanjo
- Wesley Schardosim


### Modelo Físico
Utilizamos a ferramenta de modelagem de dados [dbdiagram.io](https://dbdiagram.io/d/683e087a61dc3bf08d362b42) para criação do modelo físico do banco de dados, para posterior exportação dos scripts DDL das tabelas e relacionamentos.<br>
Arquivo fonte: [Modelo Fisico](https://github.com/adriansimon23/Trabalho_BD/tree/main/modelo_fisico).<br>

![image](https://raw.githubusercontent.com/adriansimon23/Trabalho_BD/refs/heads/main/modelo_fisico/modelo_fisco_banco_de_dados_estoque_e-commerce.png)

### Dicionário de Dados
As informações sobre as tabelas e índices foram documentados na planilha [BANCO ECOMERCE-V-2.0](https://github.com/adriansimon23/Trabalho_BD/tree/main/dicionario_dados).

### Scripts SQL
Para este projeto foi utilizado o banco de dados [Azure SQL](https://azure.microsoft.com/pt-br/products/azure-sql/database) <br>
Este é o procedimento para criação do banco de dados Azure SQL [Criando SQL Azure serverless no Azure gratuito - Sem cartão de crédito](https://github.com/jlsilva01/sql-azure-satc).

Abaixo, segue os scripts SQL separados por tipo:
+ [Tabelas](scripts/ddl/tabelas)
+ [Índices](scripts/ddl/indices)
+ [Gatilhos](scripts/ddl/gatilhos)
+ [Procedimentos armazenados](scripts/ddl/procedimentos-armazenados)
+ [Funções](scripts/ddl/funcoes)
+ [DML](scripts/dml) #pegue a maior versão InsereDadosBanco-v_3.0_.sql
+ 

# Código Fonte do CRUD - PHP + SQL Server

Este projeto implementa um CRUD (Create, Read, Update, Delete) utilizando a linguagem PHP com banco de dados SQL Server, acesssado via `PDO` com driver `pdo_sqlsrv`. A interface é feita com tecnologias web (HTML, CSS e JavaScript).

---

## 🛠 Tecnologias Utilizadas

- **Linguagem de Programação:** PHP  
- **Banco de Dados:** SQL Server (via driver `sqlsrv` ou `PDO`)  
- **Interface Web:** HTML + CSS + JavaScript  
- **Servidor Web:** Apache ou Nginx com suporte a PHP  (usamos Apache)
- **Conexão com o Banco:**  
  - `PDO` com driver `sqlsrv` habilitado  

## 📁 Estrutura Básica do Projeto CRUD
```
projeto_final_ml/
├── config/
│   └── database.php                # Configurações para comunicação com banco de dados
├── includes/                      
│   └── footer.php                  # Cabeçalho global (usado em todas as páginas)
│   └── header.php                  # Rodapé global (usado em todas as páginas)
├── includes/                      
│   └── create.php                   # código referente a inclusão de uma "movimentação de estoque"                
│   └── delete.php                  # código referente ao delete de uma "movimentação de estoque"
│   └── index.php                  # página principal do CRUD de "movimentação de estoque"
│   └── read.php                    # código referente ao read, quando feita a requisição do read, ele lê o banco de dados e com o codigo em php são exibidos os dados da tabela "movimentação de estoque" na pagina web.
│   └── style.css                   # Estilo em codigo .css global (usado em todas as páginas)
│   └── update.php                  # código referente a update (atualização) de uma "movimentação de estoque
```

[Codigo Fonte](crud/)


# 🚀 Guia de Execução do Projeto CRUD com PHP + Azure SQL

Este guia detalha os passos necessários para configurar e executar seu projeto CRUD em **PHP** usando **XAMPP (Apache)** e um **Banco de Dados Azure SQL**.

---

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter o seguinte software instalado e configurado em seu sistema:

- ✅ **XAMPP** – Servidor Web Apache e PHP.  
  ➡️ [Download XAMPP](https://www.apachefriends.org/)

- ✅ **PHP SQL Server Driver (PDO_SQLSRV)** – Para conexão PHP com Azure SQL.  
  ➡️ [Microsoft Drivers for PHP for SQL Server](https://learn.microsoft.com/sql/connect/php/download-drivers-php-sql-server)

> ⚠️ **IMPORTANTE:** A instalação do driver PDO_SQLSRV é **CRÍTICA** para que a conexão PHP ↔️ Azure SQL funcione corretamente.

 1.   **Crie  área restrita da azure ** – Para criação da área restrita seguir o documento no link abaixo, para criar o banco seguir o item 2, para adiantar. 

[Código criação da area restrita de dados Azure SQL](https://storage.satc.edu.br/arquivos/docentes/4906/20251/files/BD2/Criar%20SQL%20Server%20na%20Azure%20em%20uma%20assinatura%20gratuita.pdf)

 2.   **Crie o banco na área restrita da azure com o script** – Criação do banco 

[Código do script para criação do banco de dados Azure SQL](https://storage.satc.edu.br/arquivos/docentes/4906/20251/files/BD2/3%20-%20Linguagem%20SQL%20-%20Fun%C3%A7%C3%B5es%20de%20Janela%20(Window%20Functions)/script_bash_cria_sql_server_azure.txt)

3.   **Configure o arquivo database.php de acordo com os dados do seu banco de dados** – pegar as informações: nome do banco, login e senha do seu BC

4.  **Criar as tabelas e popular as mesmas com o scripts** – Criar as tabelas e inserir os dados para não ocorrer erro

[Scripts para criar as tabelas](scripts/ddl/tabelas)

[Scripts para popular as tabelas](scripts/dml) #pegue a maior versão InsereDadosBanco-v_3.0_.sql

5.  **XampControl** – Abrir o XAMPP Control e iniciar o servidor Apache

6.  **Acessar o link abaixo para acessar a página inicial do CRUD**

[link acesso local do CRUD](http://crud-ecommerce.local/)



### Relatório Final
O relatório final está disponível no arquivo [relatorio-final](https://github.com/adriansimon23/Trabalho_BD/tree/main/relatorio-final).
