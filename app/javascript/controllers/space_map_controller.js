import { Controller } from "stimulus"

export default class extends Controller {

  connect(){
    this.initMapbox()
  }
  // This is standard method that when used as a callback function, loses its 'this', to the profit of i.e. line 74's navigation.geolocation. That's why we use .bind, to be able to retain the 'this' of where it's has been called (i.e. this.successlocation - the instance of controller).
  successLocation(position) {
    this.setupMap([position.coords.longitude, position.coords.latitude])
  }
//  This is an arrow method that keeps it's 'this', when it's passed as a callback function i.e. line 73.
  errorLocation= () => {
    this.setupMap([139.7082, 35.6339])
  }

  addSafeSpaceMarkersToMap(map, ssmarkers){
    ssmarkers.forEach((ssmarker) => {
      const popup = new mapboxgl.Popup().setHTML(ssmarker.info_window);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${ssmarker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '40px';
      element.style.height = '40px';
      element.style.borderRadius = '50%';
      element.style.borderStyle = 'solid';
      element.style.borderWidth = '2px';
      element.style.borderColor = '#6D6875';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([ssmarker.lng, ssmarker.lat])
        .setPopup(popup)
        .addTo(map);
    });
  }

  setupMap(center){
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

      interactive: false,
       unit: 'metric'
    }
    )

     
  

    const markers = JSON.parse(mapElement.dataset.markers)
    // const space_address = JSON.parse(mapElement.dataset.space_address)
    map.addControl(directions, "top-left")
    directions.setOrigin(`${center[0]}, ${center[1]}`)
    directions.setDestination(`${markers[0].lng}, ${markers[0].lat}`)
    // try to find a way to trigger it.
    setTimeout(() => document.querySelector('#mapbox-directions-profile-walking').click(), 3000)
    //   this.addUserLocation(center)
    //   this.addDestinationLocation(space_address)
    //   this.addDestinationLocation(markers[0])
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

    const ssmarkers = JSON.parse(mapElement.dataset.ssmarkers)
    this.addSafeSpaceMarkersToMap(map, ssmarkers)
  }

  initMapbox(){
    const mapElement = document.getElementById('space_map');
    if (mapElement) { // only build a map if there's a div#map to inject into
      mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
      navigator.geolocation.getCurrentPosition(this.successLocation.bind(this), this.errorLocation, {
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
