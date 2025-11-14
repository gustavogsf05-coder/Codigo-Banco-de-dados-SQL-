-- 1ª Consulta 
SELECT 
    a.nome_real AS artista,
    al.titulo AS album,
    al.data_lancamento
FROM artistas a
JOIN artistas_lancam_albuns ala ON ala.artista_id = a.id_artistas
JOIN albuns al ON al.id_albuns = ala.album_id
WHERE al.data_lancamento IS NOT NULL
ORDER BY a.nome_real, al.data_lancamento;


-- 2ª Consulta 
SELECT
    a.nome_real AS artista,
    COUNT(m.id_musicas) AS total_musicas
FROM artistas a
JOIN musicas_artistas ma ON ma.artista_id = a.id_artistas
JOIN musicas m ON m.id_musicas = ma.musica_id
GROUP BY a.nome_real
ORDER BY total_musicas DESC;



-- 3ª Consulta
SELECT 
    DISTINCT p.nome AS playlist,
    u.nome_completo AS dono,
    a.nome_real AS artista,
    m.titulo AS musica
FROM playlists p
JOIN usuarios u ON u.id_usuarios = p.usuario_id
JOIN playlists_tem_musicas ptm ON ptm.playlist_id = p.id_playlists
JOIN musicas m ON m.id_musicas = ptm.musica_id
JOIN musicas_artistas ma ON ma.musica_id = m.id_musicas
JOIN artistas a ON a.id_artistas = ma.artista_id
WHERE a.id_artistas = (
    SELECT id_artistas 
    FROM artistas 
    WHERE nome_real = 'Edward Christopher Sheeran'
)
ORDER BY playlist, musica;
