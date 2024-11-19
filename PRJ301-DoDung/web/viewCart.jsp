
<%-- 
    Document   : addProduct
    Created on : Jul 3, 2024, 3:03:15 PM
    Author     : PC
--%>
<%@ page import="sample.user.UserDTO"%>
<%@ page import="sample.product.Cart"%>
<%@ page import="sample.product.Product"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PKL Store</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                 background: linear-gradient(to right, #cb117a9e, #25dcfcd4);
                display: flex;
                flex-direction: column;
                align-items: center;
                margin: 0;
                padding: 20px;
                color: #333;
            }
            h1 {
                margin: 20px 0;
                font-size: 2em;
                color: #fff;
            }
            .container {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                width: 90%;
                max-width: 1000px;
                text-align: center;
                margin-top: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 12px;
                text-align: center;
            }
            th {
                background-color: #007bff;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .btn-delete, .btn-edit {
                color: #dc3545;
                text-decoration: none;
                font-weight: bold;
                transition: color 0.3s ease;
            }
            .btn-delete:hover, .btn-edit:hover {
                color: #c82333;
            }
            .message {
                margin-top: 20px;
                font-size: 14px;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                padding: 10px;
                border-radius: 5px;
                width: fit-content;
                text-align: center;
                margin: 20px auto;
            }
            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                background-color: #007bff;
                color: white;
            }
            .btn:hover {
                background-color: #0056b3;
            }
            .total {
                margin: 20px 0;
                font-size: 1.5em;
                color: #333;
            }
            a {
                color: #007bff;
                text-decoration: none;
                transition: color 0.3s ease;
            }
            a:hover {
                color: #0056b3;
            }
        </style>
    </head>
    <body>
        <h1>Your product is here!</h1>
        <div class="container">
            <c:set var="loginUser" value="${sessionScope.LOGIN_USER}"/>
            <c:set var="cart" value="${sessionScope.CART}"/>
            <c:if test="${not empty cart}">
                <form action="MainController" method="POST">
                    <table>
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Remove</th>
                                <th>Edit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="count" value="1"/>
                            <c:set var="total" value="0"/>
                            <c:forEach var="product" items="${cart.cart.values()}">
                                <c:set var="productTotal" value="${product.price * product.quantity}"/>
                                <c:set var="total" value="${total + productTotal}"/>
                                <tr>
                                    <td><c:out value="${count}"/></td>
                                    <td>
                                        <input type="text" name="id" value="<c:out value="${product.productID}"/>" readonly=""/>
                                    </td>
                                    <td><c:out value="${product.name}"/></td>
                                    <td><c:out value="${product.price}"/>$</td>
                                    <td>
                                        <input type="number" min="1" name="quantity" value="<c:out value="${product.quantity}"/>" required=""/>
                                    </td>
                                    <td><c:out value="${productTotal}"/>$</td>
                                    <td>
                                        <a href="MainController?action=Remove&id=<c:out value="${product.productID}"/>" class="btn-delete">Delete</a>
                                    </td>
                                    <td>
                                        <input type="submit" name="action" value="Edit" class="btn-edit"/>
                                    </td>
                                </tr>
                                <c:set var="count" value="${count + 1}"/>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div class="total">Total: <c:out value="${total}"/> $</div>
                    <input type="submit" name="action" value="Checkout" class="btn"/>
                    <input type="hidden" name="total" value="<c:out value="${total}"/>"/>
                    <input type="hidden" name="userID" value="<c:out value="${loginUser.userID}"/>"/>
                </form>
                <a href="ShoppingController">Add more</a>
            </c:if>
            <c:if test="${empty cart}">
                <p>Your cart is empty!</p>
                <a href="ShoppingController">Buy something</a>
            </c:if>
        </div>
    </body>
</html>
