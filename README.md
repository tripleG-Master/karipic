# Karipic

## Instalación

Sigue estos pasos para configurar el proyecto en tu máquina local:

1. Clona el repositorio de GitHub.
   - git clone https://github.com/tripleG-Master/karipic.git

2. Dentro de la carpeta raiz del proyecto busca el archivo <code>config/database.yml</code> y editalo con tus parametros de base de datos

- default: &default 
  - username: tu_usuario 
  - password: tu_contraseña
  
3. Dentro de la carpeta del proyecto, ejecuta los siguientes comandos
- rails db:create 
- rails db:migrate 
- rails db:seed


## Ejecución

4. Dentro de la carpeta del proyecto, ejecuta los siguientes comandos
- rails s

# Implementación

Dentro del archivo seed.rb estan los usuarios para realizar pruebas. Puedesregistrarte con tu propio email y password para realizar los mismos test. Solo el usuario "admin" puede realizar posts, los demas solo pueden realizar comentarios.