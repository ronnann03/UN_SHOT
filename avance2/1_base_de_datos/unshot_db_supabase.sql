-- ============================================================
--  UNSHOT BAR — Base de Datos
--  Motor   : PostgreSQL (Supabase)
--  Ejecutar en: Supabase Dashboard > SQL Editor
-- ============================================================

-- ── Tabla 1: CLIENTES ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente     SERIAL PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    apellido       VARCHAR(100) NOT NULL,
    telefono       VARCHAR(20),
    email          VARCHAR(100) UNIQUE,
    fecha_registro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- ── Tabla 2: BEBIDAS ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS bebidas (
    id_bebida   SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    categoria   VARCHAR(30) NOT NULL
                  CHECK (categoria IN ('Clasico','Signature','Premium','Sin Alcohol')),
    descripcion TEXT,
    precio      NUMERIC(8,2) NOT NULL
);

-- ── Tabla 3: EVENTOS ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS eventos (
    id_evento      SERIAL PRIMARY KEY,
    nombre         VARCHAR(150) NOT NULL,
    descripcion    TEXT,
    fecha          DATE NOT NULL,
    hora           TIME NOT NULL,
    precio_entrada NUMERIC(8,2) NOT NULL DEFAULT 0.00
);

-- ── Tabla 4: RESERVAS ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva   SERIAL PRIMARY KEY,
    id_cliente   INT NOT NULL
                   REFERENCES clientes(id_cliente)
                   ON UPDATE CASCADE ON DELETE RESTRICT,
    fecha        DATE NOT NULL,
    hora         TIME NOT NULL,
    num_personas INT NOT NULL,
    ocasion      VARCHAR(100),
    estado       VARCHAR(20) NOT NULL DEFAULT 'Pendiente'
                   CHECK (estado IN ('Pendiente','Confirmada','Cancelada'))
);

-- ── Tabla 5: PEDIDOS ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido       SERIAL PRIMARY KEY,
    id_reserva      INT NOT NULL
                      REFERENCES reservas(id_reserva)
                      ON UPDATE CASCADE ON DELETE CASCADE,
    id_bebida       INT NOT NULL
                      REFERENCES bebidas(id_bebida)
                      ON UPDATE CASCADE ON DELETE RESTRICT,
    cantidad        INT NOT NULL DEFAULT 1,
    precio_unitario NUMERIC(8,2) NOT NULL
);

-- ── Datos de ejemplo ─────────────────────────────────────────
INSERT INTO clientes (nombre, apellido, telefono, email) VALUES
('Maria',   'Torres',  '+51 987 654 321', 'maria@email.com'),
('Carlos',  'Mendoza', '+51 912 345 678', 'carlos@email.com'),
('Lucia',   'Ramos',   '+51 934 567 890', 'lucia@email.com'),
('Diego',   'Perez',   '+51 901 111 222', 'diego@email.com'),
('Valeria', 'Solis',   '+51 956 789 012', 'valeria@email.com');

INSERT INTO bebidas (nombre, categoria, descripcion, precio) VALUES
('Shot Dorado',  'Clasico',     'Bourbon añejo, miel de ambar, bitter de naranja y hielo esferico.',      38.00),
('Lima Noir',    'Signature',   'Pisco quebranta, maracuya ahumado, espuma de limon y flor de sal.',      42.00),
('Velvet Noche', 'Premium',     'Gin premium, frutos rojos macerados, tonica especiada y romero fresco.', 45.00),
('Sunset Shot',  'Signature',   'Tequila reposado, mango andino, chile rocoto y borde de tajin.',         40.00),
('Agua de Lima', 'Sin Alcohol', 'Lima, menta, jengibre y agua con gas.',                                  18.00);

INSERT INTO eventos (nombre, descripcion, fecha, hora, precio_entrada) VALUES
('Jazz Night',   'Noche de jazz en vivo con la banda Lima Jazz Collective.', '2026-05-16', '21:00:00', 25.00),
('Cata de Pisco','Degustacion guiada de piscos premium del sur del Peru.',   '2026-05-23', '19:00:00', 35.00),
('Fiesta 80s',   'Musica retro de los 80s con DJ invitado.',                 '2026-05-30', '22:00:00', 20.00);

INSERT INTO reservas (id_cliente, fecha, hora, num_personas, ocasion, estado) VALUES
(1, '2026-05-15', '20:00:00', 2, 'Aniversario',   'Confirmada'),
(2, '2026-05-16', '21:00:00', 4, 'Visita casual', 'Pendiente'),
(3, '2026-05-17', '22:00:00', 6, 'Cumpleanos',    'Confirmada');

INSERT INTO pedidos (id_reserva, id_bebida, cantidad, precio_unitario) VALUES
(1, 2, 2, 42.00),
(1, 1, 1, 38.00),
(2, 3, 4, 45.00),
(3, 4, 3, 40.00);
