<%-- 
    Document   : shopping
    Created on : Jun 15, 2024, 1:53:10 PM
    Author     : PC
--%>
<%@ page import="sample.product.Product" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>PKL Store</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            .container form {
                margin-bottom: 20px;
            }
            .container input[type="text"] {
                padding: 12px;
                margin-right: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
                width: 60%;
                max-width: 400px;
                box-sizing: border-box;
            }
            .container input[type="submit"] {
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                background-color: #4f8dd0;
                color: white;
            }
            .container input[type="submit"]:hover {
                background-color: #0056b3;
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
                background-color: #b50451;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            .btn-delete {
                color: #dc3545;
                text-decoration: none;
                font-weight: bold;
                transition: color 0.3s ease;
            }
            .btn-delete:hover {
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
            .error-message {
                margin-top: 20px;
                font-size: 14px;
                background-color: #f8d7da;
                border: 1px solid #f5c2c7;
                padding: 10px;
                border-radius: 5px;
                width: fit-content;
                text-align: center;
                margin: 20px auto;
            }
            .welcome {
                font-size: 2.5em;
                color: #c82333;
                margin: 20px 0;
            }
            .btn-container {
                display: flex;
                justify-content: center;
                gap: 20px;
            }
            .styled-button {
                color: white;
                background-color: #4f8dd0;
                text-decoration: none; 
                font-weight: bold; 
                height: 45px;
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                transition: background-color 0.3s ease, color 0.3s ease;
                display: inline-block;
                cursor: pointer;
            }

            .styled-button:hover {
                background-color: #0056b3;
                color: white;
            }
        </style>
    </head>
    <body>
        <h1>PKL Store</h1>
        <div class="container">
            <div class="welcome">WELCOME TO PKL STORE</div>
            <div class="btn-container">
                <form action="MainController" method="POST">
                    <input type="submit" name="action" value="View"/>
                </form>
                <form action="MainController" method="POST" style="display: flex;">
                    <span style="display: block;margin-top: 5px;margin-right: 10px;font-size: x-large;">Search: </span>
                    <input type="text" name="searchProduct" value="">
                    <input type="submit" name="action" value="Find">
                </form>
                <button class="styled-button" onclick="location.href = 'MainController?action=History'">History</button>
            </div>

            <c:choose>
                <c:when test="${not empty PRODUCT_LIST2}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Add</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${PRODUCT_LIST2}">
                                <tr>
                                    <td><c:out value="${product.productID}"/></td>
                                    <td><c:out value="${product.name}"/></td>
                                    <td><c:out value="${product.price}"/> $</td>
                                    <td>
                                        <form action="MainController" method="POST">
                                            <input type="hidden" name="cmbProduct" value="${product.productID}-${product.name}-${product.price}">
                                            <select name="cmbQuantity">
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="10">10</option>
                                                <option value="50">50</option>
                                            </select>
                                    </td>
                                    <td>
                                        <input type="submit" name="action" value="Add"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:when test="${not empty PRODUCT_LIST}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Add</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${PRODUCT_LIST}">
                                <tr>
                                    <td><c:out value="${product.productID}"/></td>
                                    <td><c:out value="${product.name}"/></td>
                                    <td><c:out value="${product.price}"/> $</td>
                                    <td>
                                        <form action="MainController" method="POST">
                                            <input type="hidden" name="cmbProduct" value="${product.productID}-${product.name}-${product.price}">
                                            <select name="cmbQuantity">
                                                <option value="1">1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="10">10</option>
                                                <option value="50">50</option>
                                            </select>
                                    </td>
                                    <td>
                                        <input type="submit" name="action" value="Add"/>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="error-message">No products found.</div>
                </c:otherwise>
            </c:choose>

            <form action="MainController">
                <input type="submit" name="action" value="Logout" style="
                       width: 195px;
                       height: 47px;
                       background-color: #ff5b8c;
                       margin-bottom: 10px;
                       font-size: medium;
                       margin-top: 10px;
                       color: indigo;
                       border-radius: 10px;
                       "/>
            </form>

            <c:if test="${not empty MESSAGE}">
                <div class="message"><c:out value="${MESSAGE}"/></div>
            </c:if>
        </div>
    </body>
</html>
