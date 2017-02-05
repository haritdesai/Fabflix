<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>
<!DOCTYPE html>
<html>
<head>
  <title>Fabflix</title>
</head>

<body BGCOLOR="#FDF5E6">
<h1 align="center">Added to Cart</h1>
<div align="center">
<%
    HashMap<String,Integer> cart = new HashMap<String,Integer>();
	cart = (HashMap<String,Integer>)session.getAttribute("cart");
	String item = (String)session.getAttribute("id");
	//out.println(item);
	if (cart.containsKey(item)) {
 		cart.put(item,cart.get(item)+1);
 	} else {
 		cart.put(item,1);
 	}
	response.sendRedirect("shoppingCart.jsp");
	/*
	out.println(item + " was added to cart" + "<br></br>");
	session.setAttribute("cart", cart);
	
	String url = (String)session.getAttribute("url");
	String id = (String)session.getAttribute("id");
	String browse = "browse.jsp";
	String shop = "shoppingCart.jsp";
	
	out.println("<a href=" + url + "?id=" + id + ">Back to Movie</a>" + "<br></br>");
	out.println("<a href=" + browse + ">Back to Browse</a>" + "<br></br>");
	out.println("<a href=" + shop + ">Shopping Cart</a>");
	*/
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