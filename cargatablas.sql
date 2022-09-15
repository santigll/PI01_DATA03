use pi1_dts;

DROP TABLE IF EXISTS constructors;
CREATE TABLE IF NOT EXISTS constructors (
	`reference`						integer,
    constructorId					INTEGER,
	constructorRef					varchar(100),
	`name`							VARCHAR(50),
	nationality						VARCHAR(30),
    url								varchar(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\const.csv'
INTO TABLE `constructors`
character set 'latin1'
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

#CHARACTER SET 'LATIN1'

DROP TABLE IF EXISTS drivers;
CREATE TABLE IF NOT EXISTS drivers (
	unnamed                     integer,
    driverId 						integer,
	driverRef						VARCHAR(100),
    `code`   						varchar(50),
    nationality						varchar(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\driversNorm.csv"
INTO TABLE `drivers`
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"'
LINES TERMINATED BY '\n' IGNORE 1 LINES;

DROP TABLE IF EXISTS results;
CREATE TABLE IF NOT EXISTS results (
	unnamed 	                    integer,
    driverId 						integer,
	constructorId					integer,
	raceId						 	integer,
    positionOrder   				integer,
    points							integer
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\results_filtrados.csv"
INTO TABLE `results`
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"'
LINES TERMINATED BY '\n' IGNORE 1 LINES;

DROP TABLE IF EXISTS circuits;
CREATE TABLE IF NOT EXISTS circuits (
	`unnamed`                       integer,
    circuitId 						integer,
	`name`							varchar(50),
    `location`   					varchar(50),
    `country`						varchar(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\circuitsNorm.csv"
INTO TABLE `circuits`
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"'
LINES TERMINATED BY '\n' IGNORE 1 LINES;

#piloto cpn mayor cantidad de puntos y sea american o british
#La salida fue> Heidfield con 27.554 puntos

SELECT sum(r.points), r.driverId, d.driverRef
FROM results r
JOIN drivers d
ON (r.driverId=d.driverId)
JOIN constructors c
ON (c.constructorId=r.constructorId)
GROUP BY r.driverId and c.nationality="British" or c.nationality="American"
ORDER BY SUM(points) DESC
limit 1;

#Piloto con mayor cantidad de primeros puestos
SELECT MAX(gan.driver) as 'cantidad carreras ganadas', gan.driverId as piloto FROM 
       (SELECT driverId, COUNT(driverId) as driver
       FROM results
       WHERE positionOrder='1'
       GROUP BY driverId) gan;


#Esta es la otra Query
#Aca va la 3ra>


SELECT MAX(co.cant_carr) as 'cantidad maxima de carreras corridas en un anio' FROM 
   (SELECT count(year) as cant_carr 
    FROM races
    GROUP BY year) co;


#Aca va la 4ta Query>


SELECT year, count(year) as 'cantidad carreras corridas en el anio'
FROM races
GROUP BY year
ORDER BY count(year) DESC
LIMIT 1;











