# LATAM AIRLINES CHALLENGE #

Este documento README tiene el proposito de documentar la solución de cada parte del desafío a entregar maximo el dia lunes 1 de julio.

### Parte 1:Infraestructura e IaC ###

* 1. Identificar la infraestructura necesaria para ingestar, almacenar y exponer datos:
a. Utilizar el esquema Pub/Sub (no confundir con servicio Pub/Sub de Google)
para ingesta de datos
b. Base de datos para el almacenamiento enfocado en analítica de datos
c. Endpoint HTTP para servir parte de los datos almacenados

Este documento README tiene el proposito de documentar la solución de cada parte del desafío a entregar maximo el dia lunes 1 de julio.



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
    
Las fuentes de datos publican mensajes a los temas configurados en el sistema Pub/Sub.

2.  **Almacenamiento de Datos**:
    
La base de datos de análisis recibe y almacena los datos transformados, manteniéndolos listos para consultas y análisis rápidos.

3.  **Exposición de Datos**:
    
La API extrae los datos de la base de datos de análisis conforme a las solicitudes de los usuarios y devuelve los resultados a través de endpoints HTTP.
La autenticación y las políticas de seguridad en IAM garantizan que solo los usuarios autorizados puedan acceder a los datos.



2. (Opcional) Deployar infraestructura mediante Terraform de la manera que más te
acomode. Incluir código fuente Terraform. No requiere pipeline CI/CD.

Se agrega la carpeta ./infraestructura con los archivos en terraform

### Parte 2: Aplicaciones y flujo CI/CD ###



### Parte 3: Pruebas de Integración y Puntos Críticos de Calidad ###



### Parte 4: Métricas y Monitoreo ###

