package sample.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.product.Cart;
import sample.product.Order;
import sample.product.OrderDAO;
import sample.product.Product;
import sample.product.ProductDAO;
import sample.product.OrderDetail;
/**
 *
 * @author PC
 */
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "viewCart.jsp";
    private static final String SUCCESS = "checkout.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        boolean checkOrder = false;
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");

            float total = Float.parseFloat(request.getParameter("total"));
            String userID = request.getParameter("userID");

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String dateOrder = sdf.format(new Date());

            String orderID = UUID.randomUUID().toString();

            Order order = new Order(orderID, userID, total, dateOrder, 1);

            OrderDAO orderDAO = new OrderDAO();
            orderDAO.insertOrder(order);

            if (cart == null || cart.getCart().isEmpty()) {
                request.setAttribute("ERROR_MESSAGE", "Cart empty.");
                request.getRequestDispatcher(ERROR).forward(request, response);
                return;
            }

            ProductDAO dao = new ProductDAO();
            for (Product products : cart.getCart().values()) {
                String productID = products.getProductID();
                double price = (double) products.getPrice();
                int quantity = products.getQuantity();
                
                if(products.getQuantity()> dao.checkQuanity(productID)){
                    request.setAttribute("ERROR_MESSAGE", "Not enough product in stock");
                    request.getRequestDispatcher(ERROR).forward(request, response);
                    break;
                }
                OrderDetail orderDetail = new OrderDetail(orderID, productID, price, quantity, 1);
                checkOrder = orderDAO.insertOrderDetail(orderDetail);
               
                dao.updateQuantity(productID, quantity);

                if (!checkOrder) {
                    break;
                }

            }

            if (checkOrder) {
                session.removeAttribute("CART");
                url = SUCCESS;
                request.setAttribute("SUCCESS_MESSAGE", "Thank You For Order");
            }

        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
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
        return "Checkout Controller";
    }
}
