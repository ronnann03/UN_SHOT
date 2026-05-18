# Configuracion de Supabase — UNSHOT Bar

## Que es Supabase?

Supabase es una base de datos PostgreSQL en la nube gratuita.
No necesitas instalar nada en tu computadora — todo funciona por internet.

---

## PASO 1 — Crear cuenta y proyecto

1. Entra a **https://supabase.com**
2. Haz clic en **Start for free** e inicia sesion con Google o GitHub
3. En el dashboard haz clic en **New project**
4. Completa los campos:
   - **Organization:** la que se crea automaticamente con tu cuenta
   - **Name:** `unshot-bar`
   - **Database Password:** escribe una contrasena y **guardala en un lugar seguro**
   - **Region:** `South America (Sao Paulo)` — la mas cercana a Peru
5. Haz clic en **Create new project**
6. Espera 1-2 minutos mientras se crea el proyecto

---

## PASO 2 — Crear las tablas (ejecutar el SQL)

1. En el menu izquierdo haz clic en **SQL Editor**
2. Haz clic en **+ New query**
3. Abre el archivo del proyecto:
   ```
   avance2/1_base_de_datos/unshot_db_supabase.sql
   ```
4. Copia **todo** el contenido del archivo
5. Pegalo en el editor de Supabase
6. Haz clic en el boton **Run** (triangulo verde) o presiona `Ctrl + Enter`
7. Debe aparecer el mensaje: `Success. No rows returned.`

### Verificar que funciono

- Ve a **Table Editor** en el menu izquierdo
- Deben aparecer las 5 tablas:
  - `clientes`
  - `bebidas`
  - `eventos`
  - `reservas`
  - `pedidos`
- Haz clic en cada tabla para ver los datos de ejemplo ya insertados

> **Evidencia para el avance:** toma un screenshot de Table Editor mostrando las tablas y los datos.

---

## PASO 3 — Obtener los datos de conexion

Estos datos los necesita el archivo `Conexion.java` para conectar Java con tu base de datos.

1. En el menu izquierdo ve a **Settings** (icono de engranaje abajo del todo)
2. Haz clic en **Database**
3. Baja hasta la seccion **Connection parameters**
4. Anota estos valores:

| Campo | Donde encontrarlo | Ejemplo |
|-------|-------------------|---------|
| **Host** | Campo "Host" | `db.abcdefghij.supabase.co` |
| **Port** | Campo "Port" | `5432` |
| **Database** | Campo "Database name" | `postgres` |
| **User** | Campo "User" | `postgres` |
| **Password** | La que pusiste al crear el proyecto | `TuPassword123` |

---

## PASO 4 — Poner los datos en Conexion.java

Abre el archivo `src/com/unshot/util/Conexion.java` y edita estas dos lineas:

```java
private static final String HOST = "db.XXXXXXXXXX.supabase.co"; // <- pega tu Host aqui
private static final String PASS = "TU_PASSWORD_SUPABASE";       // <- pega tu Password aqui
```

Ejemplo real:
```java
private static final String HOST = "db.abcdefghij.supabase.co";
private static final String PASS = "MiPassword123";
```

Guarda el archivo con `Ctrl + S`.

---

## PASO 5 — Probar la conexion

1. Ejecuta el proyecto en Eclipse con Tomcat (clic derecho > Run As > Run on Server)
2. Abre el navegador en `http://localhost:8080/UnShotWeb/`
3. Haz clic en **"Nuevo Cliente"**, llena el formulario y guarda
4. Debe aparecer el listado con el cliente recien insertado
5. Verifica en Supabase > Table Editor > `clientes` que el registro aparece

---

## Errores comunes

| Error | Causa | Solucion |
|-------|-------|----------|
| `Connection refused` | Host incorrecto | Copia el host exacto de Supabase Settings |
| `password authentication failed` | Password incorrecta | Revisa la contrasena en Conexion.java |
| `ClassNotFoundException: org.postgresql.Driver` | Falta el JAR | Agrega `postgresql-42.7.3.jar` a `WEB-INF/lib/` |
| `SSL connection required` | Problema de SSL | La URL ya incluye `?sslmode=require`, verifica que no fue borrado |
| Tablas no existen | SQL no se ejecuto | Repite el PASO 2 |

---

## Donde descargar el driver PostgreSQL para Java

El archivo `postgresql-42.7.3.jar` es obligatorio para que Java se conecte a Supabase.

1. Ve a: **https://jdbc.postgresql.org/download/**
2. Descarga la version **42.7.3** (o la mas reciente)
3. Copia el `.jar` a la carpeta del proyecto: `WebContent/WEB-INF/lib/`
4. En Eclipse: clic derecho en el proyecto > Build Path > Add JARs > selecciona el jar

---

## Resumen visual del flujo

```
Tu app Java (Eclipse + Tomcat)
        |
        | JDBC (postgresql-42.7.3.jar)
        | URL: jdbc:postgresql://db.xxx.supabase.co:5432/postgres?sslmode=require
        |
Supabase (PostgreSQL en la nube)
        |
   5 tablas: clientes, bebidas, eventos, reservas, pedidos
```
