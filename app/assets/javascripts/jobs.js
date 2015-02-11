$("#jobs").ready(function() {

  var sort = $("input[name='sort']")
  var direction = $("input[name='direction']")

  $("select").change(function () {
    $("#jobs-filter").submit()
  });

  $("a.distance.link-to-descending").click(function() {
    sort.val("distance")
    direction.val("desc")
    $("#jobs-filter").submit()
  })

  $("a.distance.link-to-ascending").click(function() {
    sort.val("distance")
    direction.val("asc")
    $("#jobs-filter").submit()
  })

  $("a.date.link-to-descending").click(function() {
    sort.val("date")
    direction.val("desc")
    $("#jobs-filter").submit()
  })

  $("a.date.link-to-ascending").click(function() {
    sort.val("date")
    direction.val("asc")
    $("#jobs-filter").submit()
  })

});
