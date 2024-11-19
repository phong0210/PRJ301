<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Top User</title>
    </head>
    <body>
        <h1>Top User</h1>
        <%
            UserDTO topUser = (UserDTO) request.getAttribute("TOP_USER");
            if (topUser != null) {
        %>
            <p>ID: <%= topUser.getUserID() %></p>
            <p>Full Name: <%= topUser.getFullName() %></p>
        <%
            } else {
        %>
            <p>No user found.</p>
        <%
            }
        %>
    </body>
</html>
