# Reporte de Avances - Proyecto Un:Shot

## 1. Resumen general

El proyecto Un:Shot fue reorganizado para presentar una unica experiencia principal
centrada en `index.html`, manteniendo una interfaz mas clara, menos confusa y mas
alineada con la maqueta visual del sitio. Ademas, se verifico la conexion del
frontend con Supabase para operaciones reales de lectura e insercion de datos.

## 2. Objetivo del trabajo realizado

- Simplificar la estructura del frontend.
- Verificar que el sitio web se conecte correctamente con la base de datos.
- Dejar operativas las funcionalidades de reserva y registro de clientes.
- Preparar los programas JSP y Java requeridos para insertar y listar datos.

## 3. Cambios realizados en el frontend

### 3.1 Limpieza del proyecto

Se elimino el exceso de paginas HTML independientes para evitar confusion y se dejo
como punto principal de acceso solo `index.html`.

Se retiraron las paginas:

- `carta.html`
- `clientes.html`
- `contacto.html`
- `eventos.html`
- `nosotros.html`
- `registro.html`
- `reservas-admin.html`
- `reservas.html`

### 3.2 Unificacion del flujo del sitio

La pagina principal `index.html` ahora concentra las secciones visuales del
proyecto:

- Inicio
- Carta
- Nosotros
- Contacto
- Reservar mesa

### 3.3 Conexion del frontend con Supabase

Se mantuvo la conexion del frontend usando:

- URL: `https://nfdiupwzzxseuymcejbh.supabase.co`
- clave publicable de Supabase

La configuracion se centralizo en:

- `js/supabase-config.js`

### 3.4 Formularios conectados

Se creo un archivo compartido:

- `js/site-forms.js`

Este archivo centraliza la logica de:

- registrar clientes
- crear reservas
- enviar contacto
- reutilizar un cliente existente si el correo ya esta registrado

## 4. Verificacion con base de datos

Se realizaron pruebas reales contra Supabase y se comprobó lo siguiente:

- lectura correcta de la tabla `clientes`
- insercion correcta de nuevos clientes
- insercion correcta de reservas en la tabla `reservas`
- consulta posterior para verificar que los datos si quedaron registrados

### Resultado de la validacion

El frontend **si funciona correctamente con la base de datos** en los modulos de:

- clientes
- reservas

### Observacion sobre contacto

La tabla `contactos` no existia en Supabase. Por eso se ajusto el codigo para que
el formulario no falle si esa tabla aun no esta creada.

Ademas, se agrego su definicion en:

- `avance2/database/unshot_db.sql`

## 5. Programas JSP solicitados

Se verifico que el proyecto cuenta con programas JSP para insertar y listar datos
de dos tablas principales:

### Insertar datos

- `avance2/web/insertar_cliente.jsp`
- `avance2/web/insertar_reserva.jsp`

### Listar datos

- `avance2/web/listar_clientes.jsp`
- `avance2/web/listar_reservas.jsp`

## 6. Programas Java solicitados

Se agregaron programas Java separados para cumplir con el requerimiento academico:

### Insertar datos

- `avance2/src/app/InsertarCliente.java`
- `avance2/src/app/InsertarReserva.java`

### Listar datos

- `avance2/src/app/ListarClientes.java`
- `avance2/src/app/ListarReservas.java`

Tambien se mantiene una prueba general:

- `avance2/TestConexion.java`

## 7. Mejora de arquitectura del backend

Se centralizo la conexion en:

- `avance2/src/util/Conexion.java`

Con esto, los JSP y los programas Java usan una sola clase para conectarse.
Ademas, se dejo preparada para leer variables de entorno:

- `SUPABASE_DB_URL`
- `SUPABASE_DB_USER`
- `SUPABASE_DB_PASS`

## 8. Estado actual del proyecto

### Frontend

- funcional
- limpio
- conectado a Supabase
- probado con inserciones reales

### JSP y Java

- estructura lista
- programas de insertar y listar completados
- compilacion correcta de los archivos Java

### Backend JDBC

- la estructura ya esta preparada
- aun falta cerrar completamente la conexion por pooler con la cadena exacta de
  Supabase para validacion final desde Java/JSP

## 9. Conclusiones

El proyecto quedo mejor organizado, mas presentable y con una validacion real de
su funcionamiento en frontend y base de datos. Tambien se completaron los programas
JSP y Java requeridos para insertar y listar informacion en dos tablas, cumpliendo
la parte academica solicitada.

## 10. Recomendaciones para la presentacion

- Mostrar primero `index.html` como pagina principal.
- Explicar que el frontend trabaja con Supabase en tiempo real.
- Mostrar la insercion de un cliente y una reserva como evidencia.
- Enseñar los JSP de insertar y listar.
- Enseñar los programas Java separados de insertar y listar.
- Mencionar que la conexion JDBC fue reorganizada y dejada preparada para el pooler.
