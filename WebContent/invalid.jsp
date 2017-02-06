<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <!--Import materialize.css-->
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
    <!--Import fabflix.css-->
    <link type="text/css" rel="stylesheet" href="css/fabflix.css"/>
    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Fabflix</title>
</head>
<body>
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="/mywebapp/logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="/mywebapp/browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="browse.jsp">Browse</a></li>
<%
                int quantity = ((HashMap<String,Integer>)session.getAttribute("cart")).size();
                if (quantity > 0)
                {
                out.println("<li><a href=\"shoppingCart.jsp\">Cart<span class=\"new badge teal lighten-1\" data-badge-caption=\"\">"+quantity+"</span></a></li>");
                }
                else
                {
                out.println("<li><a href=\"shoppingCart.jsp\">Cart</a></li>");
                }
                out.println("<li><a class=\"dropdown-button\" data-beloworigin=\"true\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
%>
            </ul>
        </div>
    </nav>
</div>
<br>

<div class="container">
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
                	<span class="card-title">Confirmation Failed</span>
                	<p>Cart empty or invalid credit card information</p>
                </div>
                <div class="card-action">
                    <a class="waves-effect waves-light btn" href="shoppingCart.jsp">Back</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>