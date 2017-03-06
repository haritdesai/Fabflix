<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.io.*" %>

<%
    HashMap<String,Integer> cart = new HashMap<String,Integer>();
	cart = (HashMap<String,Integer>)session.getAttribute("cart");
	String item = (String)session.getAttribute("id");
	if(item != null || item != "")
		item = request.getParameter("id");
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