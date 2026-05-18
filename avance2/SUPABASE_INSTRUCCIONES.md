# Instrucciones de Supabase - UNSHOT Bar

## Datos de conexion

| Parametro | Valor |
|-----------|-------|
| URL del proyecto | https://nfdiupwzzxseuymcejbh.supabase.co |
| Puerto PostgreSQL | 5432 |
| Base de datos | postgres |
| Usuario | postgres |
| SSL | requerido (sslmode=require) |

## Cadena JDBC (para archivos .java y .jsp)

```
jdbc:postgresql://db.nfdiupwzzxseuymcejbh.supabase.co:5432/postgres?sslmode=require
```

## Recomendado para backend Java/JSP

Si la conexion directa `db.<project-ref>.supabase.co` falla por DNS o IPv6, usar el
**Session pooler** desde el boton **Connect** del dashboard de Supabase.

Formato habitual:

```text
jdbc:postgresql://aws-0-<region>.pooler.supabase.com:5432/postgres?sslmode=require
```

Con credenciales:

- **Usuario**: `postgres.nfdiupwzzxseuymcejbh`
- **Password**: la contraseña real de la base de datos del proyecto

## Variables de entorno para `Conexion.java`

La clase `util.Conexion` ya admite configuracion por variables de entorno o
propiedades Java:

- `SUPABASE_DB_URL`
- `SUPABASE_DB_USER`
- `SUPABASE_DB_PASS`

Ejemplo:

```powershell
$env:SUPABASE_DB_URL  = "jdbc:postgresql://aws-0-<region>.pooler.supabase.com:5432/postgres?sslmode=require"
$env:SUPABASE_DB_USER = "postgres.nfdiupwzzxseuymcejbh"
$env:SUPABASE_DB_PASS = "TU_PASSWORD_REAL"
```

## Conexion desde JavaScript (frontend)

Los archivos `clientes.html`, `reservas.html` y `reservas-admin.html` usan el SDK de
Supabase para JavaScript. La configuracion esta en `js/supabase-config.js`.

## Tablas de la base de datos

- **clientes** — datos de clientes registrados
- **reservas** — reservas de mesa (vinculada a clientes)
- **bebidas** — carta de bebidas del bar
- **eventos** — eventos programados
- **pedidos** — pedidos realizados

## Activar el proyecto pausado

El plan gratuito de Supabase pausa los proyectos tras 7 dias sin actividad.

1. Ingresar a https://supabase.com
2. Seleccionar el proyecto UnShot
3. Hacer clic en "Resume project"
4. Esperar 1-2 minutos

## Politicas RLS (Row Level Security)

Para que las paginas HTML/JS puedan leer datos, ejecutar en el SQL Editor de Supabase:

```sql
-- Permitir lectura publica en clientes
ALTER TABLE clientes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "lectura_clientes" ON clientes FOR SELECT USING (true);
CREATE POLICY "insertar_clientes" ON clientes FOR INSERT WITH CHECK (true);

-- Permitir lectura e insercion en reservas
ALTER TABLE reservas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "lectura_reservas"  ON reservas FOR SELECT USING (true);
CREATE POLICY "insertar_reservas" ON reservas FOR INSERT WITH CHECK (true);
```

## Driver PostgreSQL para Java

El archivo `postgresql-42.7.3.jar` debe estar en el classpath de Tomcat
(`WEB-INF/lib/` o `$TOMCAT_HOME/lib/`).
