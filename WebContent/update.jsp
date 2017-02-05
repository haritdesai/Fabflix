<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	HashMap<String,Integer> cart = new HashMap<String,Integer>();
	cart = (HashMap<String,Integer>)session.getAttribute("cart");
	Set<String> toRemove = new HashSet<String>();
	
	for (Map.Entry<String,Integer> entry: cart.entrySet()) {
		//out.println(entry.getKey());
		//out.println(request.getParameter(entry.getKey()));
		cart.put(entry.getKey(), Integer.parseInt(request.getParameter(entry.getKey())));
		if (entry.getValue() == 0) {
			toRemove.add(entry.getKey());
		}
	}
	
	cart.keySet().removeAll(toRemove);
	
	response.sendRedirect("shoppingCart.jsp");
%>

</body>
</html>