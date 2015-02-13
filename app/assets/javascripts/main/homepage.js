$(".homepage.home").ready(function() {

  // TEST
  // $("#carousel").hide()
  // $("#hire").show()

  $(".home-link").click(function(event){
    event.preventDefault();
    $("#carousel").show()
    $("#work-signup").hide()
    $("#hire").hide()
    $("#login").hide()
  })

  $(".signup-link").click(function(event){
    event.preventDefault();
    $("#carousel").hide()
    $("#work-signup").show()
    $("#hire").hide()
    $("#login").hide()
  })

  $(".hire-link").click(function(event){
    event.preventDefault();
    $("#carousel").hide()
    $("#work-signup").hide()
    $("#hire").show()
    $("#login").hide()
  })

  $(".login-link").click(function(event){
    event.preventDefault();
    $("#carousel").hide()
    $("#work-signup").hide()
    $("#hire").hide()
    $("#login").show()
  })

});