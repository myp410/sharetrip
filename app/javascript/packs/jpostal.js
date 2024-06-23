function jpostal() {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    place : {
      '#itinerary_place': '%3%4%5'
    }
  })
}
$(document).on("turbolinks:load", jpostal);