package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String DEFAULT_URL  = "jdbc:postgresql://db.nfdiupwzzxseuymcejbh.supabase.co:5432/postgres?sslmode=require";
    private static final String DEFAULT_USER = "postgres";
    private static final String DEFAULT_PASS = "L1m4Utp123..";

    private static String readSetting(String key, String fallback) {
        String value = System.getenv(key);
        if (value == null || value.isBlank()) {
            value = System.getProperty(key);
        }
        return (value == null || value.isBlank()) ? fallback : value;
    }

    public static String getUrl() {
        return readSetting("SUPABASE_DB_URL", DEFAULT_URL);
    }

    public static String getUser() {
        return readSetting("SUPABASE_DB_USER", DEFAULT_USER);
    }

    public static String getPass() {
        return readSetting("SUPABASE_DB_PASS", DEFAULT_PASS);
    }

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        }
        return DriverManager.getConnection(getUrl(), getUser(), getPass());
    }
}
