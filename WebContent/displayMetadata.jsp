<%@ page import ="java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.io.*" %>



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
                <li><a href="insertStar.jsp">Insert Star</a></li>
                <li><a href="insertMovie.jsp">Insert Movie</a></li>
                <li class="active"><a href="displayMetadata.jsp">Display Metadata</a></li>
                <li><a href="employeeLogout.jsp">Sign Out</a></li>
            </ul>
        </div>
    </nav>
</div>
<div class="container">
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("employee.jsp");
  }

  String file = application.getRealPath("/") + "pass.txt";
  BufferedReader br = new BufferedReader(new FileReader(file));
  String mysqlPass = br.readLine();
  br.close();

  Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "testuser", "testpass");



    DatabaseMetaData md;
    try {
        md = con.getMetaData();
        ResultSet rs = md.getTables(null, null, "%", null);
        
        out.print("<br><h4>Tables:</h4><ul class=\"collapsible\" data-collapsible=\"accordion\">");
        while (rs.next()) {
            out.print("<li><div class=\"collapsible-header\"><h5>" + rs.getString(3) + "</h5></div>");
            out.print("<div class=\"collapsible-body\"><table class=\"centered striped\"><thead><tr>");
            out.print("<th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th><th>Extra</th>");
            out.print("</tr></thead><tbody>");

            Statement tableSt = con.createStatement();
            ResultSet tableRs;
            tableRs = tableSt.executeQuery("DESCRIBE " + rs.getString(3));

            ResultSet rsColumns = md.getColumns(null, null, rs.getString(3), null);

            while (tableRs.next()) {
                out.print("<tr><td>" + tableRs.getString(1) + "</td><td>" + tableRs.getString(2) + "</td>");
                out.print("<td>" + tableRs.getString(3) + "</td><td>" + tableRs.getString(4) + "</td>");
                out.print("<td>" + tableRs.getString(5) + "</td><td>" + tableRs.getString(6) + "</td></tr>");
            }
            out.print("</tbody></table></div></li>");
        }
        out.print("</ul>");
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
%>
</div>
</div>


</body>
</html>