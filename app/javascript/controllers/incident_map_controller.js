import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.initMapbox()
  }

  successLocation = (position) => {
    this.setupMap([position.coords.longitude, position.coords.latitude])
  }

  errorLocation = () => {
    this.setupMap([139.7082, 35.6339])
  }

  addKobanMarkersToMap(map, kobanmarkers) {
    kobanmarkers.forEach((kobanmarker) => {
      const popup = new mapboxgl.Popup().setHTML(kobanmarker.info_window);

      const element = document.createElement('span');
      element.className = 'jpic jpic-keisatsu';
      element.style.fontSize = '30px';
      element.style.color = '#D42A44';

      new mapboxgl.Marker(element)
        .setLngLat([kobanmarker.lng, kobanmarker.lat])
        .setPopup(popup)
        .addTo(map);
    });
  }

  addMarkersToMap(map, markers) {

    markers.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window);

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
        // .setPopup(popup)
        .addTo(map);
    });
  }

  setupMap = (center) => {
    const map = new mapboxgl.Map({
      container: "incident_map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: center,
      zoom: 15
  })

  const nav = new mapboxgl.NavigationControl()
  // map.addControl(nav)
  const mapElement = document.getElementById('incident_map')
  map.on("load", () => {
    let directions = new MapboxDirections({
      accessToken: mapElement.dataset.mapboxApiKey,

      interactive: false,
      unit: 'metric'
    },

    map.on("idle", () => {
      const mapElement = document.getElementById("space_map");
      mapElement.style.opacity = 1;
      document.querySelector(".loader").style.display = "none";
    }),
    this.clickInterval = setInterval(() => {
      const el = document.getElementById("mapbox-directions-profile-walking");
      if (el) {
        el.click();
        clearInterval(this.clickInterval);
      }
    }, 100)
  )

  const markers = JSON.parse(mapElement.dataset.markers)
  if (mapElement.dataset.usermarker) {
    const usermarker = JSON.parse(mapElement.dataset.usermarker)
    usermarker[0].lng = center[0]
    usermarker[0].lat = center[1]
    this.addMarkersToMap(map, usermarker)
  }
  map.addControl(directions, "top-left")
  directions.setOrigin(center)
  directions.setDestination(`${markers[0].lng}, ${markers[0].lat}`)
  this.addMarkersToMap(map, markers)

  // try to find a way to trigger it.
    setTimeout(() => document.querySelector('#mapbox-directions-profile-walking').click(), 3000)
    map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        // When active the map will receive updates to the device's location as it changes.
        trackUserLocation: true,
        // Draw an arrow next to the location dot to indicate which direction the device is heading.
        showUserHeading: true
      })
    );
    const kobanmarkers = JSON.parse(mapElement.dataset.kobanmarkers)
    this.addKobanMarkersToMap(map, kobanmarkers)
  }

  initMapbox = () => {
    const mapElement = document.getElementById('incident_map');
    if (mapElement) { // only build a map if there's a div#map to inject into
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      navigator.geolocation.getCurrentPosition(this.successLocation, this.errorLocation, {
        enableHighAccuracy: true
      })
    }
  }

  addUserLocation = (position) => {
    document.querySelector(".mapboxgl-ctrl-geocoder input").value = `${position[0]}, ${position[1]}`
    document.querySelector(".mapboxgl-ctrl-geocoder input").value.dispatchEvent(new KeyboardEvent('keyup', { 'key': 'space' }));
    document.querySelector(".mapboxgl-ctrl-geocoder input").value.dispatchEvent(new KeyboardEvent('keyup', { 'key': 'enter' }));
  }

  addDestinationLocation = (position) => {
    document.querySelector(".mapbox-directions-destination input").value = `${position.lng}, ${position.lat}`
  }
}
