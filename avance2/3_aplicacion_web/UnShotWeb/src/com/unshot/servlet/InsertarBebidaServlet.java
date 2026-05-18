package com.unshot.servlet;

import com.unshot.dao.BebidaDAO;
import com.unshot.model.Bebida;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/InsertarBebida")
public class InsertarBebidaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String precioStr = req.getParameter("precio");
        double precio = 0;
        try {
            precio = Double.parseDouble(precioStr.replace(",", "."));
        } catch (NumberFormatException ex) {
            req.setAttribute("error", "El precio ingresado no es valido.");
            req.getRequestDispatcher("insertar_bebida.jsp").forward(req, resp);
            return;
        }

        Bebida b = new Bebida();
        b.setNombre(req.getParameter("nombre"));
        b.setCategoria(req.getParameter("categoria"));
        b.setDescripcion(req.getParameter("descripcion"));
        b.setPrecio(precio);

        try {
            new BebidaDAO().insertar(b);
            resp.sendRedirect("ListarBebidas?msg=ok");
        } catch (SQLException e) {
            req.setAttribute("error", "Error al guardar: " + e.getMessage());
            req.getRequestDispatcher("insertar_bebida.jsp").forward(req, resp);
        }
    }
}
