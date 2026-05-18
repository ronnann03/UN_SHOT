# Instrucciones de Supabase - UNSHOT Bar

## Datos de conexion

| Parametro | Valor |
|-----------|-------|
| URL del proyecto | https://disufhicxshjudewytwe.supabase.co |
| Puerto PostgreSQL | 5432 |
| Base de datos | postgres |
| Usuario | postgres |
| SSL | requerido (sslmode=require) |

## Cadena JDBC (para archivos .java y .jsp)

```
jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require
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

-- Permitir lectura publica en reservas
ALTER TABLE reservas ENABLE ROW LEVEL SECURITY;
CREATE POLICY "lectura_reservas" ON reservas FOR SELECT USING (true);
```

## Driver PostgreSQL para Java

El archivo `postgresql-42.7.3.jar` debe estar en el classpath de Tomcat
(`WEB-INF/lib/` o `$TOMCAT_HOME/lib/`).
