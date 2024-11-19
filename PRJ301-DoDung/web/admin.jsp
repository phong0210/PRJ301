<%-- 
    Document   : admin
    Created on : May 29, 2024, 2:32:37 PM
    Author     : PC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="sample.user.UserDTO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Administrator Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #cb117a, #25dcfc);
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #333;
        }
        h1 {
            margin-top: 20px;
            font-size: 28px;
            color: #fff;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 80%;
            max-width: 800px;
            margin-top: 20px;
        }
        .container form {
            margin-bottom: 20px;
        }
        .container input[type="text"] {
            padding: 10px;
            margin-right: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            width: 70%;
            box-sizing: border-box;
        }
        .container input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            background-color: #007bff;
            color: white;
        }
        .container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 95%;
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
            background-color: #f2f2f2;
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
        .error-message {
            color: #dc3545;
            margin-top: 20px;
            font-size: 14px;
            background-color: #f8d7da;
            border: 1px solid #f5c2c7;
            padding: 10px;
            border-radius: 5px;
            width: fit-content;
            margin: 20px auto;
            text-align: center;
        }
        button {
            background-color: #4cafa6;
            border-radius: 15px;
            color: white;
            padding: 10px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        .success-message {
            color: #08700f;
            margin-top: 20px;
            font-size: 14px;
            background-color: #baf5de;
            border: 1px solid #f5c2c7;
            padding: 10px;
            border-radius: 5px;
            width: fit-content;
            margin: 20px auto;
            text-align: center;
        }
    </style>
</head>
<body>
    <c:set var="checkRole" value="AD" />
    <c:set var="loginUser" value="${sessionScope.LOGIN_USER}" />
    <c:choose>
        <c:when test="${empty loginUser or not checkRole eq loginUser.roleID}">
            <c:redirect url="login.html" />
        </c:when>
        <c:otherwise>
            <h1>Welcome: ${loginUser.fullName}</h1>

            <form action="MainController">
                <input type="submit" name="action" value="Logout" style="width: 195px; height: 30px; background-color: cyan; margin-bottom: 10px; font-size: medium; color: indigo; border-radius: 10px;"/>
            </form>

            <form action="MainController">
                <span style="font-size: x-large;color: floralwhite;margin-right: 10px;">Search:</span>
                <input type="text" name="search" value="${fn:escapeXml(search)}" style="width: 310px; height: 25px;"/>
                <input type="submit" name="action" value="Search" style="height: 30px; width: 75px; font-weight: bolder; box-shadow: 0 4px 6px rgb(234 0 0); transition: box-shadow 0.3s ease; border-radius: 9px;" onmouseover="this.style.boxShadow = '0 8px 12px rgba(0, 0, 0, 0.2)'" onmouseout="this.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)'"/>
            </form>

            <button onclick="location.href = 'MainController?action=AddProduct_Page'">Create Product</button>

            <c:if test="${not empty requestScope.LIST_USER and fn:length(requestScope.LIST_USER) > 0}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Role ID</th>
                            <th>Password</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${requestScope.LIST_USER}" varStatus="loop">
                            <form action="MainController" method="POST">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${user.userID}</td>
                                    <td><input type="text" name="fullName" value="${user.fullName}" required/></td>
                                    <td><input type="text" name="roleID" value="${user.roleID}" required/></td>
                                    <td>${user.password}</td>
                                    <td>
                                        <input type="submit" name="action" value="Update"/>
                                        <input type="hidden" name="userID" value="${user.userID}"/>
                                        <input type="hidden" name="search" value="${search}"/>
                                    </td>
                                    <td>
                                        <a href="MainController?action=Delete&userID=${user.userID}&search=${search}">Delete</a>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>

            <c:if test="${empty requestScope.LIST_USER}">
                <div class="error-message">No users found.</div>
            </c:if>

            <c:if test="${not empty requestScope.ERROR}">
                <div class="error-message">${requestScope.ERROR}</div>
            </c:if>

            <c:if test="${not empty requestScope.DELETE_SUCCESS}">
                <div class="success-message">${requestScope.DELETE_SUCCESS}</div>
            </c:if>
        </c:otherwise>
    </c:choose>
</body>
</html>
