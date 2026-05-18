package com.unshot.servlet;

import com.unshot.dao.ClienteDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ListarClientes")
public class ListarClientesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("clientes", new ClienteDAO().listar());
        } catch (SQLException e) {
            req.setAttribute("error", "Error al consultar: " + e.getMessage());
        }
        req.getRequestDispatcher("listar_clientes.jsp").forward(req, resp);
    }
}
