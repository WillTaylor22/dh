$(".homepage.post_job").ready(function() {

  function show_other(){
    if( $("option#other:selected").length ) {
      $("#other-wrap").show()
    } else {
      $("#other-wrap").hide()
    }
  }

  function find_location_on_map(){
    var search_string = $("#job_postcode").val()
    search_string = encodeURI(search_string)
    var gmaps_address = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
    search_string +
    '&size=153x153&markers=color:red|' +
    search_string
    $("#location-map").attr("src",gmaps_address);
  }

  $("#vehicle-provided-by-driver").click(function(){
    $("#job_employer_provides_vehicle").val(0)
  })
  $("#vehicle-provided-by-employer").click(function(){
    $("#job_employer_provides_vehicle").val(1)
  })

  $("select#job_category").change(function () {
    show_other();  
  });

  // for back button
  show_other();
  find_location_on_map();
  if($("#job_employer_provides_vehicle").val() == 1){
    $("#vehicle-provided-by-employer").trigger('click');
  }

  $("#find-postcode").click(function(){
    find_location_on_map()
  });

  $("#job_postcode").blur(function(){
    find_location_on_map()
  })

});