$(".homepage.home").ready(function() {
  
  $( document ).ready(function() {
    // TEST
    $("#carousel").hide()
    $("#work-signup").show()

    $(".home-link").click(function(){
      $("#carousel").show()
      $("#work-signup").hide()
      $("#hire").hide()
      $("#login").hide()
    })

    $(".signup-link").click(function(){
      $("#carousel").hide()
      $("#work-signup").show()
      $("#hire").hide()
      $("#login").hide()
    })

    $(".hire-link").click(function(){
      $("#carousel").hide()
      $("#work-signup").hide()
      $("#hire").show()
      $("#login").hide()
    })

    $(".login-link").click(function(){
      $("#carousel").hide()
      $("#work-signup").hide()
      $("#hire").hide()
      $("#login").show()
    })
  });
});


$( document ).ajaxComplete(function( event, xhr, settings ) {
  // sign up
  if( settings.url == '/users'){
    if( xhr.status == 201 ){
      // Homepage: sign up goes to dashboard
      if( $(".homepage.home").length ){
        window.location.href = '/dashboard'
      }
      // Postproject: sign up submits the project
      if( $(".homepage.postproject").length ){
        $("#post-project-form").submit();
      }
    } else {
      var ul = $('<ul id="signup-errors">').prependTo('#signup-form');
      var json = JSON.parse(xhr.responseText);
      $.each( json.errors, function(key, item){
        ul.append(
            $(document.createElement('li')).text( (key + ' ' + item) )
        );
      });
      $("#signup-form").addClass("has-error");
    }
  }

  // Log in
  if( settings.url == '/users/sign_in'){
    if( xhr.status == 201 ){
      // Homepage: login goes to dashboard
      if( $(".homepage.home").length ){
        window.location.href = '/dashboard'
      }
      // Postproject: login submits the project
      if( $(".homepage.postproject").length ){
        $("#post-project-form").submit();
      }
    } else {
      $( "#login-errors" ).text( xhr.responseText );
      $("#login-form").addClass("has-error");
    }
  }
});