# Usar una imagen base oficial de Python
FROM python:3.10-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el archivo requirements.txt al contenedor y instalar dependencias
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copiar los archivos necesarios al contenedor
COPY . .


ARG SECRET_KEY
ENV GOOGLE_APPLICATION_CREDENTIALS_JSON=$SECRET_KEY
# Establecer variables de entorno
ENV FLASK_APP=app.py
ENV FLASK_ENV=development

# Arrancar la aplicación Flask escuchando en el puerto proporcionado por Cloud Run
CMD ["sh", "-c", "flask run --host=0.0.0.0 --port=${PORT:-5000}"]
