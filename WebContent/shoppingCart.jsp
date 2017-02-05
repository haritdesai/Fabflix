<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
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

<%
String file = application.getRealPath("/") + "pass.txt";
BufferedReader br = new BufferedReader(new FileReader(file));
String mysqlPass = br.readLine();

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
        "root", mysqlPass);

Class.forName("com.mysql.jdbc.Driver").newInstance();

	if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
		 response.sendRedirect("index.jsp");
	}
	HashMap<String,Integer> cart = new HashMap<String,Integer>();
	cart = (HashMap<String,Integer>)session.getAttribute("cart");

%>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="/mywebapp">Sign Out</a></li>
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
                <li class="active"><a href="shoppingCart.jsp">Cart</a></li>
<%
                out.println("<li><a class=\"dropdown-button\" data-beloworigin=\"true\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
%>
            </ul>
        </div>
    </nav>
</div>
<br>
<form action="update.jsp" method="post">
<table>
        <thead>
          <tr>
              <th data-field="title">Title</th>
              <th data-field="quantity">Quantity</th>
              <th data-field="price">Item Price</th>
          </tr>
        </thead>

        <tbody>
          	<% 
          	for (Map.Entry<String,Integer> entry: cart.entrySet()) {
          		String query = "select * from movies ";
          		query += "where id=" + entry.getKey();
          		ResultSet moviesRs;
          		Statement moviesSt = con.createStatement();
          		moviesRs = moviesSt.executeQuery(query);
          		out.println("<tr>");
          		while(moviesRs.next()){
          			out.println("<td>" + moviesRs.getString(2) + "</td>"); 
          		}
          		out.println("<td>" + "<input type=" + "text" + " name=" + entry.getKey() + " value=" + entry.getValue() + ">" + "</td>");
          		out.println("<td>$5.00</td>");
      			out.println("<tr>");
          	}
          	%>
        </tbody>
      </table>
      <input type="submit" value="Update Quantities">
</form>

<a href="customerInformation.jsp">Checkout</a>

</body>
</html>