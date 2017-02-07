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

    /*	For use in shopping cart	*/
	HashMap<String,Integer> cart = new HashMap<String,Integer>();
	session.setAttribute("cart", cart);

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from customers where email='" + email + "' and password='" + password + "'");
    if (rs.next()) {
        session.setAttribute("userid", rs.getString(1));
        session.setAttribute("firstName", rs.getString(2));
        session.setAttribute("lastName", rs.getString(3));
        response.sendRedirect("browse.jsp");
    } else {
    	session.invalidate();
        request.setAttribute("errorMessage", "Invalid email or password");
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);       
    }
%>