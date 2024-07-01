# LATAM AIRLINES CHALLENGE #

Este documento README tiene el proposito de documentar la solución de cada parte del desafío a entregar maximo el dia lunes 1 de julio.

### Parte 1:Infraestructura e IaC ###

1. Identificar la infraestructura necesaria para ingestar, almacenar y exponer datos:
a. Utilizar el esquema Pub/Sub (no confundir con servicio Pub/Sub de Google)
para ingesta de datos
b. Base de datos para el almacenamiento enfocado en analítica de datos
c. Endpoint HTTP para servir parte de los datos almacenados


**Solución**

Teniendo en cuenta el esquema Pub/Sub proponemos los siguientes servicios en la nube GCP para abordar el desafio

1.  **Pub/Sub**:
    
 Este es el servicio que va a recibir datos de múltiples fuentes, como aplicaciones, sensores, o sistemas en línea, y distribuir esos datos a varios consumidores, en este caso, a un sistema de procesamiento de datos.

2.  **Base de Datos de Análisis - Big Query**:
    
Esta base de datos de GCP permite almacenar grandes volúmenes de datos en un formato optimizado para análisis de datos.

3.  **API para Exposición de Datos - Cloud Run**:
    
Cloud Run es una plataforma que permite ejecutar contenedores en un entorno completamente gestionado, lo que lo hace ideal para aplicaciones basadas en microservicios o APIs que necesitan escalar automáticamente según la demanda.

4.  **Autenticación y Seguridad - IAM(Service Account)**:
    
Este servicio es para poder autenticar entre servicios con los roles adecuados de acuerdo a la funcion que realizaran.

### Conexión y Flujo de Datos

1.  **Ingesta de Datos**:
    
Las fuentes de datos publican mensajes a los temas(topics) configurados en el sistema Pub/Sub.

2.  **Almacenamiento de Datos**:
    
La base de datos de análisis recibe y almacena los datos transformados, manteniéndolos listos para consultas y análisis rápidos.

3.  **Exposición de Datos**:
    
La API extrae los datos de la base de datos de análisis conforme a las solicitudes de los usuarios y devuelve los resultados a través de endpoints HTTP.
La autenticación y las políticas de seguridad en IAM garantizan que solo los usuarios autorizados puedan acceder a los datos.



2. (Opcional) Deployar infraestructura mediante Terraform de la manera que más te
acomode. Incluir código fuente Terraform. No requiere pipeline CI/CD.

**Solución**

Se agrega la carpeta ./infraestructura con los archivos en terraform

### Parte 2: Aplicaciones y flujo CI/CD ###

1. API HTTP: Levantar un endpoint HTTP con lógica que lea datos de base de datos y
los exponga al recibir una petición GET

**Solución**

Se levanta un endpoint con python y flask de framework, el codigo se encuentra en ./app.py, lo que hace la aplicacion es leer
una tabla en el dataset de bigquery, latam-challenge, que se creo con terraform en la parte anterior.
Se agrega inicialmente un registro de datos para verificar la exposicion de datos.
Se genera el dockerfile para poder verificar el endpoint con postman primero localmente, luego se sube a la nube, para ello 
se hace uso de Cloud Run Service, previamente la imagen generada se sube al repositorio (us-central1-docker.pkg.dev/latam-challenge-427922/latam-challenge)


2. Deployar API HTTP en la nube mediante CI/CD a tu elección. Flujo CI/CD y
ejecuciones deben estar visibles en el repositorio git.



3. (Opcional) Ingesta: Agregar suscripción al sistema Pub/Sub con lógica para ingresar
los datos recibidos a la base de datos. El objetivo es que los mensajes recibidos en
un tópico se guarden en la base de datos. No requiere CI/CD.
4. Incluye un diagrama de arquitectura con la infraestructura del punto 1.1 y su
interacción con los servicios/aplicaciones que demuestra el proceso end-to-end de
ingesta hasta el consumo por la API HTTP
Comentarios:
- Recomendamos usar un servicio serverless mediante Dockerfile para optimizar el tiempo de
desarrollo y deployment para la API HTTP
- Es posible que lógica de ingesta se incluya nativamente por tu servicio en la nube. De ser así,
solo comentar cómo funciona
- Al ser 1.3 opcional, el flujo de ingesta de datos quedará incompleto, está bien
- Para el punto 1.4 no se requiere

### Parte 3: Pruebas de Integración y Puntos Críticos de Calidad ###



### Parte 4: Métricas y Monitoreo ###

