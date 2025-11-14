DROP TABLE IF EXISTS usuarios_ouvem_episodios CASCADE;
DROP TABLE IF EXISTS usuarios_ouvem_musicas CASCADE;
DROP TABLE IF EXISTS playlists_tem_episodios CASCADE;
DROP TABLE IF EXISTS playlists_tem_musicas CASCADE;
DROP TABLE IF EXISTS musicas_artistas CASCADE;
DROP TABLE IF EXISTS artistas_lancam_albuns CASCADE;
DROP TABLE IF EXISTS playlists CASCADE;
DROP TABLE IF EXISTS enderecos CASCADE;
DROP TABLE IF EXISTS episodios CASCADE;
DROP TABLE IF EXISTS podcasts CASCADE;
DROP TABLE IF EXISTS musicas CASCADE;
DROP TABLE IF EXISTS albuns CASCADE;
DROP TABLE IF EXISTS podcasters CASCADE;
DROP TABLE IF EXISTS compositores CASCADE;
DROP TABLE IF EXISTS musicos CASCADE;
DROP TABLE IF EXISTS artistas CASCADE;
DROP TABLE IF EXISTS gravadoras CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;


-- 1. Tabelas Principais
CREATE TABLE usuarios (
    id_usuarios SERIAL PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    pais VARCHAR(100)
);

CREATE TABLE gravadoras (
    id_gravadoras SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL UNIQUE,
    pais_sede VARCHAR(100)
);

CREATE TABLE artistas (
    id_artistas SERIAL PRIMARY KEY,
    nome_real VARCHAR(255) NOT NULL,
    pais_origem VARCHAR(100)
);

-- 2. Tabelas de Especialização (Subclasses de Artista)
CREATE TABLE musicos (
    artista_id INT PRIMARY KEY,
    nome_artistico VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE compositores (
    artista_id INT PRIMARY KEY,
    registro_autoral VARCHAR(100) UNIQUE
);

CREATE TABLE podcasters (
    id_podcasters SERIAL PRIMARY KEY,
    nome_programa VARCHAR(200) NOT NULL,
    artista_id INT NOT NULL
);

-- 3. Tabelas de Conteúdo
CREATE TABLE albuns (
    id_albuns SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    data_lancamento DATE,
    gravadora_id INT
);

CREATE TABLE musicas (
    id_musicas SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    duracao_segundos INT NOT NULL CHECK (duracao_segundos > 0),
    ano_lancamento INT,
    genero VARCHAR(100),
    album_id INT NOT NULL
);

CREATE TABLE podcasts (
    id_podcasts SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_lancamento DATE,
    podcaster_id INT NOT NULL
);

CREATE TABLE episodios (
    id_episodios SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT,
    duracao_segundos INT NOT NULL CHECK (duracao_segundos > 0),
    data_lancamento DATE,
    podcast_id INT NOT NULL
);

-- 4. Tabelas de Usuário
CREATE TABLE enderecos (
    id_enderecos SERIAL PRIMARY KEY,
    rua VARCHAR(255),
    cidade VARCHAR(100),
    cep VARCHAR(20),
    usuario_id INT NOT NULL UNIQUE
);

CREATE TABLE playlists (
    id_playlists SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INT NOT NULL
);

-- 5. Tabelas de Relacionamentos N:N
CREATE TABLE artistas_lancam_albuns (
    artista_id INT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (artista_id, album_id)
);

CREATE TABLE musicas_artistas (
    musica_id INT NOT NULL,
    artista_id INT NOT NULL,
    PRIMARY KEY (musica_id, artista_id)
);

CREATE TABLE playlists_tem_musicas (
    playlist_id INT NOT NULL,
    musica_id INT NOT NULL,
    data_adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, musica_id)
);

CREATE TABLE playlists_tem_episodios (
    playlist_id INT NOT NULL,
    episodio_id INT NOT NULL,
    data_adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, episodio_id)
);

-- 6. Tabelas de Histórico
CREATE TABLE usuarios_ouvem_musicas (
    usuario_id INT NOT NULL,
    musica_id INT NOT NULL,
    data_hora_play TIMESTAMP NOT NULL,
    PRIMARY KEY (usuario_id, musica_id, data_hora_play)
);

CREATE TABLE usuarios_ouvem_episodios (
    usuario_id INT NOT NULL,
    episodio_id INT NOT NULL,
    data_hora_play TIMESTAMP NOT NULL,
    PRIMARY KEY (usuario_id, episodio_id, data_hora_play)
);

-- Seção 2: Criação das Chaves Estrangeiras 


ALTER TABLE musicos 
    ADD CONSTRAINT fk_musicos_artista 
    FOREIGN KEY (artista_id) REFERENCES artistas(id_artistas);

ALTER TABLE compositores 
    ADD CONSTRAINT fk_compositores_artista 
    FOREIGN KEY (artista_id) REFERENCES artistas(id_artistas);

ALTER TABLE podcasters 
    ADD CONSTRAINT fk_podcasters_artista 
    FOREIGN KEY (artista_id) REFERENCES artistas(id_artistas);

-- 2. Conteúdo
ALTER TABLE albuns 
    ADD CONSTRAINT fk_albuns_gravadora 
    FOREIGN KEY (gravadora_id) REFERENCES gravadoras(id_gravadoras);

ALTER TABLE musicas 
    ADD CONSTRAINT fk_musicas_album 
    FOREIGN KEY (album_id) REFERENCES albuns(id_albuns);

ALTER TABLE podcasts 
    ADD CONSTRAINT fk_podcasts_podcaster 
    FOREIGN KEY (podcaster_id) REFERENCES podcasters(id_podcasters);

ALTER TABLE episodios 
    ADD CONSTRAINT fk_episodios_podcast 
    FOREIGN KEY (podcast_id) REFERENCES podcasts(id_podcasts);

-- 3. Usuários
ALTER TABLE enderecos 
    ADD CONSTRAINT fk_enderecos_usuario 
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuarios);

ALTER TABLE playlists 
    ADD CONSTRAINT fk_playlists_usuario 
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuarios);

-- 4. Relacionamentos N:N
ALTER TABLE artistas_lancam_albuns 
    ADD CONSTRAINT fk_ala_artista 
    FOREIGN KEY (artista_id) REFERENCES artistas(id_artistas);

ALTER TABLE artistas_lancam_albuns 
    ADD CONSTRAINT fk_ala_album 
    FOREIGN KEY (album_id) REFERENCES albuns(id_albuns);

ALTER TABLE musicas_artistas 
    ADD CONSTRAINT fk_ma_musica 
    FOREIGN KEY (musica_id) REFERENCES musicas(id_musicas);

ALTER TABLE musicas_artistas 
    ADD CONSTRAINT fk_ma_artista 
    FOREIGN KEY (artista_id) REFERENCES artistas(id_artistas);

ALTER TABLE playlists_tem_musicas 
    ADD CONSTRAINT fk_ptm_playlist 
    FOREIGN KEY (playlist_id) REFERENCES playlists(id_playlists);

ALTER TABLE playlists_tem_musicas 
    ADD CONSTRAINT fk_ptm_musica 
    FOREIGN KEY (musica_id) REFERENCES musicas(id_musicas);

ALTER TABLE playlists_tem_episodios 
    ADD CONSTRAINT fk_pte_playlist 
    FOREIGN KEY (playlist_id) REFERENCES playlists(id_playlists);

ALTER TABLE playlists_tem_episodios 
    ADD CONSTRAINT fk_pte_episodio 
    FOREIGN KEY (episodio_id) REFERENCES episodios(id_episodios);

-- 5. Histórico
ALTER TABLE usuarios_ouvem_musicas 
    ADD CONSTRAINT fk_uom_usuario 
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuarios);

ALTER TABLE usuarios_ouvem_musicas 
    ADD CONSTRAINT fk_uom_musica 
    FOREIGN KEY (musica_id) REFERENCES musicas(id_musicas);

ALTER TABLE usuarios_ouvem_episodios 
    ADD CONSTRAINT fk_uoe_usuario 
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuarios);

ALTER TABLE usuarios_ouvem_episodios 
    ADD CONSTRAINT fk_uoe_episodio 
    FOREIGN KEY (episodio_id) REFERENCES episodios(id_episodios);
