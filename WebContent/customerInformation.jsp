<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <!--Import Google Icon Font-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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

<%
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);

%>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li><a href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="browse.jsp">Browse</a></li>
<%
                if (session.getAttribute("cart") != null)
                {
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
                }
                
%>
            </ul>
        </div>
    </nav>
</div>
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
      response.sendRedirect("index.jsp");
  }
%>
<br>
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
                    <span class="card-title">Confirm Credit Card Information</span>
                    <div class="row">
                        <form class="col s12" action="validation.jsp" method="post">
                            <div class="row">
                                <div class="input-field col s12">
                                    <input type="text" id="ccid" name="ccid">
                                    <label for="ccid">Credit Card Number</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s4">
                                    <select name="month">
                                        <%
                                        for (int i = 1; i <= 9; i++) {
                                            out.println("<option value=\"0"+i+"\">" +i+ "</option>");
                                        }
                                        for (int i = 1; i <= 12; i++) {
                                            out.println("<option value=\""+i+"\">" +i+ "</option>");
                                        }
                                        %>
                                    </select>
                                    <label>Expiration Month</label>
                                </div>
                                <div class="input-field col s4">
                                    <select name="day">
                                        <%
                                        for (int i = 1; i <= 9; i++) {
                                            out.println("<option value=\"0"+i+"\">" +i+ "</option>");
                                        }
                                        for (int i = 10; i <= 31; i++) {
                                            out.println("<option value=\""+i+"\">" +i+ "</option>");
                                        }
                                        %>
                                    </select>
                                    <label>Expiration Day</label>
                                </div>
                                <div class ="input-field col s4 ">
                                    <select name="year">
                                        <%
                                        for (int i = 0; i <= 30; i++) {
                                            out.println("<option value=\""+(2000+i)+"\">" +(2000+i)+ "</option>");
                                        }
                                        %>
                                    </select>
                                    <label>Expiration Year</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s6">
                                    <input type="text" id="firstName" name="firstName">
                                    <label for="firstName">First Name</label>
                                </div>
                                <div class="input-field col s6">
                                    <input type="text" id="lastName" name="lastName">
                                    <label for="lastName">Last Name</label>
                                </div>
                            </div>
                <div class="card-action">
                    <a class="waves-effect waves-light btn" href="shoppingCart.jsp">Back</a>
                    <button class="btn waves-effect waves-light" type="submit" name="order" value="order">Submit Order
                      <i class="material-icons right">send</i>
                    </button>
                    </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
$(document).ready(function() {
    $('select').material_select();
});   
</script>
</html>