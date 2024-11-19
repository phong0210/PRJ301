
<%-- 
    Document   : addProduct
    Created on : Jul 5, 2024, 4:03:15 PM
    Author     : PC
--%>
<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>  
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(to right, #cb117a9e, #25dcfcd4);
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                color: #333;
            }

            .container {
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                max-width: 400px;
                width: 100%;
                text-align: center;
            }

            h1 {
                color: #007bff;
                margin-bottom: 20px;
                font-size: 1.8em;
            }

            .info {
                text-align: left;
                margin-bottom: 20px;
                line-height: 1.6;
            }

            .info div {
                margin-bottom: 10px;
                font-size: 1.1em;
            }

            .info span {
                font-weight: bold;
                color: #555;
            }

            .actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-top: 20px;
            }

            .actions input[type="submit"] {
                padding: 10px 20px;
                background-color: #dc3545;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .actions input[type="submit"]:hover {
                background-color: #c82333;
            }

            .actions a {
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                transition: background-color 0.3s;
            }

            .actions a:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Login User's Information</h1>
            <c:choose>
                <c:when test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.roleID != 'US'}">
                    <c:redirect url="login.html"/>
                </c:when>
                <c:otherwise>
                    <div class="info">
                        <div>User ID: <span><c:out value="${sessionScope.LOGIN_USER.userID}"/></span></div>
                        <div>Full Name: <span><c:out value="${sessionScope.LOGIN_USER.fullName}"/></span></div>
                        <div>Role ID: <span><c:out value="${sessionScope.LOGIN_USER.roleID}"/></span></div>
                        <div>Password: <span><c:out value="${sessionScope.LOGIN_USER.password}"/></span></div>
                    </div>
                    <form action="MainController" method="POST" class="actions">
                        <input type="submit" name="action" value="Logout"/>
                        <a href="MainController?action=Shopping_Page">PKL Store</a>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </body>
</html>
