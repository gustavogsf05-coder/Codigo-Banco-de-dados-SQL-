-- CONSULTAS.sql

-- 1ª Consulta
SELECT 
    musicas.titulo AS musica,
    musicas.duracao_segundos,
    musicas.ano_lancamento,
    albuns.titulo AS album
FROM musicas
JOIN albuns ON musicas.album_id = albuns.id_albuns
WHERE albuns.titulo = 'Divide'
ORDER BY musicas.duracao_segundos DESC;

-- 2ª Consulta
SELECT 
    artistas.nome_real AS artista,
    COUNT(musicas.id_musicas) AS total_musicas
FROM artistas
JOIN musicas_artistas ON artistas.id_artistas = musicas_artistas.artista_id
JOIN musicas ON musicas_artistas.musica_id = musicas.id_musicas
GROUP BY artistas.nome_real
ORDER BY total_musicas DESC;

-- 3ª Consulta
SELECT 
    p.id_playlists,
    p.nome AS playlist,
    (
        (SELECT SUM(m.duracao_segundos)
         FROM playlists_tem_musicas pm
         JOIN musicas m ON pm.musica_id = m.id_musicas
         WHERE pm.playlist_id = p.id_playlists)
        +
        (SELECT SUM(ep.duracao_segundos)
         FROM playlists_tem_episodios pe
         JOIN episodios ep ON pe.episodio_id = ep.id_episodios
         WHERE pe.playlist_id = p.id_playlists)
    ) AS duracao_total
FROM playlists p
WHERE (
        (SELECT SUM(m.duracao_segundos)
         FROM playlists_tem_musicas pm
         JOIN musicas m ON pm.musica_id = m.id_musicas
         WHERE pm.playlist_id = p.id_playlists)
        +
        (SELECT SUM(ep.duracao_segundos)
         FROM playlists_tem_episodios pe
         JOIN episodios ep ON pe.episodio_id = ep.id_episodios
         WHERE pe.playlist_id = p.id_playlists)
    ) > 3600
ORDER BY duracao_total DESC;
