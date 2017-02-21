<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
    <div class="row">
        <div class="col s12 m6 offset-m3">
            <div class="card white">
                <div class="card-content black-text">
<%
	try {
	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");
	    String month = request.getParameter("month");
	    String day = request.getParameter("day");
	    String year = request.getParameter("year");
	    String date = year+"-"+month+"-"+day;
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Date parsed = format.parse(date);
	    java.sql.Date dob = new java.sql.Date(parsed.getTime());
	    String photo_url = request.getParameter("photoUrl");
	    
	    PreparedStatement preparedStmt;
	    ResultSet rs;

	    if (lastName.equals("") && !firstName.equals(""))
	    {
	    	lastName = firstName;
	    	firstName = "";
	    }
	    else if (lastName.equals("") && firstName.equals(""))
	    {
	    	response.sendRedirect("insertStar.jsp");
	    }

	    String sqlQuery = "select * from stars where first_name = ? and last_name = ?";
	    preparedStmt = con.prepareStatement(sqlQuery);
        preparedStmt.setString(1, firstName);
        preparedStmt.setString(2, lastName);
        rs = preparedStmt.executeQuery();
        if (rs.next()) {
        	sqlQuery = "update stars set dob = ? , photo_url = ? where id = ?";
        	preparedStmt = con.prepareStatement(sqlQuery);
            preparedStmt.setDate(1, dob);
            if (!photo_url.isEmpty()) {
            	preparedStmt.setString(2, photo_url);
            }
            else {
            	preparedStmt.setString(2, rs.getString(5));
            }
            preparedStmt.setInt(3, rs.getInt(1));
            preparedStmt.execute();
        }
        else {
        	sqlQuery = "INSERT INTO stars (first_name, last_name, dob, photo_url) VALUES (?, ?, ?, ?)";
            preparedStmt = con.prepareStatement(sqlQuery);
            preparedStmt.setString(1, firstName);
            preparedStmt.setString(2, lastName);
            preparedStmt.setDate(3, dob);
            preparedStmt.setString(4,photo_url);
            preparedStmt.execute();
        }
		
	out.println("<span class=\"card-title\">Insertion Confirmed!</span>");
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.println("<span class=\"card-title\">Insertion Failed</span>");
    }
%>


                    
                </div>
            </div>
        </div>
    </div>
</div>

</body>

</html>