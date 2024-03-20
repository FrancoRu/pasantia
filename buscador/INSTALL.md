# Instrucciones de Instalación

Este archivo proporciona instrucciones detalladas sobre cómo instalar y configurar el proyecto "Buscador de Cuadros 2010 - 2022".

## Requisitos Previos

- PHP >= 8.0
- MySQL >= 5.7
- [Composer](https://getcomposer.org/) (para instalar dependencias)
  
## Pasos de Instalación

1. **Clonar el Repositorio**
   - https://github.com/FrancoRu/pasantia

2. **Configurar la Base de Datos**
- Crear una nueva base de datos MySQL.
- Importar el archivo `lab.sql` ubicado en la carpeta `BD/` en la base de datos recién creada.

3. **Crear el Archivo de Variables de Entorno .env**
- Crea un nuevo archivo llamado `.env` en la raíz del proyecto.
- Dentro del archivo `.env`, crea las variables necesarias:
  ```
  MYSQL_SERVER=tu_servidor_mysql
  MYSQL_USERNAME=tu_usuario_mysql
  MYSQL_PASSWORD=tu_contraseña_mysql
  MYSQL_DATABASE=tu_base_de_datos_mysql
  ```

4. **Instalar las Dependencias y Librerías**
- Abre una terminal en la raíz del proyecto y ejecuta el siguiente comando:
  ```
  composer install
  ```

5. **Acceder al Buscador**
- Abre un navegador web e ingresa la URL del proyecto.

## Solución de Problemas

- Si encuentras algún problema durante la instalación, contáctanos para obtener ayuda.

¡El proyecto "Buscador de Cuadros 2010 - 2022" ahora está listo para ser utilizado!

