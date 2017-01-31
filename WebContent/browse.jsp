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
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingCart.jsp">Cart</a><br>
<br>
<div align ="center">
<%
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from genres");
    while (rs.next()) {
        out.println("<a href=\"browseByMovieGenre.jsp?genre=" + rs.getString(1) + "\">" + rs.getString(2) + "</a>");
        out.print(" | ");
    }
    out.println("<br>");
    out.println("<br>");

    for(char alphabet = 'A'; alphabet <= 'Z'; alphabet++) 
	{
    	out.print("<a href= \"browseByMovieTitle.jsp?title=" + alphabet + "\">" + alphabet + "</a>");
    	out.print(" | ");
	}
	out.println("<a href=\"browseByMovieTitle.jsp?title=0\">#</a>");
%>
</div>
</body>
</html>