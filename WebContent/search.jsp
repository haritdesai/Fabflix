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
	out.println("You can search for movies by title, director, year, or star.");
    out.println("Begin your search by entering information below!");
%>
</div><br>

<form action="movieList.jsp"
      method="post">
  <div align="center">Title <input type="text" name="title"></div><br>

  <div align="center">Director <input type="text" name="director"></div><br>
  <div align="center">Year <input type="text" name="year"></div><br>
  <div align="center">Star's First Name <input type="text" name="firstName"></div><br>
  <div align="center">Star's Last Name <input type="text" name="lastName"></div><br>
  <div align="center"><input type="submit" name="search" value="Search"></div><br>
</form>

</body>
</html>