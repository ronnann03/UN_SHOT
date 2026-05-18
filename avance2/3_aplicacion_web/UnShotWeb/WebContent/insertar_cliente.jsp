<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>UNSHOT — Insertar Cliente</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,400&family=Cormorant+Garamond:wght@300;400;500&display=swap" rel="stylesheet"/>
  <style>
    *, *::before, *::after { box-sizing:border-box; margin:0; padding:0; }
    :root {
      --gold:#c9a84c; --gold-d:#a8883c;
      --bg:#0c0c0c; --surface:#141414; --card:#1c1c1c;
      --border:#2a2a2a; --white:#fff; --text:#c8c8c8; --muted:#666;
    }
    body { background:var(--bg); color:var(--text); font-family:'Cormorant Garamond',serif; min-height:100vh; }
    nav { background:rgba(12,12,12,.97); border-bottom:1px solid var(--border); padding:18px 40px; display:flex; align-items:center; justify-content:space-between; }
    .brand { font-family:'Playfair Display',serif; font-size:1.6rem; color:var(--white); text-decoration:none; }
    .brand em { color:var(--gold); font-style:normal; }
    .back-link { font-size:.7rem; letter-spacing:2px; text-transform:uppercase; color:var(--gold); text-decoration:none; }
    .back-link:hover { text-decoration:underline; }

    .page-wrap { max-width:620px; margin:60px auto; padding:0 20px 80px; }
    .eyebrow { font-size:.7rem; letter-spacing:6px; text-transform:uppercase; color:var(--gold); margin-bottom:10px; }
    h1 { font-family:'Playfair Display',serif; font-size:2.2rem; color:var(--white); font-style:italic; }
    .gold-line { width:50px; height:2px; background:var(--gold); margin:16px 0 30px; }

    .form-box { background:var(--card); border:1px solid var(--border); padding:36px; }
    .field { margin-bottom:22px; }
    .field label { display:block; font-size:.68rem; letter-spacing:3px; text-transform:uppercase; color:var(--gold); margin-bottom:8px; }
    .field input {
      width:100%; background:rgba(255,255,255,.04);
      border:1px solid var(--border); border-radius:0;
      color:var(--white); padding:12px 14px;
      font-family:'Cormorant Garamond',serif; font-size:1rem;
      transition:border-color .2s;
    }
    .field input::placeholder { color:var(--muted); }
    .field input:focus { outline:none; border-color:var(--gold); background:rgba(201,168,76,.05); }

    .btn-submit {
      width:100%; background:var(--gold); color:var(--bg);
      border:none; padding:14px; font-family:'Playfair Display',serif;
      font-size:1rem; font-weight:700; letter-spacing:2px;
      text-transform:uppercase; cursor:pointer; transition:background .2s;
    }
    .btn-submit:hover { background:var(--gold-d); }

    .alert-error { background:#3a1515; border:1px solid #a83232; color:#ffb4b4; padding:12px 16px; margin-bottom:20px; font-size:.9rem; }
    footer { border-top:1px solid var(--border); text-align:center; padding:24px; font-size:.75rem; color:var(--muted); letter-spacing:1px; margin-top:auto; }
  </style>
</head>
<body>

<nav>
  <a class="brand" href="index.jsp"><em>UN</em>SHOT</a>
  <a class="back-link" href="index.jsp">← Volver al panel</a>
</nav>

<div class="page-wrap">
  <div class="eyebrow">— Tabla: clientes —</div>
  <h1>Insertar Cliente</h1>
  <div class="gold-line"></div>

  <% if (request.getAttribute("error") != null) { %>
    <div class="alert-error"><%= request.getAttribute("error") %></div>
  <% } %>

  <div class="form-box">
    <form action="InsertarCliente" method="post">

      <div class="field">
        <label for="nombre">Nombre</label>
        <input type="text" id="nombre" name="nombre" placeholder="Ej: Maria" required/>
      </div>

      <div class="field">
        <label for="apellido">Apellido</label>
        <input type="text" id="apellido" name="apellido" placeholder="Ej: Torres" required/>
      </div>

      <div class="field">
        <label for="telefono">Telefono</label>
        <input type="tel" id="telefono" name="telefono" placeholder="Ej: +51 987 654 321"/>
      </div>

      <div class="field">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Ej: cliente@email.com"/>
      </div>

      <button type="submit" class="btn-submit">Guardar Cliente</button>

    </form>
  </div>
</div>

<footer>UNSHOT Bar &copy; 2026 &mdash; Supabase (PostgreSQL)</footer>

</body>
</html>
