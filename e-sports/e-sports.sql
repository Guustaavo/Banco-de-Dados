CREATE TABLE jogador (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE perfil (
	id SERIAL PRIMARY KEY,
	nickname VARCHAR (50),
	ranking INTEGER,
	descricao TEXT,
	id_jogador INT NOT NULL UNIQUE REFERENCES jogador(id)
);


CREATE TABLE equipe (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	sigla VARCHAR(3) NOT NULL
);


INSERT INTO jogador (nome, email) VALUES ('Enzo', 'enzomaisaura@gmail.com'), ('Gus', 'winner@gmail.com');
INSERT INTO perfil(nickname, ranking, descricao, id_jogador) VALUES ('reidelas', 2, 'Farmador de aura.', 1);
INSERT INTO equipe (nome, sigla) VALUES ('FURIA', 'FUR');


ALTER TABLE jogador ADD COLUMN id_equipe INT;
ALTER TABLE jogador ADD CONSTRAINT fk_jogador_equipe FOREIGN KEY (id_equipe) REFERENCES equipe(id);


UPDATE jogador SET id_equipe = 2 WHERE id = 1;
UPDATE jogador SET nome = 'Gustavo' WHERE id = 3;


DELETE FROM jogador WHERE id = 2;


SELECT * FROM jogador
	LEFT JOIN perfil ON jogador.id = perfil.id_jogador
	LEFT JOIN equipe ON jogador.id_equipe = equipe.id
SELECT * FROM perfil;
SELECT * FROM equipe;