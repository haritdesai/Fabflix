<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">
<h1 align="center">Welcome to Shitty Netflix</h1>
<div align="center">
<%
    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("You're a bitch");
%>
</div><br>
</body>
</html>