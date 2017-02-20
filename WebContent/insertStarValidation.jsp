<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
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
	    
	    //change to your own password
	    String file = application.getRealPath("/") + "pass.txt";
	    BufferedReader br = new BufferedReader(new FileReader(file));
	    String mysqlPass = br.readLine();
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
	            "root", mysqlPass);
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
        out.println(0);
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
            out.println(1);
        }
        else {
        	sqlQuery = "INSERT INTO stars (first_name, last_name, dob, photo_url) VALUES (?, ?, ?, ?)";
            preparedStmt = con.prepareStatement(sqlQuery);
            preparedStmt.setString(1, firstName);
            preparedStmt.setString(2, lastName);
            preparedStmt.setDate(3, dob);
            preparedStmt.setString(4,photo_url);
            preparedStmt.execute();
            out.println(2);
        }
		
	response.sendRedirect("insertConfirmation.jsp");
    } catch (SQLException e) {
        // TODO Auto-generated catch block
        out.print(e.getMessage());
    }
%>