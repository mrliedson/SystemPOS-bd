#script com validações a confirmar com o grupo
drop database if exists systempos;
create database systemPos;
use systemPos;

CREATE TABLE dono (
    id INT PRIMARY KEY, 
    
    cpf VARCHAR(11) UNIQUE NOT NULL CHECK (cpf REGEXP '^[0-9]{11}$'),
    data_nascimento DATE, -- Validar no banco que a data tem que ser menor do que a data atual
    endereco_particular TEXT,
    
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
); 

CREATE TABLE empresa (
    id INT PRIMARY KEY,
    dono_id INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    whatsapp bool default 0,

    razao_social VARCHAR(100) NOT NULL,
    nome_fantasia VARCHAR(100) NOT NULL,
    cnpj VARCHAR(14) UNIQUE DEFAULT NULL CHECK (cnpj IS NULL OR cnpj REGEXP '^[0-9]{14}$'),

    endereco_logradouro VARCHAR(100),
    endereco_numero VARCHAR(10) NOT NULL,
    endereco_complemento VARCHAR(50),
    endereco_bairro VARCHAR(50) NOT NULL,
    endereco_cidade VARCHAR(50) NOT NULL,
    endereco_estado CHAR(2) NOT NULL CHECK (endereco_estado REGEXP '^[A-Z]{2}$'),
    endereco_cep VARCHAR(9) NOT NULL,

    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_inatividade DATETIME,
    ativo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (dono_id) REFERENCES dono(id)
);

-- tabela adicional, parametros de configurações
CREATE TABLE padroes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    adicionarUsuario BOOLEAN NOT NULL,
    adicionarProduto BOOLEAN NOT NULL,
    relatorios BOOLEAN NOT NULL,
    reporEstoque BOOLEAN NOT NULL,
    gerenciarPermissoes BOOLEAN NOT NULL,
    adicionarPromocao BOOLEAN NOT NULL,
    cadastrarEmpresa BOOLEAN NOT NULL,
    prestesAVencer BOOLEAN NOT NULL,
    iniciarExpediente BOOLEAN NOT NULL,
    
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE usuarios (
	id int auto_increment primary key,
    dono_id int, -- relacionamento da tabela dono
    acesso int not null,
    empresa_id int,

	tipo enum('dono','gerente','caixa','estoque', 'admin') not null,
	email VARCHAR(100) NOT NULL UNIQUE ,
    userlogin varchar(25) NOT NULL UNIQUE,
    senha_hash varchar(255) NOT NULL, -- tipo de criptografia
   
    nome_completo varchar(100) not null,
    telefone VARCHAR(20) NOT NULL, 
    whatsapp bool default 0, -- mostra um icone whatsapp ao lado do contato caso possua whatsapp
    genero enum('Masculino', 'Feminino', 'prefiro não informar') not null,

    data_cadastro datetime default current_timestamp, -- salva registro automatico
    ultimo_login datetime null, -- segurança de sistema
    ativo boolean default true, -- funcionarios desativados não aparecem em tela, e mantem dados ainda registrados
    tentativas_login int default 0, -- garante um limite para segurança
    data_bloqueio datetime null, -- mais segurança
    
    FOREIGN KEY (dono_id) references dono(id), -- caso não tenha o dono aposente/vende apenas desvincula o dado usuario com o dono, garantido registro ainda porem sem vinculação ao dono
    constraint chk_email check (email like '%@%._%'), -- modelo email
    FOREIGN KEY (acesso) REFERENCES padroes(id),   
    FOREIGN KEY (empresa_id) REFERENCES empresa(id)
);


CREATE TABLE cadastro_produto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    empresa_id int not null,
    codigo_produto int not null,
    
    nome VARCHAR(40) NOT NULL,
    marca VARCHAR(20) NOT NULL,
    codigo_barras VARCHAR(50) NOT NULL,
    tipo_produto VARCHAR(20) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    categoria VARCHAR(30) NOT NULL,

    data_validade DATE NOT NULL,
    estoque_min INT NOT NULL CHECK (estoque_min >= 0),
    estoque_max INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL CHECK (preco >= 0),
    imagem VARCHAR(250) NOT NULL,
    quantidade INT DEFAULT 0 CHECK (quantidade >= 0),
    
    data_exclusao DATETIME,
    data_adicao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (empresa_id) REFERENCES empresa(id)
);
CREATE TABLE estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    
    FOREIGN KEY (empresa_id) REFERENCES empresa(id),
    FOREIGN KEY (codigo_produto) REFERENCES cadastro_produto(id)
);
CREATE TABLE venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    usuario_id INT NOT NULL,

    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10,2) NOT NULL CHECK (valor_total >= 0),
    forma_pagamento VARCHAR(20) NOT NULL,
    status ENUM('pendente', 'pago', 'cancelado') DEFAULT 'pendente',

    FOREIGN KEY (empresa_id) REFERENCES empresa(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
CREATE TABLE item_venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT NOT NULL,
    codigo_produto INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    preco_unitario DECIMAL(10,2) NOT NULL CHECK (preco_unitario >= 0),

    FOREIGN KEY (venda_id) REFERENCES venda(id),
    FOREIGN KEY (codigo_produto) REFERENCES cadastro_produto(id)
);
CREATE TABLE cliente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    nome_completo VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL CHECK (cpf REGEXP '^[0-9]{11}$'),
    telefone VARCHAR(20) NOT NULL CHECK (telefone REGEXP '^[0-9()+ -]{8,20}$'),
    email VARCHAR(100) CHECK (email IS NULL OR email LIKE '%@%.%'),
    endereco TEXT,

    FOREIGN KEY (empresa_id) REFERENCES empresa(id)
);
CREATE TABLE historico_estoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_produto INT NOT NULL,
    tipo_movimentacao ENUM('entrada', 'saida') NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    usuario_id INT,
    data_movimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    observacao TEXT,

    FOREIGN KEY (codigo_produto) REFERENCES cadastro_produto(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
CREATE TABLE relatorio_exportado (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo_relatorio ENUM('venda', 'ganhos', 'gastos', 'estoque', 'clientes') NOT NULL,
    data_geracao DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
CREATE TABLE gastos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    empresa_id INT NOT NULL,
    descricao TEXT NOT NULL,
    valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),
    data_gasto DATETIME DEFAULT CURRENT_TIMESTAMP,
    categoria VARCHAR(50),

    FOREIGN KEY (empresa_id) REFERENCES empresa(id)
);