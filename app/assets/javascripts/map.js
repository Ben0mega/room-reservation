var map;
var markers = [];

function initMap() {
  var mapCenter = {lat: 37.8719402, lng: -122.2622687};
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 16,
    center: mapCenter,
    mapTypeControl: false,
    fullscreenControl: false
  });
  
  // Make sure user won't navigate the map out of the scope of Berkeley.
  var allowedBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(37.867911, -122.266229), 
    new google.maps.LatLng(37.875455, -122.253570)
  );
  var lastValidCenter = map.getCenter();
  google.maps.event.addListener(map, 'center_changed', function() {
    if (allowedBounds.contains(map.getCenter())) {
      // still within valid bounds, so save the last valid position
      lastValidCenter = map.getCenter();
      return; 
    }
    // not valid anymore => return to last valid position
    map.panTo(lastValidCenter);
  });
  
  updateMarkers();
}

function filterMarkers(e) {
  e.preventDefault();
  updateMarkers();
}

function updateMarkers() {
  var studentAccessible = document.getElementById("StudentAccessible").checked;
  var whiteboard = document.getElementById("Whiteboard").checked;
  var AV = document.getElementById("AV").checked;
  var typeDrop = document.getElementById("type_drop");
  var roomType = typeDrop.options[typeDrop.selectedIndex].value;
  var capacityDrop = document.getElementById("capacity_drop");
  var capacity = capacityDrop.options[capacityDrop.selectedIndex].value;
  var paramsString = "?utf8=✓";
  paramsString += studentAccessible ? "&StudentAccessible=true" : "";
  paramsString += whiteboard ? "&Whiteboard=true" : "";
  paramsString += AV ? "&AV=true" : "";
  paramsString += "&room_type=" + roomType;
  paramsString += "&capacity=" + capacity;
  
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      postMarkers(JSON.parse(this.responseText));
    }
  };
  xhttp.open("GET", "/filter" + paramsString, true);
  xhttp.send();
}

function postMarkers(data) {
  // clear existing markers
  var length = markers.length;
  for (var i = 0; i < length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
  
  // for each new building, query for geolocation and create a new marker
  length = data.length;
  for (var i = 0; i < length; i++) {
    addMarker(data[i]['name'], data[i]['id'])
  }
}

function addMarker(name, id) {
  var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        result = JSON.parse(this.responseText);
        console.log(name);
        geo = result['results'][0]['geometry']['location'];
        var marker = new google.maps.Marker({
          position: geo,
          map: map,
          title: name,
          id: id,
        });
        markers.push(marker);
        google.maps.event.addListener(marker, 'click', function() {
          var studentAccessible = document.getElementById("StudentAccessible").checked;
          var whiteboard = document.getElementById("Whiteboard").checked;
          var AV = document.getElementById("AV").checked;
          var typeDrop = document.getElementById("type_drop");
          var roomType = typeDrop.options[typeDrop.selectedIndex].value;
          var capacityDrop = document.getElementById("capacity_drop");
          var capacity = capacityDrop.options[capacityDrop.selectedIndex].value;
          var paramsString = "?utf8=✓";
          paramsString += studentAccessible ? "&StudentAccessible=true" : "";
          paramsString += whiteboard ? "&Whiteboard=true" : "";
          paramsString += AV ? "&AV=true" : "";
          paramsString += "&room_type=" + roomType;
          paramsString += "&capacity=" + capacity;
          window.location.href = '/buildings/' + marker.id + paramsString;
        });
      }
    };
    xhttp.open("GET", `https://maps.googleapis.com/maps/api/geocode/json?address=${name}%20Hall`, true);
    xhttp.send();
}