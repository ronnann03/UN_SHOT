package app;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import util.Conexion;

public class ListarReservas {

    public static void main(String[] args) {
        String sql = "SELECT r.id_reserva, c.nombre, c.apellido, r.fecha, r.hora, " +
                "r.num_personas, r.ocasion, r.estado " +
                "FROM reservas r " +
                "JOIN clientes c ON r.id_cliente = c.id_cliente " +
                "ORDER BY r.fecha DESC, r.hora DESC";

        try (Connection cn = Conexion.getConexion();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("=== LISTA DE RESERVAS ===");
            System.out.printf("%-5s %-20s %-12s %-8s %-9s %-20s %-12s%n",
                    "#", "Cliente", "Fecha", "Hora", "Personas", "Ocasion", "Estado");
            System.out.println("-".repeat(90));

            while (rs.next()) {
                System.out.printf("%-5d %-20s %-12s %-8s %-9d %-20s %-12s%n",
                        rs.getInt("id_reserva"),
                        rs.getString("nombre") + " " + rs.getString("apellido"),
                        rs.getString("fecha"),
                        rs.getString("hora"),
                        rs.getInt("num_personas"),
                        rs.getString("ocasion") != null ? rs.getString("ocasion") : "-",
                        rs.getString("estado"));
            }
        } catch (Exception e) {
            System.out.println("Error al listar reservas: " + e.getMessage());
        }
    }
}
