$(".category-and-address-section").ready(function() {

  function show_other(){
    if( $("option[value='']:selected").length ) {
      $("#other-wrap").show()
    } else {
      $("#other-wrap").hide()
    }
  }

  $("select#job_category").change(function () {
    show_other();
  });

  function find_location_on_map(){
    var search_string = $(".postcode-finder").val()
    search_string = encodeURI(search_string)
    var gmaps_address = 'https://maps.googleapis.com/maps/api/staticmap?center=' +
    search_string +
    '&region=uk&size=153x153&markers=color:red|' +
    search_string +"&region=uk"
    $("#location-map").attr("src",gmaps_address);
  }

  $("#find-postcode").click(function(){
    find_location_on_map()
  });

  $(".postcode-finder").blur(function(){
    find_location_on_map()
  })

  // for back button
  show_other();
  find_location_on_map();
  if($("#job_employer_provides_vehicle").val() == 1){
    $("#vehicle-provided-by-employer").trigger('click');
  }


});