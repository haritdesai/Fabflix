<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
    String email = request.getParameter("email");    
    String password = request.getParameter("password");
    session.setAttribute("email", email);
    session.setAttribute("password", password);
    Class.forName("com.mysql.jdbc.Driver");

    //change to your own password
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();
    br.close();


    /*	For use in shopping cart	*/
	HashMap<String,Integer> cart = new HashMap<String,Integer>();
	session.setAttribute("cart", cart);

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "testuser", "testpass");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from employees where email='" + email + "' and password='" + password + "'");
    if (rs.next()) {
        session.setAttribute("email", rs.getString(1));
        session.setAttribute("fullname", rs.getString(3));
        response.sendRedirect("dashboard.jsp");
    } else {
    	session.invalidate();
        request.setAttribute("errorMessage", "Invalid email or password");
        RequestDispatcher rd = request.getRequestDispatcher("employee.jsp");
        rd.forward(request, response);       
    }
%>