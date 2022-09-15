
from fastapi import FastAPI

from database import conexion as connection


#creamos la app
app = FastAPI(title= 'PI 1 - Formula 1',
              description= 'proyecto individual numero 1',
              version= '1.0.1')


#ANIO CON MAS CARRERAS
@app.get('/anio')
async def index():
    cursor = connection.cursor()
    cursor.execute(" SELECT year, count(year) as 'cantidad carreras corridas en el anio' FROM races GROUP BY year ORDER BY count(year) DESC LIMIT 1;  ")
    for year in cursor:
        return ("El anio con mas carreras es", year[0] ,"y se corrieron", year[1] , "carreras")

    connection.close()

@app.get('/max')
async def index():
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(co.cant_carr) as 'cantidad maxima de carreras corridas en un anio' FROM (SELECT count(year) as cant_carr FROM races GROUP BY year) co;")
    for max in cursor:
        return (max[0], "Es la cantidad maxima de carreras corridas en un anio")

    connection.close()

@app.get('/carreras')
async def index():
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(gan.driver) as 'cantidad carreras ganadas', gan.driverId as piloto FROM (SELECT driverId, COUNT(driverId) as driver FROM results WHERE positionOrder='1' GROUP BY driverId) gan;")
    for cant in cursor:
        return ("El piloto ID numero", cant[1], "gano", cant[0], "carreras")

    connection.close()


@app.get('/piloto')
async def index():
    cursor = connection.cursor()
    cursor.execute("SELECT SUM(r.points), r.driverId, d.driverRef FROM results r JOIN drivers d ON (r.driverId=d.driverId) JOIN constructors c ON (c.constructorId=r.constructorId) GROUP BY r.driverId ORDER BY SUM(points) DESC LIMIT 1;")
    for piloto in cursor:
        return ("El piloto ", piloto[2], "sumo", piloto[0], "puntos")

    connection.close()
