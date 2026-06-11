/*
 * SGBD: MySQL
 *
 * Este arquivo contém:
 * - Definição da estrutura do banco de dados `microblog` (tabelas).
 * - Massa de dados para testes.
 */

DROP DATABASE IF EXISTS microblog;
CREATE DATABASE microblog;
USE microblog;


-- tabelas

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    nome_exibicao VARCHAR(100) NOT NULL,
    bio VARCHAR(160),
    foto_perfil VARCHAR(255),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE post (
    id INT NOT NULL AUTO_INCREMENT,
    conteudo VARCHAR(280) NOT NULL,
    foto_url VARCHAR(255),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    autor_id INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_post_autor FOREIGN KEY (autor_id) REFERENCES usuario(id)
);

CREATE TABLE seguidor (
    seguidor_id INT NOT NULL,
    seguido_id INT NOT NULL,
    data_follow DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (seguidor_id, seguido_id),
    CONSTRAINT fk_seguidor FOREIGN KEY (seguidor_id) REFERENCES usuario(id),
    CONSTRAINT fk_seguido  FOREIGN KEY (seguido_id)  REFERENCES usuario(id),
    CONSTRAINT ck_auto_follow CHECK (seguidor_id <> seguido_id)
);


-- dados de teste

INSERT INTO usuario (id, username, email, senha, nome_exibicao, bio)
VALUES (1, 'joao', 'joao@email.com', '123456', 'João Henrique', 'Desenvolvedor Java apaixonado por café.');

INSERT INTO usuario (id, username, email, senha, nome_exibicao, bio)
VALUES (2, 'lucas', 'lucas@email.com', '123456', 'Lucas Domingos', 'Estudante de ADS no IFSP.');

INSERT INTO usuario (id, username, email, senha, nome_exibicao, bio)
VALUES (3, 'luiz', 'luiz@email.com', '123456', 'Luiz Gustavo', 'Gosto de tecnologia e games.');

INSERT INTO post (id, conteudo, autor_id) VALUES (1, 'Olá, esse é meu primeiro post no microblog!', 1);
INSERT INTO post (id, conteudo, autor_id) VALUES (2, 'Java EE é raiz. Servlet na veia.', 1);
INSERT INTO post (id, conteudo, autor_id) VALUES (3, 'Acabei de configurar o projeto, vamos nessa!', 2);
INSERT INTO post (id, conteudo, autor_id) VALUES (4, 'Alguém mais acha JDBC terapêutico?', 3);
INSERT INTO post (id, conteudo, autor_id) VALUES (5, 'Pool de conexões funcionando. Que alívio.', 2);

-- lucas segue joao, luiz segue joao e lucas
INSERT INTO seguidor (seguidor_id, seguido_id) VALUES (2, 1);
INSERT INTO seguidor (seguidor_id, seguido_id) VALUES (3, 1);
INSERT INTO seguidor (seguidor_id, seguido_id) VALUES (3, 2);