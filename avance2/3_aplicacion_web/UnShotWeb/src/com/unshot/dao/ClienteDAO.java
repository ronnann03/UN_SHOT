package com.unshot.dao;

import com.unshot.model.Cliente;
import com.unshot.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public void insertar(Cliente c) throws SQLException {
        String sql = "INSERT INTO clientes (nombre, apellido, telefono, email) VALUES (?,?,?,?)";
        try (Connection cn = Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, c.getNombre());
            ps.setString(2, c.getApellido());
            ps.setString(3, c.getTelefono());
            ps.setString(4, c.getEmail());
            ps.executeUpdate();
        }
    }

    public List<Cliente> listar() throws SQLException {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM clientes ORDER BY id_cliente DESC";
        try (Connection cn = Conexion.getConexion();
             Statement  st = cn.createStatement();
             ResultSet  rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setNombre(rs.getString("nombre"));
                c.setApellido(rs.getString("apellido"));
                c.setTelefono(rs.getString("telefono"));
                c.setEmail(rs.getString("email"));
                c.setFechaRegistro(rs.getString("fecha_registro"));
                lista.add(c);
            }
        }
        return lista;
    }
}
