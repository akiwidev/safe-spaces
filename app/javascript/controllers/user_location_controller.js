import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["link"]

  connect() {
    console.log(this.linkTarget)
    this.initMapbox()
  }


  successLocation = (position) => {
    console.log(position)
    window.localStorage.setItem('lng', position.coords.longitude);
    window.localStorage.setItem('lat', position.coords.latitude);
    let url = document.querySelector('link').href
    let params = new URLSearchParams(url.search);
    // this comes form the JS current location
    params.set('lng', position.coords.longitude)
    params.set('lat', position.coords.latitude)
    // replace the link href with this:
    url + "?" + params
  }

  errorLocation = () => {
    console.log("Location error")
  }


  initMapbox = () => {
    const mapElement = document.getElementById('user_location');
    console.log(mapElement);
    if (mapElement) { // only build a map if there's a div#map to inject into
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      console.log("before location")
      navigator.geolocation.getCurrentPosition(this.successLocation, this.errorLocation, {
        enableHighAccuracy: true
      })
    }
  };
}
