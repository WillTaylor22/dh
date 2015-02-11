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

  // for back button
  if($("#job_employer_provides_vehicle").val() == 1){
    $("#vehicle-provided-by-employer").trigger('click');
  }

  $(".facebook-login").click(function(){
    event.preventDefault();
    $("#facebook").val("true")
    $("#new_job").submit();
  });

});