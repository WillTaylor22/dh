$("#jobs").ready(function() {

  $("select").change(function () {
    $("#jobs-filter").submit()
  });

});
