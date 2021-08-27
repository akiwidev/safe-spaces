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

  setupMap = (center) => {
    const map = new mapboxgl.Map({
      container: "space_map",
      style: "mapbox://styles/mapbox/streets-v11",
      center: center,
      zoom: 15
    })

    const nav = new mapboxgl.NavigationControl()
    map.addControl(nav)
    const mapElement = document.getElementById('space_map');
    let directions = new MapboxDirections({
      accessToken: mapElement.dataset.mapboxApiKey,
      interactive: false
    }
    )
    const markers = JSON.parse(mapElement.dataset.markers)
    // const space_address = JSON.parse(mapElement.dataset.space_address)
    console.log(markers)
    map.addControl(directions, "top-left")
    directions.setOrigin(`${center[0]}, ${center[1]}`)
    directions.setDestination(`${markers[0].lng}, ${markers[0].lat}`)
    // try to find a way to trigger it.
    setTimeout(() => document.querySelector('#mapbox-directions-profile-walking').click(), 3000)
  //   this.addUserLocation(center)
  //   this.addDestinationLocation(space_address)
  //   this.addDestinationLocation(markers[0])
  }

  initMapbox = () => {
    const mapElement = document.getElementById('space_map');
    if (mapElement) { // only build a map if there's a div#map to inject into
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      navigator.geolocation.getCurrentPosition(this.successLocation, this.errorLocation, {
        enableHighAccuracy: true
      })
    }
  };
  addUserLocation = (position) => {
    document.querySelector(".mapboxgl-ctrl-geocoder input").value = `${position[0]}, ${position[1]}`
  }

  addDestinationLocation = (position) => {
    document.querySelector(".mapbox-directions-destination input").value = `${position.lng}, ${position.lat}`
  }
}
