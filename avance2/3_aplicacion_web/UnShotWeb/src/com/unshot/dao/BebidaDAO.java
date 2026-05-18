package com.unshot.dao;

import com.unshot.model.Bebida;
import com.unshot.util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BebidaDAO {

    public void insertar(Bebida b) throws SQLException {
        String sql = "INSERT INTO bebidas (nombre, categoria, descripcion, precio) VALUES (?,?,?,?)";
        try (Connection cn = Conexion.getConexion();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, b.getNombre());
            ps.setString(2, b.getCategoria());
            ps.setString(3, b.getDescripcion());
            ps.setDouble(4, b.getPrecio());
            ps.executeUpdate();
        }
    }

    public List<Bebida> listar() throws SQLException {
        List<Bebida> lista = new ArrayList<>();
        String sql = "SELECT * FROM bebidas ORDER BY categoria, nombre";
        try (Connection cn = Conexion.getConexion();
             Statement  st = cn.createStatement();
             ResultSet  rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Bebida b = new Bebida();
                b.setIdBebida(rs.getInt("id_bebida"));
                b.setNombre(rs.getString("nombre"));
                b.setCategoria(rs.getString("categoria"));
                b.setDescripcion(rs.getString("descripcion"));
                b.setPrecio(rs.getDouble("precio"));
                lista.add(b);
            }
        }
        return lista;
    }
}
