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

}); // document ready