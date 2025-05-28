-- Asegurate de tener esta tabla creada en tu base de datos:

CREATE TABLE log_carga (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origen VARCHAR(50),
    archivo VARCHAR(255),
    cantidad INT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE log_limpieza (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origen VARCHAR(50),
    archivo VARCHAR(255),
    cantidad INT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    detalles TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE core_twitch_games (
    id BIGINT,
    name VARCHAR(255),
    box_art_url TEXT,
    igdb_id BIGINT,
    total_viewers INT,                    
    num_streams INT,                     
    avg_viewers FLOAT,                   
    languages VARCHAR(500),                     
    has_mature_stream TINYINT(1) DEFAULT 0 NOT NULL,            
    dw_fecha_registro DATETIME,
    dw_id_carga INT,
    dw_deleted TINYINT(1) DEFAULT 0 NOT NULL,
    dw_source VARCHAR(50),
    dw_endpoint TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE core_howlongtobeat (
    game_id BIGINT,
    game_name VARCHAR(255),
    review_score INT,
    release_year INT,
    main_story FLOAT,
    main_extra FLOAT,
    completionist FLOAT,
    all_styles FLOAT,
    coop_time FLOAT,
    mp_time FLOAT,
    dw_fecha_registro DATETIME,
    dw_id_carga INT,
    dw_deleted TINYINT(1) DEFAULT 0 NOT NULL,
    dw_source VARCHAR(50),
    dw_endpoint TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE core_pokedex (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    num INT,
    heightm FLOAT,
    weightkg FLOAT,
    color VARCHAR(30),
    prevo VARCHAR(100),
    evo VARCHAR(100),
    evoType VARCHAR(30),
    canGigantamax VARCHAR(100),
    type_1 VARCHAR(30),
    type_2 VARCHAR(30),
    hp INT,
    atk INT,
    def INT,
    spa INT,
    spd INT,
    spe INT,
    ability_0 VARCHAR(100),
    ability_1 VARCHAR(100),
    ability_H VARCHAR(100),
    dw_fecha_registro DATETIME,
    dw_id_carga INT,
    dw_deleted TINYINT(1) DEFAULT 0 NOT NULL,
    dw_source VARCHAR(50),
    dw_endpoint TEXT
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


-- ALTER TABLE core_twitch_games CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- ALTER TABLE core_howlongtobeat CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- ALTER TABLE core_pokemon_showdown CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- ALTER TABLE log_carga CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- ALTER TABLE log_limpieza CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


-- delete from core_twitch_games;
-- delete from log_limpieza;