package sample.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.user.UserDTO;
import sample.user.UserDAO;

@WebServlet(name = "SelectTopUserController", urlPatterns = {"/SelectTopUserController"})
public class Top1Controller extends HttpServlet {

   private static final String ERROR = "top1.jsp";
    private static final String SUCCESS = "top1.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO dao = new UserDAO();
            UserDTO topUser = dao.getTop1();
            if (topUser != null) {
                request.setAttribute("TOP_USER", topUser);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at Top1Controller: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "SelectTopUserController";
    }
}
