# Proyecto de Análisis y Visualización de Datos de Videojuegos

Este proyecto realiza la descarga, limpieza y análisis de datos de videojuegos desde fuentes externas, utilizando PySpark, MySQL y Power BI. Está organizado en fases claramente diferenciadas para facilitar su seguimiento y despliegue.

---

## Requisitos Previos

Antes de comenzar, asegúrate de tener lo siguiente instalado:

* Docker Desktop
* Power BI Desktop
* Python 3.8 o superior (opcional, si usas scripts locales)
* Conexión a internet para descargar imágenes
* Conector ODBC de MySQL

---

## Estructura del Proyecto

El flujo de trabajo se divide en tres fases principales:

### Fase 1: Descarga y Almacenamiento de Datos Crudos

* Se extraen datos de las siguientes fuentes:

  * HowLongToBeat API
  * Twitch API
  * Pokémon Showdown (`pokedex.ts`)
* Los datos se almacenan en formato `.parquet`.
* Se registra cada operación en la tabla `log_carga` de MySQL.

### Fase 2: Limpieza y Transformación de Datos

* Se procesan los archivos `.parquet`:

  * Eliminación de duplicados y nulos
  * Normalización de nombres y campos
  * Enriquecimiento con campos técnicos (`dw_*`)
* Se escriben en la base de datos MySQL en tablas `core_*`.
* Se registra la operación en la tabla `log_limpieza`.

### Fase 3: Visualización en Power BI

* Se conecta Power BI a la base de datos MySQL mediante ODBC.
* Se construyen dashboards para cada fuente, con comparativas y análisis cruzados.
* Se incluyen KPIs específicos por cada dataset.

---

## Herramientas Utilizadas

* PySpark
* MySQL
* Docker
* Power BI
* Python (con Pandas, Requests, etc.)
* Jupyter Notebooks (imagen oficial de Spark)

---

## Estructura de Carpetas

```bash
docker/
└── pyspark/
    ├── fase1.ipynb
    ├── fase2.ipynb
    ├── mysql-connector-j-8.0.31.jar
    ├── .env
    └── ...
```

Ruta base esperada:
`C:\Users\<usuario>\Documents\docker\pyspark`

**Importante:** Esta ruta es crítica porque el contenedor Spark montará exactamente esta carpeta como volumen interno. Si modificas la ubicación, asegúrate también de modificar el parámetro `-v` del comando `docker run`. Si no se respeta esta estructura, el contenedor no podrá acceder a los notebooks ni al resto de archivos.

---

## Configuración del Contenedor Spark

### Lanzar contenedor con Jupyter y PySpark

```bash
docker run -p 8888:8888 -v C:\Users\<usuario>\Documents\docker\pyspark:/home/jovyan/work jupyter/pyspark-notebook
```

Este comando:

* Lanza un entorno de Jupyter con PySpark preinstalado
* Monta la carpeta local `docker/pyspark` dentro del contenedor como `/home/jovyan/work`
* Permite acceder a los notebooks desde el navegador en el puerto 8888

Acceso:
`http://127.0.0.1:8888/?token=<TOKEN>`

---

## Variables de Entorno (.env)

```env
MYSQL_HOST=host.docker.internal
MYSQL_PORT=3307
MYSQL_USER=root
MYSQL_PASSWORD=Qwe_1234
MYSQL_DATABASE=videojuegos

TWITCH_CLIENT_ID=
TWITCH_CLIENT_SECRET=
TWITCH_TOKEN=
```

---

## Contenedor MySQL (Docker Compose)

```yaml
mysql:
  image: mysql:5.6
  container_name: etl-mysql
  volumes:
    - ./Data/mysql:/var/lib/mysql
  ports:
    - "3307:3306"
  environment:
    TZ: Europe/Madrid
    MYSQL_ROOT_PASSWORD: Qwe_1234
```

Conexión desde Power BI o Spark:

* Host: `localhost`
* Puerto: `3307`
* Usuario: `root`
* Contraseña: `Qwe_1234`
* Base de datos: `videojuegos`

---

## APIs Utilizadas

* HowLongToBeat (web scraping vía Python)
* Twitch API (helix endpoints)
* Pokémon Showdown (archivo .ts de Pokedex)

---

## Visualización en Power BI

Pasos recomendados:

1. Instalar el conector ODBC de MySQL:
   [https://dev.mysql.com/downloads/connector/odbc/](https://dev.mysql.com/downloads/connector/odbc/)

2. En Power BI:

   * Obtener datos > MySQL
   * Servidor: `localhost:3307`
   * Base de datos: `videojuegos`
   * Usuario: `root`
   * Contraseña: `Qwe_1234`
   * Modo: Importar (recomendado)

3. Cargar las tablas `core_*` correspondientes.

4. Construir dashboards con KPIs definidos:

| Fuente        | KPIs principales                                |
| ------------- | ----------------------------------------------- |
| HowLongToBeat | Duración principal, plataformas, review\_score  |
| Twitch        | Viewers totales, idiomas, contenido +18         |
| Pokémon       | Stats promedio, habilidades, tipos, evoluciones |

---

## Validación

* La tabla `log_carga` registra todas las cargas crudas
* La tabla `log_limpieza` indica si los datos fueron limpiados correctamente
* Las tablas `core_*` contienen datos listos para análisis
* Power BI presenta filtros funcionales y medidas dinámicas

---

## Notas Finales

* Puedes modificar los notebooks según tus necesidades
* Asegúrate de que las rutas del volumen y los nombres de archivo coincidan
* Los dashboards están diseñados para soportar filtrado cruzado entre fuentes
* Si cambias la estructura de carpetas, recuerda actualizar el volumen en el `docker run` y cualquier ruta en el código