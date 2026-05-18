package app;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import util.Conexion;

public class ListarClientes {

    public static void main(String[] args) {
        String sql = "SELECT * FROM clientes ORDER BY id_cliente DESC";

        try (Connection cn = Conexion.getConexion();
             Statement st = cn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            System.out.println("=== LISTA DE CLIENTES ===");
            System.out.printf("%-5s %-15s %-15s %-15s %-25s %-20s%n",
                    "#", "Nombre", "Apellido", "Telefono", "Email", "Fecha Registro");
            System.out.println("-".repeat(100));

            while (rs.next()) {
                System.out.printf("%-5d %-15s %-15s %-15s %-25s %-20s%n",
                        rs.getInt("id_cliente"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("telefono") != null ? rs.getString("telefono") : "-",
                        rs.getString("email") != null ? rs.getString("email") : "-",
                        rs.getString("fecha_registro"));
            }
        } catch (Exception e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
        }
    }
}
