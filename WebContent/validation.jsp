<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.*" %>
<%
	try {
	    String ccid = request.getParameter("ccid");    
	    String firstName = request.getParameter("firstName");
	    String lastName = request.getParameter("lastName");
	    String month = request.getParameter("month");
	    String day = request.getParameter("day");
	    String year = request.getParameter("year");
	    String date = year+"-"+month+"-"+day;
	    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    Date parsed = format.parse(date);
	    java.sql.Date expiration = new java.sql.Date(parsed.getTime());
	
	    HashMap<String,Integer> cart = new HashMap<String,Integer>();
	    cart = (HashMap<String,Integer>)session.getAttribute("cart");
	    String c_id = (String)session.getAttribute("userid");
	    
	    Date today = new Date();//Today Date 
	    String todayFormatted = format.format(today);
	    
	    //change to your own password
	    String file = application.getRealPath("/") + "pass.txt";
	    BufferedReader br = new BufferedReader(new FileReader(file));
	    String mysqlPass = br.readLine();
	
	    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
	            "root", mysqlPass);
	    PreparedStatement st;
	    ResultSet rs;

		String queryString = "select * from creditcards where id= ? and first_name= ? and last_name= ? and expiration= ?";
		st = con.prepareStatement(queryString);
		st.setString(1, ccid);
		st.setString(2, firstName);
		st.setString(3, lastName);
		st.setDate(4, expiration);

	    rs = st.executeQuery("select * from creditcards where id='" + ccid + "' and first_name='" + firstName + "' and last_name='" + lastName + "' and expiration='" + expiration + "'");
	    if (rs.next() && !cart.isEmpty()) {
	    	for (Map.Entry<String,Integer> entry: cart.entrySet()) {
		    	Statement ST = con.createStatement();
		    	//out.println("insert into sales (customer_id, movie_id, sale_date) values (" + "'" + c_id + "'" + ", " + "'" + entry.getKey() +"'"+ ", " + "'"+todayFormatted+"'" + ")");
		    	ST.executeUpdate("insert into sales (customer_id, movie_id, sale_date) values (" + "'" + c_id + "'" + ", " + "'" + entry.getKey() +"'"+ ", " + "'"+todayFormatted+"'" + ")");
	    	}
	        response.sendRedirect("confirmation.jsp");
	    } else {
	    	response.sendRedirect("invalid.jsp");
	    }
    } catch (Exception e) {
    	response.sendRedirect("customerInformation.jsp");
    }

%>