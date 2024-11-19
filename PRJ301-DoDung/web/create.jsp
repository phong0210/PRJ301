<%-- 
    Document   : create
    Created on : Jun 12, 2024, 1:43:36 PM
    Author     : PC
--%>

<%@page import="sample.user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
        <title>Create Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
            UserError userError=(UserError)request.getAttribute("USER_ERROR");
            if(userError==null){
                userError=new UserError();
            }
        %>
        
        <form action="MainController" method="POST">
            <div> Create new user</div>
            User ID <input type="text" name="userID" required=""/><%= userError.getUserIDError() %>
            </br> Full Name <input type="text" name="fullName" required="" /><%= userError.getFullNameError() %>
            </br> Role ID <input type="text" name="roleID" value="US" readonly=""/>
            </br> Password <input type="password" name="password" required=""/>
            </br> Confirm <input type="password" name="confirm" required=""/><%= userError.getConfirmError() %>
            </br><input type="submit" name="action" value="Create" />
            <input type="reset" value="Reset" /><%= userError.getError() %>
        </form>
    </body>
    
</html>
