package com.unshot.servlet;

import com.unshot.dao.BebidaDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ListarBebidas")
public class ListarBebidasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setAttribute("bebidas", new BebidaDAO().listar());
        } catch (SQLException e) {
            req.setAttribute("error", "Error al consultar: " + e.getMessage());
        }
        req.getRequestDispatcher("listar_bebidas.jsp").forward(req, resp);
    }
}
