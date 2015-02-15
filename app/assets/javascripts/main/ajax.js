$( document ).ajaxComplete(function( event, xhr, settings ) {
  // sign up
  if( settings.url == '/users'){
    if( xhr.status == 201 ){
      // Homepage: sign up goes to dashboard
      if( $(".homepage.home").length ){
        window.location.href = '/job-finder'
      }
      // Postproject: sign up submits the project
      if( $(".homepage.post_job").length ){        
        $("#job_user_id").val(xhr.responseJSON.id)
        // console.log(xhr.responseJSON.id)
        $("#new_job").submit();
      }
    } else {
      var ul = $('#signup-errors')
      ul.html("")
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
      if( $(".homepage.post_job").length ){
        $("#job_user_id").val(xhr.responseJSON.id)
        $("#new_job").submit();
      }
    } else {
      $( "#login-errors" ).text( xhr.responseText );
      $("#login-form").addClass("has-error");
    }
  }
});