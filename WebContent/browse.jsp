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
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", "ryanjew");
    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("You're a bitch");
%>
</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browseByMovieGenre.jsp">Browse by Movie Genre</a><br>
<a align="center" href="browseByMovieTitle.jsp">Browse by Movie Title</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingCart.jsp">Cart</a><br>
<div>

</div>
</body>
</html>