$(".homepage.post_job").ready(function() {

  $("#job-skills").select2({
      tags: true,
      tokenSeparators: [',']
  });

  $("#vehicle-provided-by-driver").click(function(){
    $("#job_employer_provides_vehicle").val(0)
  })
  $("#vehicle-provided-by-employer").click(function(){
    $("#job_employer_provides_vehicle").val(1)
  })


  $("#range-button, #hour-button").click(function(){
    $("#job_rate_not_included").val(0)
  })
  $("#nowage-button").click(function(){
    $("#job_rate_not_included").val(1)
  })

  // for back button
  if($("#job_rate_not_included").val() == 1){
    $("#nowage-button").trigger('click');
  }
  if($("#job_rate_min").val() != ""){
    $("#range-button").trigger('click');
  }

  $(".facebook-login").click(function(){
    event.preventDefault();
    $("#facebook").val("true")
    $("#new_job").submit();
  });

});