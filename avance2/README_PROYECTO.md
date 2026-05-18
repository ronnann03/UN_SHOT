# UNSHOT Bar — Avance 2

Aplicacion web Java EE para la gestion del bar UNSHOT. Permite registrar y listar clientes y bebidas usando JSP, Servlets y una base de datos PostgreSQL alojada en Supabase.

---

## Tecnologias utilizadas

| Tecnologia | Version | Para que sirve |
|------------|---------|----------------|
| Java | 11+ | Logica del backend |
| JSP (JavaServer Pages) | 2.3 | Vistas / paginas web |
| Servlets | 4.0 | Controladores HTTP |
| Apache Tomcat | 9.x | Servidor web local |
| Supabase | — | Base de datos PostgreSQL en la nube |
| Driver JDBC PostgreSQL | 42.7.3 | Conexion Java ↔ Supabase |
| Eclipse IDE | — | Entorno de desarrollo |
| Bootstrap / CSS | Personalizado | Estilos del panel admin |

---

## Estructura del proyecto

```
avance2/
├── README_PROYECTO.md              <- Este archivo
├── README_SUPABASE.md              <- Guia de configuracion de Supabase
├── instrucciones_instalacion.txt   <- Guia completa de instalacion en Eclipse
│
├── 1_base_de_datos/
│   ├── unshot_db_supabase.sql      <- Script SQL para crear las 5 tablas en Supabase
│   └── unshot_db.sql               <- Script SQL version MySQL (referencia)
│
├── 2_diagrama_er/
│   └── er_diagrama.html            <- Diagrama Entidad-Relacion (abrir en navegador)
│
└── 3_aplicacion_web/
    └── UnShotWeb/                  <- Proyecto Java EE para importar en Eclipse
        ├── WebContent/
        │   ├── WEB-INF/
        │   │   ├── lib/            <- Aqui va postgresql-42.7.3.jar
        │   │   └── web.xml         <- Configuracion del proyecto web
        │   ├── index.jsp           <- Pagina principal / panel de navegacion
        │   ├── insertar_cliente.jsp
        │   ├── insertar_bebida.jsp
        │   ├── listar_clientes.jsp
        │   └── listar_bebidas.jsp
        └── src/
            └── com/unshot/
                ├── util/
                │   └── Conexion.java        <- Configuracion de la BD
                ├── model/
                │   ├── Cliente.java         <- Clase modelo Cliente
                │   └── Bebida.java          <- Clase modelo Bebida
                ├── dao/
                │   ├── ClienteDAO.java      <- Consultas SQL de clientes
                │   └── BebidaDAO.java       <- Consultas SQL de bebidas
                └── servlet/
                    ├── InsertarClienteServlet.java
                    ├── InsertarBebidaServlet.java
                    ├── ListarClientesServlet.java
                    └── ListarBebidasServlet.java
```

---

## Base de datos — 5 Tablas

### Diagrama de relaciones

```
clientes ──(1:N)── reservas ──(1:N)── pedidos ──(N:1)── bebidas

eventos  (entidad independiente)
```

### Descripcion de cada tabla

#### clientes
Almacena los datos de los clientes del bar.

| Columna | Tipo | Descripcion |
|---------|------|-------------|
| id_cliente | SERIAL PK | Identificador unico autoincremental |
| nombre | VARCHAR(100) | Nombre del cliente |
| apellido | VARCHAR(100) | Apellido del cliente |
| telefono | VARCHAR(20) | Numero de telefono |
| email | VARCHAR(100) | Correo electronico (unico) |
| fecha_registro | DATE | Fecha de registro (por defecto hoy) |

#### bebidas
Carta de cocteles y bebidas disponibles en el bar.

| Columna | Tipo | Descripcion |
|---------|------|-------------|
| id_bebida | SERIAL PK | Identificador unico |
| nombre | VARCHAR(100) | Nombre de la bebida |
| categoria | VARCHAR(30) | Clasico, Signature, Premium, Sin Alcohol |
| descripcion | TEXT | Descripcion de ingredientes |
| precio | NUMERIC(8,2) | Precio en soles (S/) |

#### eventos
Eventos especiales organizados por el bar.

| Columna | Tipo | Descripcion |
|---------|------|-------------|
| id_evento | SERIAL PK | Identificador unico |
| nombre | VARCHAR(150) | Nombre del evento |
| descripcion | TEXT | Descripcion del evento |
| fecha | DATE | Fecha del evento |
| hora | TIME | Hora de inicio |
| precio_entrada | NUMERIC(8,2) | Costo de entrada (0 si es gratis) |

#### reservas
Reservas de mesa realizadas por los clientes.

| Columna | Tipo | Descripcion |
|---------|------|-------------|
| id_reserva | SERIAL PK | Identificador unico |
| id_cliente | INT FK | Referencia a clientes |
| fecha | DATE | Fecha de la reserva |
| hora | TIME | Hora de la reserva |
| num_personas | INT | Numero de personas |
| ocasion | VARCHAR(100) | Motivo (cumpleanos, aniversario, etc.) |
| estado | VARCHAR(20) | Pendiente, Confirmada o Cancelada |

#### pedidos
Bebidas solicitadas dentro de una reserva.

| Columna | Tipo | Descripcion |
|---------|------|-------------|
| id_pedido | SERIAL PK | Identificador unico |
| id_reserva | INT FK | Referencia a reservas |
| id_bebida | INT FK | Referencia a bebidas |
| cantidad | INT | Numero de unidades pedidas |
| precio_unitario | NUMERIC(8,2) | Precio al momento del pedido |

---

## Funcionalidades implementadas

### Insertar datos

| Funcionalidad | Archivo JSP | Servlet | DAO |
|---------------|-------------|---------|-----|
| Registrar nuevo cliente | `insertar_cliente.jsp` | `InsertarClienteServlet.java` | `ClienteDAO.insertar()` |
| Registrar nueva bebida | `insertar_bebida.jsp` | `InsertarBebidaServlet.java` | `BebidaDAO.insertar()` |

### Listar datos

| Funcionalidad | Archivo JSP | Servlet | DAO |
|---------------|-------------|---------|-----|
| Ver todos los clientes | `listar_clientes.jsp` | `ListarClientesServlet.java` | `ClienteDAO.listar()` |
| Ver todas las bebidas | `listar_bebidas.jsp` | `ListarBebidasServlet.java` | `BebidaDAO.listar()` |

---

## Patron de arquitectura MVC

El proyecto sigue el patron **Modelo - Vista - Controlador**:

```
VISTA (JSP)           CONTROLADOR (Servlet)       MODELO (DAO + Model)
───────────           ─────────────────────       ────────────────────
insertar_*.jsp  ───>  Insertar*Servlet  ───>  *DAO.insertar()  ───> Supabase
listar_*.jsp    <───  Listar*Servlet    <───  *DAO.listar()    <─── Supabase
```

---

## Flujo de una insercion (ejemplo: nuevo cliente)

```
1. Usuario llena el formulario en insertar_cliente.jsp
2. El formulario hace POST a /InsertarCliente
3. InsertarClienteServlet recibe los datos del request
4. Crea un objeto Cliente y llama a ClienteDAO.insertar()
5. ClienteDAO abre conexion a Supabase con Conexion.getConexion()
6. Ejecuta: INSERT INTO clientes (nombre, apellido, ...) VALUES (?,?,...)
7. Supabase guarda el registro
8. El Servlet hace redirect a /ListarClientes?msg=ok
9. ListarClientesServlet llama a ClienteDAO.listar()
10. Carga todos los clientes y los pasa a listar_clientes.jsp
11. El JSP muestra la tabla con el mensaje "guardado correctamente"
```

---

## Paginas de la aplicacion

| URL | Descripcion |
|-----|-------------|
| `/UnShotWeb/` | Panel principal con accesos directos |
| `/UnShotWeb/insertar_cliente.jsp` | Formulario para nuevo cliente |
| `/UnShotWeb/ListarClientes` | Tabla con todos los clientes |
| `/UnShotWeb/insertar_bebida.jsp` | Formulario para nueva bebida |
| `/UnShotWeb/ListarBebidas` | Tabla con todas las bebidas |

---

## Requisitos para ejecutar

- JDK 11 o superior
- Eclipse IDE for Enterprise Java Developers
- Apache Tomcat 9
- Archivo `postgresql-42.7.3.jar` en `WebContent/WEB-INF/lib/`
- Cuenta en Supabase con el proyecto configurado
- `Conexion.java` editado con tu HOST y PASSWORD de Supabase

Ver `README_SUPABASE.md` para la guia detallada de Supabase.
Ver `instrucciones_instalacion.txt` para el paso a paso en Eclipse.

---

## Proyecto principal (sitio web del bar)

La carpeta raiz contiene el sitio web estatico de UNSHOT Bar:

| Archivo | Descripcion |
|---------|-------------|
| `index.html` | Pagina principal del bar |
| `carta.html` | Carta de cocteles |
| `eventos.html` | Pagina de eventos |
| `contacto.html` | Pagina de contacto |
| `shared.css` | Estilos compartidos del sitio |
