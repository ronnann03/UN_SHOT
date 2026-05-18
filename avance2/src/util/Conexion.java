package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL  = "jdbc:postgresql://db.disufhicxshjudewytwe.supabase.co:5432/postgres?sslmode=require";
    private static final String USER = "postgres";
    private static final String PASS = "L1m4Utp123..";

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver PostgreSQL no encontrado", e);
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
