var map;

function initMap() {
  var mapCenter = {lat: 37.872574, lng: -122.260748};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: mapCenter,
    mapTypeControl: false,
    fullscreenControl: false
  });
  
  map.data.loadGeoJson("building_geo.json");
  
  map.data.addListener('click', function(event) {
    window.location.href = '/buildings/' + event.feature.getId();
  });
  map.data.addListener('mouseover', function(event) {
    if (legend.innerHTML == "") {
      document.getElementById('legend').style.visibility = 'visible';
    }
    legend.innerHTML = event.feature.getProperty("name");
  });
}