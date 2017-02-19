<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	try {
	    String title = request.getParameter("title");
	    String director = request.getParameter("director");
	    String year = request.getParameter("year");
	    String banner_url = request.getParameter("banner_url");
	    String trailer_url = request.getParameter("trailer_url");
	    String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");

	    //change to your own password
	    String file = application.getRealPath("/") + "pass.txt";
	    BufferedReader br = new BufferedReader(new FileReader(file));
	    String mysqlPass = br.readLine();
	    Class.forName("com.mysql.jdbc.Driver");
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
	            "root", mysqlPass);
	    PreparedStatement preparedStmt;
	    ResultSet rs;


		String queryString = "select * from movies where title = ?";
		preparedStmt = con.prepareStatement(queryString);
		preparedStmt.setString(1, title);
		rs = preparedStmt.executeQuery();
		if (rs.next()) {
		
		}

    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        response.sendRedirect("employee.jsp");
    }
%>