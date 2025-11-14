-- INSERTS.sql
-- Inserção de dados
-- 1. Tabelas independentes
INSERT INTO usuarios (nome_completo, email, data_nascimento, pais) VALUES
('Ana Silva', 'ana.silva@email.com', '1995-03-15', 'Brasil'),
('Bruno Costa', 'bruno.c@email.com', '2000-07-22', 'Portugal'),
('Carla Dias', 'carla.dias@email.com', '1998-11-02', 'Brasil'),
('Daniel Moreira', 'daniel.m@email.com', '2002-01-30', 'Brasil'),
('Elisa Fernandes', 'elisa.f@email.com', '1999-05-10', 'Angola');

INSERT INTO gravadoras (nome, pais_sede) VALUES
('Som Livre', 'Brasil'),
('Universal Music', 'EUA'),
('Sony Music', 'EUA'),
('Warner Music', 'EUA'),
('Independente', NULL);

INSERT INTO artistas (nome_real, pais_origem) VALUES
('Edward Christopher Sheeran', 'Reino Unido'),
('Anitta', 'Brasil'),
('Milton Nascimento', 'Brasil'),
('Aubrey Drake Graham', 'Canadá'),
('Taylor Alison Swift', 'EUA'),
('Paulo Carvalho', 'Brasil'),
('Jovem Nerd', 'Brasil');

-- 2. Especializações (dependem de artistas)
INSERT INTO musicos (artista_id, nome_artistico) VALUES
(1, 'Ed Sheeran'),
(2, 'Anitta'),
(3, 'Milton Nascimento'),
(4, 'Drake'),
(5, 'Taylor Swift');

INSERT INTO compositores (artista_id, registro_autoral) VALUES
(1, 'REG12345UK'),
(2, 'REG67890BR'),
(3, 'REG11121BR'),
(5, 'REG55544US');

INSERT INTO podcasters (nome_programa, artista_id) VALUES
('Flow Podcast', 6),
('NerdCast', 7),
('Mamilos', 2),
('Podpah', 4),
('Um Milkshake Chamado Wanda', 1);

-- 3. Conteúdo (dependem das anteriores)
INSERT INTO albuns (titulo, data_lancamento, gravadora_id) VALUES
('Divide', '2017-03-03', 4),
('Kisses', '2019-04-05', 4),
('Clube da Esquina', '1972-01-01', 1),
('Midnights', '2022-10-21', 2),
('Views', '2016-04-29', 2);

INSERT INTO podcasts (titulo, descricao, data_lancamento, podcaster_id) VALUES
('NerdCast', 'Cultura pop, ciência e história', '2006-04-01', 2),
('Flow Podcast', 'Conversas longas e livres', '2018-09-01', 1),
('Mamilos', 'Jornalismo de peito aberto', '2014-07-01', 3),
('Podpah', 'O podcast mais zika da internet', '2020-01-01', 4),
('Um Milkshake Chamado Wanda', 'Podcast sobre cultura pop', '2015-01-01', 5);

INSERT INTO musicas (titulo, duracao_segundos, ano_lancamento, genero, album_id) VALUES
('Shape of You', 234, 2017, 'Pop', 1),
('Perfect', 263, 2017, 'Pop', 1),
('O Trem Azul', 245, 1972, 'MPB', 3),
('Cais', 198, 1972, 'MPB', 3),
('Anti-Hero', 200, 2022, 'Pop', 4),
('Lavender Haze', 202, 2022, 'Pop', 4),
('One Dance', 174, 2016, 'Dancehall', 5),
('Hotline Bling', 267, 2016, 'R&B', 5),
('Banana', 195, 2019, 'Funk', 2),
('Onda Diferente', 170, 2019, 'Funk', 2);

INSERT INTO episodios (titulo, descricao, duracao_segundos, data_lancamento, podcast_id) VALUES
('NerdCast 880: O Exorcista', 'Discussão sobre o filme clássico', 3600, '2023-10-06', 1),
('NerdCast 879: Duna', 'Análise do universo de Duna', 4200, '2023-10-01', 1),
('Flow 500: Igor e Monark', 'Episódio especial', 7200, '2022-01-01', 2),
('Mamilos 300: Saúde Mental', 'Debate sobre bem-estar', 3000, '2023-05-01', 3),
('Podpah 100: Racionais MCs', 'Entrevista com a banda', 10800, '2021-01-01', 4);

-- 4. Relacionamentos de Usuário
INSERT INTO enderecos (rua, cidade, cep, usuario_id) VALUES
('Rua das Flores, 123', 'São Paulo', '01000-000', 1),
('Av. da Liberdade, 456', 'Lisboa', '1250-142', 2),
('Rua das Palmeiras, 789', 'Rio de Janeiro', '20000-000', 3),
('Av. Paulista, 1000', 'São Paulo', '01311-100', 4),
('Rua dos Coqueiros, 50', 'Luanda', '1000-000', 5);

INSERT INTO playlists (nome, usuario_id) VALUES
('Melhores do Pop', 1),
('MPB para relaxar', 3),
('Funk 2020', 1),
('Correndo', 4),
('Favoritas da Taylor', 5),
('NerdCasts TOP', 4);

-- 5. Tabelas de Ligação N:M
INSERT INTO artistas_lancam_albuns (artista_id, album_id) VALUES
(1, 1), (2, 2), (3, 3), (5, 4), (4, 5);

INSERT INTO musicas_artistas (musica_id, artista_id) VALUES
(1, 1), (2, 1), (3, 3), (4, 3), (5, 5), (6, 5), (7, 4), (8, 4), (9, 2), (10, 2);

INSERT INTO playlists_tem_musicas (playlist_id, musica_id, data_adicao) VALUES
(1, 1, '2023-01-10 10:00:00'),
(1, 5, '2023-01-11 11:00:00'),
(1, 9, '2023-01-12 12:00:00'),
(2, 3, '2023-02-01 15:00:00'),
(2, 4, '2023-02-02 16:00:00'),
(5, 5, '2023-03-01 09:00:00'),
(5, 6, '2023-03-01 09:05:00');

INSERT INTO playlists_tem_episodios (playlist_id, episodio_id, data_adicao) VALUES
(6, 1, '2023-10-07 08:00:00'),
(6, 2, '2023-10-07 08:00:00'),
(4, 3, '2022-02-01 18:00:00'),
(4, 5, '2021-03-01 19:00:00');

-- 6. Tabelas de Log
INSERT INTO usuarios_ouvem_musicas (usuario_id, musica_id, data_hora_play) VALUES
(1, 1, '2023-10-29 10:00:00'),
(1, 1, '2023-10-29 10:05:00'),
(1, 5, '2023-10-29 10:10:00'),
(2, 7, '2023-10-28 12:00:00'),
(3, 3, '2023-10-27 20:00:00'),
(3, 4, '2023-10-27 20:05:00');

INSERT INTO usuarios_ouvem_episodios (usuario_id, episodio_id, data_hora_play) VALUES
(4, 1, '2023-10-29 07:00:00'),
(4, 2, '2023-10-28 07:00:00'),
(1, 3, '2023-10-27 15:00:00'),
(2, 4, '2023-10-26 18:00:00'),
(5, 5, '2023-10-25 19:00:00');
