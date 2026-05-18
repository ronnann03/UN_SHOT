package app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import util.Conexion;

public class InsertarCliente {

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.println("=== INSERTAR CLIENTE ===");

            System.out.print("Nombre: ");
            String nombre = sc.nextLine().trim();

            System.out.print("Apellido: ");
            String apellido = sc.nextLine().trim();

            System.out.print("Telefono: ");
            String telefono = sc.nextLine().trim();

            System.out.print("Email: ");
            String email = sc.nextLine().trim();

            String sql = "INSERT INTO clientes (nombre, apellido, telefono, email) VALUES (?, ?, ?, ?)";

            try (Connection cn = Conexion.getConexion();
                 PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setString(1, nombre);
                ps.setString(2, apellido);
                ps.setString(3, telefono.isEmpty() ? null : telefono);
                ps.setString(4, email.isEmpty() ? null : email);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        System.out.println("Cliente insertado correctamente con ID: " + rs.getInt(1));
                    } else {
                        System.out.println("Cliente insertado correctamente.");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error al insertar cliente: " + e.getMessage());
        }
    }
}
