<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">
<h1 align="center">Shopping Cart</h1>
<div align="center">
<%
	if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
	}

    out.println("Welcome " + session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ". ");
    out.println("<br></br>");
    out.println("Movies:");
    
    Map<String,Integer> cart = (HashMap<String,Integer>)session.getAttribute("cart");
    
    if (!cart.isEmpty()) {
	    for (Map.Entry<String,Integer> entry: cart.entrySet())
	    	out.println("<br></br>" + entry.getKey() + ": " + entry.getValue());
    }
    
%>

</div><br>
<a align="center" href="search.jsp">Search</a><br>
<a align="center" href="browse.jsp">Browse</a><br>
<a align="center" href="movieList.jsp">Movie List</a><br>
<a align="center" href="movie.jsp">Movie</a><br>
<a align="center" href="star.jsp">Star</a><br>
<a align="center" href="shoppingCart.jsp">Cart</a><br>

</body>
</html>