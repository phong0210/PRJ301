/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.product;

import java.util.Date;

/**
 *
 * @author PC
 */
public class Order {
    private String orderID;
    private String userID;
    private double total;
    private String date;
    private int status;

    public Order() {
    }

    public Order(String OrderID, String UserID, double total, String date, int status) {
        this.orderID = OrderID;
        this.userID = UserID;
        this.total = total;
        this.date = date;
        this.status = status;
    }


    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String OrderID) {
        this.orderID = OrderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String UserID) {
        this.userID = UserID;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }


    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
}
