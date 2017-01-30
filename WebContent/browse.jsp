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
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browseByMovieGenre.jsp">Browse by Movie Genre</a><br>
<a align="center" href="browseByMovieTitle.jsp">Browse by Movie Title</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingcart.jsp">Cart</a><br>
<div>
<%
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", "ryanjew");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from genres");
    while (rs.next()) {
        out.println("<a href=\"#" + rs.getString(2) + "\">" + rs.getString(2) + "</a><br>");
    }
%>
</div>
</body>
</html>