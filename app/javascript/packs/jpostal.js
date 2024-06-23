function jpostal() {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#itinerary_place': '%3%4%5'
    }
  })
}
$(document).on("turbolinks:load", jpostal);