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

$( document ).ajaxComplete(function( event, xhr, settings ) {
  // sign up
  if( settings.url == '/users'){
    if( xhr.status == 201 ){
      window.location.href = '/dashboard'
    } else {
      // $( "#signup-errors" ).text( xhr.responseText );

      var ul = $('<ul id="signup-errors">').prependTo('#signup-form');
      var json = JSON.parse(xhr.responseText);
      console.log('json')
      console.log(json)
      console.log(json.errors)
      $.each( json.errors, function(key, item){
        console.log('in each')
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
      window.location.href = '/dashboard'
    } else {
      $( "#login-errors" ).text( xhr.responseText );
      $("#login-form").addClass("has-error");
    }
  }
});