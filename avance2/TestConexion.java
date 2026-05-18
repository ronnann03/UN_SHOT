import java.sql.*;
import util.Conexion;

public class TestConexion {

    public static void main(String[] args) throws Exception {
        Connection cn = Conexion.getConexion();
        System.out.println("=== Conexion exitosa a Supabase ===\n");

        // --- LISTA DE CLIENTES ---
        System.out.println("=== LISTA DE CLIENTES ===");
        System.out.printf("%-5s %-15s %-15s %-15s %-25s %-20s%n",
                          "#", "Nombre", "Apellido", "Telefono", "Email", "Fecha Registro");
        System.out.println("-".repeat(100));

        Statement st1 = cn.createStatement();
        ResultSet rs1 = st1.executeQuery("SELECT * FROM clientes ORDER BY id_cliente DESC");
        while (rs1.next()) {
            System.out.printf("%-5d %-15s %-15s %-15s %-25s %-20s%n",
                rs1.getInt("id_cliente"),
                rs1.getString("nombre"),
                rs1.getString("apellido"),
                rs1.getString("telefono") != null ? rs1.getString("telefono") : "-",
                rs1.getString("email")    != null ? rs1.getString("email")    : "-",
                rs1.getString("fecha_registro"));
        }
        rs1.close(); st1.close();

        System.out.println();

        // --- LISTA DE RESERVAS ---
        System.out.println("=== LISTA DE RESERVAS ===");
        System.out.printf("%-5s %-20s %-12s %-8s %-9s %-20s %-12s%n",
                          "#", "Cliente", "Fecha", "Hora", "Personas", "Ocasion", "Estado");
        System.out.println("-".repeat(90));

        Statement st2 = cn.createStatement();
        ResultSet rs2 = st2.executeQuery(
            "SELECT r.id_reserva, c.nombre, c.apellido, r.fecha, r.hora, " +
            "r.num_personas, r.ocasion, r.estado " +
            "FROM reservas r " +
            "JOIN clientes c ON r.id_cliente = c.id_cliente " +
            "ORDER BY r.fecha DESC, r.hora DESC"
        );
        while (rs2.next()) {
            System.out.printf("%-5d %-20s %-12s %-8s %-9d %-20s %-12s%n",
                rs2.getInt("id_reserva"),
                rs2.getString("nombre") + " " + rs2.getString("apellido"),
                rs2.getString("fecha"),
                rs2.getString("hora"),
                rs2.getInt("num_personas"),
                rs2.getString("ocasion") != null ? rs2.getString("ocasion") : "-",
                rs2.getString("estado"));
        }
        rs2.close(); st2.close();

        cn.close();
    }
}
