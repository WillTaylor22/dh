// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.

//= require jquery
//= require jquery_ujs

$( document ).ready(function() {

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


}); // document ready


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-59807781-1', 'auto');
ga('send', 'pageview');

