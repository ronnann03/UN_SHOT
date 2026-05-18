package app;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;
import util.Conexion;

public class InsertarReserva {

    public static void main(String[] args) {
        try (Scanner sc = new Scanner(System.in)) {
            System.out.println("=== INSERTAR RESERVA ===");

            System.out.print("ID del cliente: ");
            int idCliente = Integer.parseInt(sc.nextLine().trim());

            System.out.print("Fecha (AAAA-MM-DD): ");
            String fecha = sc.nextLine().trim();

            System.out.print("Hora (HH:MM): ");
            String hora = sc.nextLine().trim();

            System.out.print("Numero de personas: ");
            int personas = Integer.parseInt(sc.nextLine().trim());

            System.out.print("Ocasion: ");
            String ocasion = sc.nextLine().trim();

            System.out.print("Estado (Pendiente/Confirmada/Cancelada): ");
            String estado = sc.nextLine().trim();

            String sql = "INSERT INTO reservas (id_cliente, fecha, hora, num_personas, ocasion, estado) VALUES (?, ?, ?, ?, ?, ?)";

            try (Connection cn = Conexion.getConexion();
                 PreparedStatement ps = cn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

                ps.setInt(1, idCliente);
                ps.setDate(2, java.sql.Date.valueOf(fecha));
                ps.setTime(3, java.sql.Time.valueOf(hora + ":00"));
                ps.setInt(4, personas);
                ps.setString(5, ocasion.isEmpty() ? null : ocasion);
                ps.setString(6, estado.isEmpty() ? "Pendiente" : estado);
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        System.out.println("Reserva insertada correctamente con ID: " + rs.getInt(1));
                    } else {
                        System.out.println("Reserva insertada correctamente.");
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error al insertar reserva: " + e.getMessage());
        }
    }
}
