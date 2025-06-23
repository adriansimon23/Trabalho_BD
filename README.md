Projeto sistema de E-commerce - GRUPO E

Este projeto consiste na criação de um modelo físico de um banco de dados para um sistema XYZ.
O projeto foi desenvolvido em C# .NET, criando um CRUD para cadastro dos itens xyz, onde a aplicacao faz conexão com o banco de dados através de uma biblioteca chamada entity framework e realiza operações de adição, aualização e deleção dos dados, usando todos os conceitos e dinâmicas práticas de SQL desenvolvidas em aula.

## Integrantes:

- Adrian Simon
- Miguel Arcanjo
- Jorge Luiz
- Wesley Schardosim
- Lucas Vigarani


### Modelo Físico
Utilizamos a ferramenta de modelagem de dados [dbdiagram.io](https://dbdiagram.io/) para criação do modelo físico do banco de dados, para posterior exportação dos scripts DDL das tabelas e relacionamentos.<br>
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
- **Servidor Web:** Apache ou Nginx com suporte a PHP  
- **Conexão com o Banco:**  
  - `sqlsrv_connect()`  
  - ou `PDO` com driver `sqlsrv` habilitado  

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

### Relatório Final
O relatório final está disponível no arquivo [relatorio-final](https://github.com/adriansimon23/Trabalho_BD/tree/main/relatorio-final).
