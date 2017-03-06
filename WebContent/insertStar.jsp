<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import = "java.util.*" %>
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
    <title>Dashboard</title>
</head>
<body>
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>

<%
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    br.close();
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "testuser", "testpass");

%>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="dashboard.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix - Dashboard</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li class="active"><a href="insertStar.jsp">Insert Star</a></li>
                <li><a href="insertMovie.jsp">Insert Movie</a></li>
                <li><a href="displayMetadata.jsp">Display Metadata</a></li>
                <li><a href="employeeLogout.jsp">Sign Out</a></li>
            </ul>
        </div>
    </nav>
</div>
<br>
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
      response.sendRedirect("employee.jsp");
  }
%>
<br>
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
                    <span class="card-title">Insert Star</span>
                    <div class="row">
                        <form class="col s12" action="insertStarValidation.jsp" method="post">
                            <div class="row">
                                <div class="input-field col s6">
                                    <input type="text" id="firstName" name="firstName">
                                    <label for="firstName">First Name</label>
                                </div>
                                <div class="input-field col s6">
                                    <input type="text" id="lastName" name="lastName">
                                    <label for="firstName">Last Name</label>
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
                                    <label>Birth Month</label>
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
                                    <label>Birth Day</label>
                                </div>
                                <div class ="input-field col s4 ">
                                    <select name="year">
                                        <%
                                        for (int i = 0; i <= 110; i++) {
                                            out.println("<option value=\""+(1907+i)+"\">" +(1907+i)+ "</option>");
                                        }
                                        %>
                                    </select>
                                    <label>Birth Year</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s12">
                                    <input type="text" id="photoUrl" name="photoUrl">
                                    <label for="photoUrl">Photo URL</label>
                                </div>
                            </div>
                <div class="card-action">
                    <a class="waves-effect waves-light btn" href="dashboard.jsp">Back</a>
                    <button class="btn waves-effect waves-light" type="submit" name="order" value="order">Submit
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