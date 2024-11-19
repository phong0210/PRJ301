/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.product.OrderDAO;
import sample.user.UserDAO;
import sample.user.UserDTO;

/**
 *
 * @author PC
 */
public class LoginController extends HttpServlet {

    private static final String USER_PAGE = "user.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String ERROR = "login.jsp";
    private static final String US = "US";
    private static final String AD = "AD";
    private static final String ERROR_MESSAGE = "Your role is not support";
    private static final String INCORRECT_MESSAGE = "INCORRECT USERID OR PASSWORD";
    private static final String DEACTIVE_MESSAGE = "Your account has been deleted";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            UserDAO dao = new UserDAO();
            UserDTO loginUser = null;

            String authType = (String) request.getAttribute("AUTH_TYPE");
            if ("Google".equals(authType)) {
                loginUser = (UserDTO) request.getAttribute("GOOGLE_USER");

            } else {
                String userID = request.getParameter("userID");
                String password = request.getParameter("password");
                loginUser = dao.checkLogin(userID, password);

            }

            //xac thuc
            if (loginUser == null) {
                request.setAttribute("ERROR", INCORRECT_MESSAGE);
                url = ERROR;
            } else {
                // phan quyen   
                boolean isActive = dao.isUserActive(loginUser.getUserID());
                if (isActive) {
                    HttpSession session = request.getSession();
                    session.setAttribute("LOGIN_USER", loginUser);
                    OrderDAO orderDAO = new OrderDAO();
                    session.setAttribute("ORDER_HISTORY", orderDAO.getOrderHistory(loginUser.getUserID()));
                    String roleID = loginUser.getRoleID();
                    if (AD.equals(roleID)) {
                        url = ADMIN_PAGE;
                    } else if (US.equals(roleID)) {
                        url = USER_PAGE;
                    } else {
                        url = ERROR;
                        request.setAttribute("ERROR", ERROR_MESSAGE);
                    }
                } else {
                    request.setAttribute("ERROR", DEACTIVE_MESSAGE);
                }
            }
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
