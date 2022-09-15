from peewee import *
import pymysql

conexion = pymysql.connect(
                host='localhost', 
                database='pi1_dts', 
                user ='root', 
                password='Laprida206'
)
