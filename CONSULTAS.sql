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
    p.nome AS playlist,
    u.nome_completo AS dono,
    (
        SELECT COUNT(*)
        FROM playlists_tem_musicas ptm
        WHERE ptm.playlist_id = p.id_playlists
    ) AS total_musicas
FROM playlists p
JOIN usuarios u ON u.id_usuarios = p.usuario_id
WHERE (
        SELECT COUNT(*)
        FROM playlists_tem_musicas ptm
        WHERE ptm.playlist_id = p.id_playlists
      ) > 2   -- filtro complexo (playlists com mais de 2 músicas)
ORDER BY total_musicas DESC;
