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
  errorLocation = () => {
    this.setupMap([139.7082, 35.6339])
  }

  addKobanMarkersToMap(map, kobanmarkers){
    kobanmarkers.forEach((kobanmarker) => {
      const popup = new mapboxgl.Popup().setHTML(kobanmarker.info_window);

      const element = document.createElement('span');
      element.className = 'jpic jpic-keisatsu';
      element.style.fontSize = '30px';
      element.style.color = '#D42A44';

      new mapboxgl.Marker(element)
        .setLngLat([ kobanmarker.lng, kobanmarker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
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

  fitMapToMarkers(map, markers){
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  };

  setupMap = (center) => {
    const map = new mapboxgl.Map({
      container: "space_map",
      style: "mapbox://styles/ck3nn3dy/cksye634q082b18oeymwnwn0d",
      center: center,
      zoom: 15
    })
    console.log(center)
    const mapElement = document.getElementById('space_map');
    map.on("load", () => {
      let directions = new MapboxDirections({
        accessToken: mapElement.dataset.mapboxApiKey,

        interactive: false,
         unit: 'metric'
      }
      )

      const markers = JSON.parse(mapElement.dataset.markers)
      // const space_address = JSON.parse(mapElement.dataset.space_address)
      map.addControl(directions, "top-left")
      directions.setOrigin(center)
      directions.setDestination([markers[0].lng, markers[0].lat])

      this.fitMapToMarkers(map, [
        markers[0],
        {
          lng: center[0],
          lat: center[1],
        }
      ])
      map.on("idle", () => {
        const mapElement = document.getElementById("space_map");
        mapElement.style.opacity = 1;
        document.querySelector(".loader").style.display = "none";
      });
      this.clickInterval = setInterval(() => {
        const el = document.getElementById("mapbox-directions-profile-walking");
        if (el) {
          el.click();
          clearInterval(this.clickInterval);
        }
      }, 100);
    })

    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true
    });
    // Add the control to the map.
    map.addControl(geolocate);
    if (mapElement.dataset.ssmarkers) {
      const ssmarkers = JSON.parse(mapElement.dataset.ssmarkers)
      this.addSafeSpaceMarkersToMap(map, ssmarkers)
    }

    const kobanmarkers = JSON.parse(mapElement.dataset.kobanmarkers)
    this.addKobanMarkersToMap(map, kobanmarkers)
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
