import mapboxgl from 'mapbox-gl';
window.mapboxgl = mapboxgl;
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'
window.MapboxDirections = MapboxDirections
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css'
import 'mapbox-gl/dist/mapbox-gl.css';
// const MapboxDirections = require('@mapbox/mapbox-gl-directions');


function successLocation(position) {
  setupMap([position.coords.longitude, position.coords.latitude])

}

function errorLocation() {
  // setupMap([-2.24, 53.48])
  setupMap([139.7082, 35.6339])
}


function setupMap(center) {
  const map = new mapboxgl.Map({
    container: "map",
    style: "mapbox://styles/mapbox/streets-v11",
    center: center,
    zoom: 15
  })

  const nav = new mapboxgl.NavigationControl()
  map.addControl(nav)
  const mapElement = document.getElementById('map');
  let directions = new MapboxDirections({
    accessToken: mapElement.dataset.mapboxApiKey
  })

  map.addControl(directions, "top-left")

  const markers = JSON.parse(mapElement.dataset.markers);
  addMarkersToMap(map, markers);
  fitMapToMarkers(map, markers);
  addUserLocation(center)
}

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.info_window);

    // Create a HTML element for your custom marker
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '40px';
    element.style.height = '40px';
    element.style.borderRadius = '50%';
    element.style.borderStyle = 'solid';
    element.style.borderWidth = '2px';
    element.style.borderColor = '#6D6875';

    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    navigator.geolocation.getCurrentPosition(successLocation, errorLocation, {
      enableHighAccuracy: true
    })
  }
};

function addUserLocation(position) {
  document.querySelector(".mapboxgl-ctrl-geocoder input").value = `${position[0]}, ${position[1]}`
}

function addUserHomeToDestination(position) {
  document.querySelector(".mapbox-directions-destination input").value = `${position.lng}, ${position.lat}`
}
export { initMapbox };
