<!DOCTYPE html>

<html>

  <head>

  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
  <link type="text/css" rel="stylesheet" href="css/fabflix.css"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <script type="text/javascript" src="js/materialize.min.js"></script>

  <script>
    $(function(){
      $("#searchField").keyup(function(){
        $("#autoList").empty();

        $.post("autoComplete.jsp", {"searchStr": $("#searchField").val()}, function(data, status){
          // $("p").text(data); // prints query

          var arr = data.split("^");

          for(var i = 0; i < arr.length-1; i++){
            $("#autoList").append("<li><a href=\"#\">"+arr[i]+"</a></li>");
          }
        });
      });

      $("#searchField").focusin(function(){
        $("#autoList").show();
      });

      $("#searchField").focusout(function(){
        $("#autoList").hide();
      });
    });
  </script>

  <title>Fabflix</title>

  </head>

  <body> 
    <div class="row">
      <div class="input-field col s6">
        <i class="material-icons prefix">search</i>
        <input id="searchField" type="text" class="validate">
        <label for="searchField">Quick Search:</label>
        <ul id="autoList"></ul>
      </div>
    </div>
    
    <p></p>

  </body>

</html>