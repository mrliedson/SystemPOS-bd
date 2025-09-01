-- Inserindo dono 1
INSERT INTO dono (id, cpf, data_nascimento, endereco_particular)
VALUES (1, '12345678901', '1980-05-15', 'Rua A, nº 100, Bairro Central');

-- Inserindo dono 2
INSERT INTO dono (id, cpf, data_nascimento, endereco_particular)
VALUES (2, '98765432100', '1990-03-20', 'Rua B, nº 200, Bairro Norte');

-- Inserindo padrão de acessos completos para dono 1
INSERT INTO padroes (
    adicionarUsuario, adicionarProduto, relatorios, reporEstoque, 
    gerenciarPermissoes, adicionarPromocao, cadastrarEmpresa, 
    prestesAVencer, iniciarExpediente
) VALUES (
    TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
);

-- Inserindo padrão de acessos completos para dono 2
INSERT INTO padroes (
    adicionarUsuario, adicionarProduto, relatorios, reporEstoque, 
    gerenciarPermissoes, adicionarPromocao, cadastrarEmpresa, 
    prestesAVencer, iniciarExpediente
) VALUES (
    TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE
);

-- Inserindo usuário tipo dono (dono 1)
INSERT INTO usuarios (
    dono_id, acesso, empresa_id, tipo, email, userlogin, senha_hash,
    nome_completo, telefone, whatsapp, genero
) VALUES (
    1, 1, NULL, 'dono', 'dono1@email.com', 'dono1login', 'hashsenha1',
    'Carlos Dono Um', '11999990000', 1, 'Masculino'
);

-- Inserindo usuário tipo dono (dono 2)
INSERT INTO usuarios (
    dono_id, acesso, empresa_id, tipo, email, userlogin, senha_hash,
    nome_completo, telefone, whatsapp, genero
) VALUES (
    2, 2, NULL, 'dono', 'dono2@email.com', 'dono2login', 'hashsenha2',
    'Fernanda Dono Dois', '11988880000', 0, 'Feminino'
);

-- Inserindo empresa 1º para dono 1
INSERT INTO empresa (
    id, dono_id, telefone, whatsapp, razao_social, nome_fantasia, cnpj,
    endereco_logradouro, endereco_numero, endereco_complemento,
    endereco_bairro, endereco_cidade, endereco_estado, endereco_cep
) VALUES (
    1, 1, '1133334444', 1, 'Empresa Alpha Ltda', 'Alpha Market', '11222433000100',
    'Av. Principal', '1000', 'Sala 2', 'Centro', 'Recife', 'BH', '01040-000'
);

-- Inserindo empresa 2º para dono 1
INSERT INTO empresa (
    id, dono_id, telefone, whatsapp, razao_social, nome_fantasia, cnpj,
    endereco_logradouro, endereco_numero, endereco_complemento,
    endereco_bairro, endereco_cidade, endereco_estado, endereco_cep
) VALUES (
    2, 1, '1133334444', 1, 'Empresa Beta Ltda', 'Beta Market', '11222323000100',
    'Av. Terciaria', '2200', 'Sala 1', 'Centro', 'São Paulo', 'SP', '01000-000'
);

-- Inserindo empresa 2 para dono 1
INSERT INTO empresa (
    id, dono_id, telefone, whatsapp, razao_social, nome_fantasia, cnpj,
    endereco_logradouro, endereco_numero, endereco_complemento,
    endereco_bairro, endereco_cidade, endereco_estado, endereco_cep
) VALUES (
    3, 2, '1144445555', 0, 'Empresa Gama Ltda', 'Gama Store', '22334455000111',
    'Rua Secundária', '200', 'Loja B', 'Bairro Novo', 'Campinas', 'SP', '13000-000'
);

-- Inserindo padrão de acessos completos para gerente
INSERT INTO padroes (
    adicionarUsuario, adicionarProduto, relatorios, reporEstoque, 
    gerenciarPermissoes, adicionarPromocao, cadastrarEmpresa, 
    prestesAVencer, iniciarExpediente
) VALUES (
    TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, TRUE
);

-- Inserindo usuário tipo gerente para dono 1 (empresa 1)
INSERT INTO usuarios (
    dono_id, acesso, empresa_id, tipo, email, userlogin, senha_hash,
    nome_completo, telefone, whatsapp, genero
) VALUES (
    NULL, 3, 1, 'gerente', 'gerente1@email.com', 'gerente1login', 'hashgerente1',
    'Marcos Gerente', '11997778888', 1, 'Masculino'
);

-- Inserindo padrão de acessos completos para caixa
INSERT INTO padroes (
    adicionarUsuario, adicionarProduto, relatorios, reporEstoque, 
    gerenciarPermissoes, adicionarPromocao, cadastrarEmpresa, 
    prestesAVencer, iniciarExpediente
) VALUES (
    FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE
);

-- Inserindo usuário tipo caixa para dono 1 (empresa 2)
INSERT INTO usuarios (
    dono_id, acesso, empresa_id, tipo, email, userlogin, senha_hash,
    nome_completo, telefone, whatsapp, genero
) VALUES (
    NULL, 4, 1, 'caixa', 'caixa1@email.com', 'caixa1login', 'hashcaixa1',
    'Paula Caixa', '11996667777', 0, 'Feminino'
);

-- Inserindo padrão de acessos completos para estoque
INSERT INTO padroes (
    adicionarUsuario, adicionarProduto, relatorios, reporEstoque, 
    gerenciarPermissoes, adicionarPromocao, cadastrarEmpresa, 
    prestesAVencer, iniciarExpediente
) VALUES (
    FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE
);

-- Inserindo usuário tipo estoque para dono 1 (empresa 1)
INSERT INTO usuarios (
    dono_id, acesso, empresa_id, tipo, email, userlogin, senha_hash,
    nome_completo, telefone, whatsapp, genero
) VALUES (
    NULL, 5, 1, 'estoque', 'estoque1@email.com', 'estoque1login', 'hashestoque1',
    'Luiz Estoquista', '11995556666', 1, 'Masculino'
);



-- Inserindo produtos de teste
INSERT INTO cadastro_produto 
(empresa_id, codigo_produto, nome, marca, codigo_barras, tipo_produto, modelo, categoria, data_validade, estoque_min, estoque_max, preco, imagem, quantidade)
VALUES
(1, 1, 'Produto A', 'Marca A', '1234567890123', 'Eletrônico', 'Modelo A', 'Categoria 1', '2025-12-31', 1, 100, 50.00, 'img1.jpg', 10),
(1, 2, 'Produto B', 'Marca B', '1234567890124', 'Eletrônico', 'Modelo B', 'Categoria 1', '2025-12-31', 1, 100, 50.00, 'img2.jpg', 10),
(1, 3, 'Produto C', 'Marca C', '1234567890125', 'Eletrônico', 'Modelo C', 'Categoria 1', '2025-12-31', 1, 100, 60.25, 'img3.jpg', 10);



-- Inserindo vendas de teste
INSERT INTO venda (empresa_id, usuario_id, data_venda, valor_total, forma_pagamento, status)
VALUES 
(1, 1, NOW() - INTERVAL 6 DAY, 150.00, 'Dinheiro', 'pago'),
(1, 1, NOW() - INTERVAL 5 DAY, 220.50, 'Cartão', 'pago'),
(1, 1, NOW() - INTERVAL 4 DAY, 80.00, 'PIX', 'pago'),
(1, 1, NOW() - INTERVAL 3 DAY, 300.75, 'Cartão', 'pendente'),
(1, 1, NOW() - INTERVAL 2 DAY, 120.00, 'Dinheiro', 'pago'),
(1, 1, NOW() - INTERVAL 1 DAY, 200.00, 'PIX', 'pago');

-- Inserindo itens correspondentes para cada venda (exemplo de produtos)
INSERT INTO item_venda (venda_id, codigo_produto, quantidade, preco_unitario)
VALUES 
(1, 1, 2, 50.00),
(1, 2, 1, 50.00),
(2, 1, 3, 50.00),
(2, 3, 2, 60.25),
(3, 2, 1, 80.00),
(4, 1, 5, 60.15),
(5, 3, 2, 60.00),
(6, 1, 4, 50.00);

INSERT INTO cliente (empresa_id, nome_completo, cpf, telefone) 
VALUES (1, 'João Silva', '12345678900', '11999999999');











INSERT INTO cliente (empresa_id, nome_completo, cpf, telefone, email, endereco)
VALUES
(1, 'Cliente 4', '44444444444', '11955555555', 'cliente4@test.com', 'Rua D, 400'),
(1, 'Cliente 5', '55555555555', '11944444444', 'cliente5@test.com', 'Rua E, 500');
INSERT INTO cadastro_produto (empresa_id, codigo_produto, nome, marca, codigo_barras, tipo_produto, modelo, categoria, data_validade, estoque_min, estoque_max, preco, imagem, quantidade)
VALUES
(1, 1001, 'Produto A', 'Marca X', '1234567890123', 'Alimento', 'Modelo A', 'Categoria 1', '2025-12-31', 1, 50, 20.00, 'imagem1.png', 10),
(1, 1002, 'Produto B', 'Marca Y', '1234567890124', 'Alimento', 'Modelo B', 'Categoria 2', '2025-11-30', 2, 40, 35.00, 'imagem2.png', 15),
(1, 1003, 'Produto C', 'Marca Z', '1234567890125', 'Bebida', 'Modelo C', 'Categoria 3', '2025-10-31', 1, 30, 50.00, 'imagem3.png', 5);

INSERT INTO historico_estoque (codigo_produto, tipo_movimentacao, quantidade, usuario_id, data_movimentacao)
VALUES
(1, 'entrada', 5, 1, '2025-08-26 09:00:00'),
(2, 'entrada', 3, 1, '2025-08-27 10:00:00'),
(3, 'saida', 2, 1, '2025-08-28 11:00:00');
INSERT INTO gastos (empresa_id, descricao, valor, data_gasto, categoria)
VALUES
(1, 'Compra de embalagens', 50.00, '2025-08-28 08:00:00', 'Materiais'),
(1, 'Manutenção equipamentos', 120.00, '2025-08-29 09:00:00', 'Despesas');




