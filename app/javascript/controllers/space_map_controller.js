import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    console.log(this.element)
    this.initMapbox()
  }
  successLocation = (position) => {
    console.log(position)
    this.setupMap([position.coords.longitude, position.coords.latitude])
  }

  errorLocation = () => {
    this.setupMap([-2.24, 53.48])
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
      accessToken: mapElement.dataset.mapboxApiKey
    }
    )
    const markers = JSON.parse(mapElement.dataset.markers)
    // const space_address = JSON.parse(mapElement.dataset.space_address)
    console.log(markers)
    map.addControl(directions, "top-left")
    this.addUserLocation(center)
    // this.addDestinationLocation(space_address)
    this.addDestinationLocation(markers[0])
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
