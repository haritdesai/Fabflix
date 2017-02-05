<%@ page import ="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
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

    //change to your own password
    String file = application.getRealPath("/") + "pass.txt";
    BufferedReader br = new BufferedReader(new FileReader(file));
    String mysqlPass = br.readLine();

    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/moviedb",
            "root", mysqlPass);
    Statement st = con.createStatement();
    ResultSet rs;

    rs = st.executeQuery("select * from creditcards where id='" + ccid + "' and first_name='" + firstName + "' and last_name='" + lastName + "' and expiration='" + expiration + "'");
    if (rs.next()) {
        out.println("Wheeee we good. Your order is shizzzzz");
    } else {
    	out.println("fuck you");
    }
%>