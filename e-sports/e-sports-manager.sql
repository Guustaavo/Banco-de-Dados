-- 23/11/2026
-- ============================================
-- 1. CRIAR JOGADOR
-- ============================================

CREATE TABLE jogador (
    id_jogador SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- 2. CRIAR PERFIL (1:1)
-- CHAVE ESTRANGEIRA NO CREATE TABLE
-- ============================================

CREATE TABLE perfil (
    id_perfil SERIAL PRIMARY KEY,
    nickname VARCHAR(50) NOT NULL,
    ranking INT,
    descricao TEXT,
    id_jogador INT NOT NULL UNIQUE
        REFERENCES jogador(id_jogador)
);


-- ============================================
-- 3. CRIAR EQUIPE
-- ============================================

CREATE TABLE equipe (
    id_equipe SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(10),
    data_criacao DATE
);


-- ============================================
-- 4. RELACIONAR JOGADOR COM EQUIPE (1:N)
-- UTILIZANDO ALTER TABLE
-- ============================================

ALTER TABLE jogador ADD COLUMN id_equipe INT;
ALTER TABLE jogador ADD CONSTRAINT fk_jogador_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id_equipe);

-- LATER RUNNING CODE ABOVE

SELECT * FROM equipe 
SELECT * FROM jogador
SELECT * FROM perfil

INSERT INTO jogador (nome, email) VALUES ('Joãozinho da Silva', 'jaosilva@gmail.com ');

INSERT INTO perfil (nickname, ranking, descricao, id_jogador) VALUES ('ladiesman76', 8000, 'O mais querido', 1);

-- JOGO

CREATE TABLE jogo (
	id_jogo SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	categoria VARCHAR(50),
	desenvolvedora VARCHAR(100)
)

INSERT INTO jogo (nome, categoria, desenvolvedora) VALUES ('Fortnite', 'Battle Royale', 'Epic Games');
INSERT INTO jogo (nome, categoria, desenvolvedora) VALUES 
('Counter Strike 2', 'FPS', 'Valve'),
('LOL', 'MOBA', 'RIOT Games'),
('Rocket League', 'Esporte', 'Epic Games'),
('Minecraft', 'Sandbox', 'Microsoft');

SELECT * FROM jogo;
	
CREATE TABLE campeonato (
	campeonato_id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	premiacao DECIMAL(10, 2),
	data_inicio DATE,
	id_jogo INT NOT NULL REFERENCES jogo(id_jogo)
);

INSERT INTO campeonato (nome, premiacao, data_inicio, id_jogo) VALUES ('FNCS Global Championship', 5000000.0, '2026-09-26', 1);

SELECT * FROM campeonato;

CREATE TYPE STATUS_INSCRICAO AS ENUM ('EM ANALISE', 'APROVADO', 'REPROVADO');

CREATE TABLE inscricao (
	inscricao_id SERIAL PRIMARY KEY,
	data_inscricao DATE NOT NULL,
	status STATUS_INSCRICAO,
	campeonato_id INT NOT NULL REFERENCES campeonato(campeonato_id),
	equipe_id INT NOT NULL REFERENCES equipe(id_equipe)
);

INSERT INTO equipe (nome, sigla, data_criacao) VALUES ('Loud', 'LOUD', '2001-10-31');

INSERT INTO inscricao (data_inscricao, status, campeonato_id, equipe_id) VALUES ('2026-09-10', 'APROVADO', '1', '1')

SELECT  
	inscricao.data_inscricao,
	inscricao.status,
	equipe.nome,
	campeonato.nome,
	campeonato.data_inicio,
	jogo.nome
FROM inscricao 
	INNER JOIN equipe ON inscricao.equipe_id = equipe.id_equipe
	INNER JOIN campeonato ON inscricao.campeonato_id = campeonato.campeonato_id
	INNER JOIN jogo ON campeonato.id_jogo = jogo.id_jogo;

CREATE TABLE partida (
	id_partida SERIAL PRIMARY KEY,
	data_partida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	rodada INT NOT NULL
);

-- mesma coisa de ir no CREATE TABLE inicialmente e colocar...
ALTER TABLE partida ADD COLUMN id_campeonato INT NOT NULL;
-- id_campeonato INT NOT NULL

-- exemplo de uso para o ALTER TABLE, mas mesma coisa de ir no CREATE TABLE...
ALTER TABLE partida ADD CONSTRAINT fk_partida_campeonato FOREIGN KEY (id_campeonato) REFERENCES campeonato(campeonato_id);
-- id_campeonato INT NOT NULL REFERENCES campeonato(campeonato_id)

INSERT INTO partida (data_partida, rodada, id_campeonato) VALUES ('2026-09-26', 1, 1)

SELECT * FROM partida

CREATE TABLE equipe_partida (
	id_equipe_partida SERIAL PRIMARY KEY,
	pontuacao INT DEFAULT 0,
	id_partida INT NOT NULL REFERENCES partida(id_partida),
	id_equipe INT NOT NULL REFERENCES equipe(id_equipe)
)
