<%-- 
    Document   : checkout
    Created on : Jul 7, 2024, 4:03:15 PM
    Author     : PC
--%>
<%@ page import="sample.product.Product"%>
<%@ page import="sample.product.Cart"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirm Information</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: linear-gradient(to right, #cb117a, #25dcfc);
                margin: 0;
                padding: 20px;
            }

            h1 {
                color: #1e37d8;
                text-align: center;
            }

            p {
                text-align: center;
                font-size: 1.2em;
            }

            table {
                width: 100%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            table, th, td {
                border: 1px solid #dee2e6;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            th {
                background-color: #007bff;
                color: #ffffff;
            }

            td {
                background-color: #f8f9fa;
            }

            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 5px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
            }

            input[type="submit"] {
                display: block;
                width: 100%;
                padding: 10px;
                margin: 20px 0;
                background-color: #007bff;
                color: #ffffff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            a {
                display: block;
                width: fit-content;
                margin: 0 auto;
                padding: 10px 20px;
                background-color: #0680bf;
                color: #ffffff;
                text-decoration: none;
                border-radius: 4px;
                text-align: center;
            }

            a:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <h1>Order Success</h1>
        <c:if test="${not empty requestScope.ERROR_MESSAGE}">
            <p style="color:red;">${requestScope.ERROR_MESSAGE}</p>
        </c:if>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:if test="${not empty cart}">
            <form action="MainController" method="POST">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="count" value="1"/>
                        <c:forEach var="product" items="${cart.cart.values()}">
                            <tr>
                                <td>${count}</td>
                                <td>
                                    <input type="text" name="id_" value="${product.productID}" readonly=""/>
                                </td>
                                <td>${product.name}</td>
                                <td>${product.price}$</td>
                                <td>
                                    <input type="number" name="quantity_" value="${product.quantity}" required=""/>
                                </td>
                                <td>${product.price * product.quantity}$</td>
                            </tr>
                            <c:set var="count" value="${count + 1}"/>
                        </c:forEach>
                    </tbody>
                </table>
                <input type="submit" name="action" value="Confirm"/>
            </form>
        </c:if>
        <c:if test="${empty cart}">
            <c:if test="${not empty requestScope.SUCCESS_MESSAGE}">
                <p style="color:#00ff00;">${requestScope.SUCCESS_MESSAGE}</p>
            </c:if>
            <c:if test="${empty requestScope.SUCCESS_MESSAGE}">
                <p style="color:red;">Checkout was not successful. Please try again.</p>
            </c:if>
        </c:if>
        <a href="ShoppingController">Buy more</a>
    </body>
</html>
