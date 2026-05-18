package com.unshot.servlet;

import com.unshot.dao.ClienteDAO;
import com.unshot.model.Cliente;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/InsertarCliente")
public class InsertarClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        Cliente c = new Cliente();
        c.setNombre(req.getParameter("nombre"));
        c.setApellido(req.getParameter("apellido"));
        c.setTelefono(req.getParameter("telefono"));
        c.setEmail(req.getParameter("email"));

        try {
            new ClienteDAO().insertar(c);
            resp.sendRedirect("ListarClientes?msg=ok");
        } catch (SQLException e) {
            req.setAttribute("error", "Error al guardar: " + e.getMessage());
            req.getRequestDispatcher("insertar_cliente.jsp").forward(req, resp);
        }
    }
}
