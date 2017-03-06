<%@ page import ="java.sql.*" %>
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
    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="js/materialize.min.js"></script>


    <title>Fabflix</title>

    <style type="text/css">
      #searchField{
        left: 150px;
        font-size: 15px;
      }

      #autoList{
        position: fixed;
        background: white;
        width: 18%;
        font-size: 15px;
      }
    </style>

    

</head>
<body>
    

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="logout.jsp">Sign Out</a></li>
</ul>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper container">
            <a href="browse.jsp" class="brand-logo brand-logo-small">
                <span class="bold">Fabflix</span>
            </a>
            <ul id="nav-mobile" class="right hide-on-med-and-down">
                <li class="input-field">
                    <input id="searchField" type="text" class="validate">
                    <label for="searchField">Quick Search:</label>
                    <div id="autoList" class="card white"></div>
                </li>
                <li><a id="subQS" class="waves-effect waves-light btn"><i class="material-icons">search</i></a></li>
                <li><a class="active" href="search.jsp"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="browse.jsp">Browse</a></li>
<%
                if (session.getAttribute("cart") != null)
                {
                    int quantity = ((HashMap<String,Integer>)session.getAttribute("cart")).size();
                    if (quantity > 0)
                    {
                    out.println("<li><a href=\"shoppingCart.jsp\">Cart<span class=\"new badge teal lighten-1\" data-badge-caption=\"\">"+quantity+"</span></a></li>");
                    }
                    else
                    {
                    out.println("<li><a href=\"shoppingCart.jsp\">Cart</a></li>");
                    }
                    out.println("<li><a class=\"dropdown-button\" data-beloworigin=\"true\" href=\"#!\" data-activates=\"dropdown1\">"+session.getAttribute("firstName")+"<i class=\"material-icons right\">arrow_drop_down</i></a></li>");
                }
                
%>
            </ul>
        </div>
    </nav>
</div>
<br>
<div class="container">
<%
  if (session.getAttribute("email") == null || session.getAttribute("password") == null) {
	  response.sendRedirect("index.jsp");
  }
%>
<br>
<div class="card white">
	<div class="card-content black-text">
		<span class="card-title" >Search</span>
			<div class="row">
            	<form class ="col s12" action="movieList.jsp" method="post">
                    <div class="row">
                  		<div class="input-field col s12">
          					<input id="title" name="title" type="text" class="validate">
         					<label for="title">Title</label>
        				</div>
        			</div>
        			<div class="row">
                        <div class="input-field col s6">
                            <input id="director" name="director" type="text" class="validate">
         					<label for="director">Director</label>
                        </div>
                        <div class="input-field col s6">
                        	<input id="year" name="year" type="text" class="validate">
         					<label for="year">Year</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s6">
                        	<input id="firstName" name="firstName" type="text" class="validate">
         					<label for="firstName">Star's First Name</label>
                        </div>
                        <div class="input-field col s6">
                        	<input id="lastName" name="lastName" type="text" class="validate">
         					<label for="lastName">Star's Last Name</label>
                        </div>
                    </div>
                	<div class="card-action">
                    	<button class="btn waves-effect waves-light" type="submit" name="search" value="Search">Submit
                    		<i class="material-icons right">send</i>
                    	</button>
                   	</div>
                </form>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">
    
    $(function(){
      $("#searchField").keyup(function(){
        $("#autoList").empty();

        $.post("autoComplete.jsp", {"searchStr": $("#searchField").val()}, function(data, status){
          // $("p").text(data); // prints query

          var arr = data.split("^");

          for(var i = 0; i < arr.length-1 && i < 5; i++){
            $("#autoList").append("<a class=\"searchList\" href=\"#\">"+arr[i]+"</a>");
          }

          $(".searchList").click(function(e){
            e.preventDefault();
            $("#searchField").val($(this).text());
          })
        });
      });

      $("#subQS").click(function(){
        window.location.href = "movieList.jsp?title=" + $("#searchField").val();
      })

      $("#searchField").focusin(function(){
        $("#autoList").show();
      });

      $("#searchField").focusout(function(){
        $("#autoList").hide(1000);
      });
    });
  </script>

</body>
</html>