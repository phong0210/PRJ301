/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.utils.DBUtils;
import sample.product.Order;

/**
 *
 * @author PC
 */
public class OrderDAO {
    private static final String INSERT_ORDER = "INSERT INTO tbl_Order (orderID,userID, total, date) VALUES (?,?,?,?)";
    private static final String INSERT_ORDER_DETAIL = "INSERT INTO tbl_OrderDetail (orderID, productID, price, quantity) VALUES (?,?,?,?)";
    private static final String HISTORY = "SELECT orderID, userID, total, date, status FROM tbl_Order WHERE userID=? ORDER BY date DESC";

    public boolean insertOrder(Order order) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            BigDecimal totalDecimal = new BigDecimal(order.getTotal()).setScale(2, BigDecimal.ROUND_HALF_UP);
            conn = DBUtils.getConnection();
            if (conn != null) {
               
                ptm = conn.prepareStatement(INSERT_ORDER);
                ptm.setString(1, order.getOrderID());
                ptm.setString(2, order.getUserID());
                ptm.setBigDecimal(3,totalDecimal);
                ptm.setString(4,order.getDate());
                check = ptm.executeUpdate() > 0;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean insertOrderDetail(OrderDetail orderdetails) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            BigDecimal pricelDecimal = new BigDecimal(orderdetails.getPrice()).setScale(2, BigDecimal.ROUND_HALF_UP);
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_ORDER_DETAIL);
                ptm.setString(1, orderdetails.getOrderID());
                ptm.setString(2, orderdetails.getProductID());
                ptm.setBigDecimal(3, pricelDecimal);
                ptm.setInt(4, orderdetails.getQuantity());
                check = ptm.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Print the exception stack trace
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public Object getOrderHistory(String userID) throws Exception {
         List<Order> orderHistory = new ArrayList<>();
        try (Connection con = DBUtils.getConnection();
                PreparedStatement pst = con.prepareStatement(HISTORY)) {
            pst.setString(1, userID);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    String orderID = rs.getString("orderID");
                    float total = rs.getFloat("total");
                    String date = rs.getString("date");
                    int status = rs.getInt("status");
                    Order order = new Order(orderID, userID, total, date, status);
                    orderHistory.add(order);
                }
            }
        } catch (Exception e) {
            throw new Exception("Error retrieving order history: " + e.getMessage());
        }
        return orderHistory;
    }


}
