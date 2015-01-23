$( document ).ready(function() {
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

