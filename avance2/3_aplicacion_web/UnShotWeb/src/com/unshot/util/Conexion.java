package com.unshot.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    // ── Datos de conexion Supabase ────────────────────────────
    // Reemplaza HOST, DB_PASSWORD con tus datos reales de Supabase
    // Los encuentras en: Supabase Dashboard > Project Settings > Database
    private static final String HOST = "db.XXXXXXXXXX.supabase.co"; // ← tu host
    private static final String PORT = "5432";
    private static final String DB   = "postgres";
    private static final String USER = "postgres";
    private static final String PASS = "TU_PASSWORD_SUPABASE";       // ← tu password

    private static final String URL =
        "jdbc:postgresql://" + HOST + ":" + PORT + "/" + DB + "?sslmode=require";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                "Driver PostgreSQL no encontrado. Agrega postgresql-42.x.jar a WEB-INF/lib/", e);
        }
    }

    public static Connection getConexion() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
