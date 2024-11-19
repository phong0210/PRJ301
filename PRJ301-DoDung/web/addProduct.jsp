<%-- 
    Document   : addProduct
    Created on : Jul 7, 2024, 4:03:15 PM
    Author     : PC
--%>

<%@ page import="sample.user.UserError"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>ADD NEW PRODUCT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #cb117a9e, #25dcfcd4);
            margin: 0;
            padding: 20px;
        }

        form {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        form div {
            margin-bottom: 15px;
            font-weight: bold;
        }

        form input[type="text"],
        form input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
        }

        form input[type="submit"],
        form input[type="reset"] {
            padding: 10px 20px;
            margin-top: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        form input[type="submit"] {
            background-color: #007bff;
            color: #ffffff;
        }

        form input[type="reset"] {
            background-color: #ff0071;
            color: #ffffff;
        }

        form input[type="submit"]:hover {
            background-color: #279710;
        }

        form input[type="reset"]:hover {
            background-color: #3e82cc;
        }

        .type {
            display: flex;
            justify-content: space-between;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .success {
            color: green;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <c:set var="userError" value="${requestScope.USER_ERROR}" />
    <c:if test="${userError == null}">
        <c:set var="userError" value="${UserError}" />
    </c:if>
    
    <c:choose>
        <c:when test="${not empty userError}">
            <div class="error">${userError.message}</div>
        </c:when>
        <c:otherwise>
            <div class="success">Product added successfully!</div>
        </c:otherwise>
    </c:choose>

    <form action="MainController" method="POST">
        <div>Add new product</div>
        <label for="productID">Product ID</label>
        <input type="text" id="productID" name="productID" required/><br/>
        <label for="name">Product Name</label>
        <input type="text" id="name" name="name" required/><br/>
        <label for="price">Product Price</label>
        <input type="number" id="price" name="price" min="1" required/><br/>
        <label for="quantity">Product Quantity</label>
        <input type="number" id="quantity" name="quantity" min="1" required/><br/>
        <div class="type">
            <input type="submit" name="action" value="AddProduct" />
            <input type="reset" value="Reset" />
            
        </div>
    </form>
</body>
</html>

