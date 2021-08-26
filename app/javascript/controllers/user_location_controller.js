import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['link', 'lng', 'lat']

  connect() {
    console.log(this.linkTarget)
    this.initMapbox()
  }


  successLocation = (position) => {
    console.log(position)
    window.localStorage.setItem('lng', position.coords.longitude);
    window.localStorage.setItem('lat', position.coords.latitude);
    this.lngTarget.value = position.coords.longitude;
    this.latTarget.value = position.coords.latitude;


    // console.log(this.linkTarget.href)
    // let url = new URL(this.linkTarget.href)
    // let params = new URLSearchParams(url.search);
    // // this comes form the JS current location
    // params.set('lng', position.coords.longitude)
    // params.set('lat', position.coords.latitude)
    // // console.log(params.toString(), position.coords.longitude)
    // // replace the link href with this:
    // this.linkTarget.href = url + "?" + params.toString()
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
