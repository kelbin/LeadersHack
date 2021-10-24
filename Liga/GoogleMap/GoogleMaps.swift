//
//  GoogleMaps.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import GoogleMaps
import GoogleMapsCore
import GoogleMapsUtils

struct Position {
    let latitude: Double
    let longitude: Double
}

struct GoogleMapPoint {
    let location: CLLocationCoordinate2D
    let power: Float?
}

protocol GoogleMap: AnyObject {
    func generateKey()
    func focusOn(bounds: GMSCoordinateBounds)
    func addMarker(latitude: Double, and longitude: Double, title: String, snippet: String)
    func addCircle(markerPosition: Position, and radius: Double)
    func setZoomingInteractionsState(enabled: Bool)
    func redrawPoints(_ points: [GoogleMapPoint])
    func showGradientMapForZoom()
    func style(enabled: Bool)
    func hideGradientMap()
    func focusOn(point: CLLocationCoordinate2D)
    var mapView: GMSMapView? { get set }
}

final class GoogleMapImp: GoogleMap {
    
    var mapView: GMSMapView?
    var heatmapLayer: GMUHeatmapTileLayer!
    var position: Position?
    
    //
    
    var pointsModel: [GoogleMapPoint] = []
    
    enum Const {
        static let provideKey: String = "AIzaSyDYErovCxubBuqZt3ZQjHlGTb33be-LBJg"
    }
    
    init(view: UIView, position: [Position]) {
        let camera = GMSCameraPosition.camera(withLatitude: position[0].latitude,
                                              longitude: position[0].longitude,
                                              zoom: 12)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
        mapView?.settings.myLocationButton = true
        
        //initHeatMap()
        
        view.addSubview(mapView ?? GMSMapView(frame: .zero))
    }
    
    init() {}
    
    func generateKey() {
        GMSServices.provideAPIKey(Const.provideKey)
    }
    
    func focusOn(bounds: GMSCoordinateBounds) {
        mapView?.animate(with: GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 50.0 , left: 50.0 ,bottom: 50.0 ,right: 50.0)))
    }
    
    func initHeatMap() {
        heatmapLayer = GMUHeatmapTileLayer()
        
        heatmapLayer.opacity = 0.3
        heatmapLayer.radius = 150
        
        customizeHeatsColors()
        
        heatmapLayer.map = mapView
    }
    
    func redrawPoints(_ points: [GoogleMapPoint]) {
        mapView?.clear()
        
        pointsModel = points
        
        points.forEach { _point in
            let marker = marker()
            marker.position = _point.location
            
            let circle = GMSCircle(position: _point.location, radius: 500)
            circle.strokeColor = .green
            circle.strokeWidth = 2.0
            circle.fillColor = .clear
            circle.map = mapView
        }
    }
    
    func marker() -> GMSMarker {
        let marker = GMSMarker()
        //marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //marker.title = title
        //marker.snippet = snippet
        marker.icon = #imageLiteral(resourceName: "pinRed")
        marker.isDraggable = false
        marker.map = mapView
        return marker
    }
    
    
    
    func setZoomingInteractionsState(enabled: Bool) {
        mapView?.settings.zoomGestures = enabled
        mapView?.settings.tiltGestures = enabled
        mapView?.settings.rotateGestures = enabled
    }
    
    func showGradientMapForZoom() {
        //heatmapLayer?.clearTileCache()
        self.heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.map = mapView
        guard let zoomValue = mapView?.camera.zoom else { return }
        let radiusNow = radiusOfHeatZone(for: zoomValue)
        
        var list = [GMUWeightedLatLng]()
        for _point in pointsModel {
            let t = GMUWeightedLatLng(coordinate: _point.location, intensity: 1.0)
            list.append(t)
        }
        //heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.opacity = 0.4
        heatmapLayer.radius = radiusNow
        heatmapLayer.weightedData = list
        customizeHeatsColors()
        heatmapLayer.map = mapView
    }
    
    func hideGradientMap() {
        if let heatMap = self.heatmapLayer {
            self.heatmapLayer.map = nil
        }
    }
    
    func focusOn(point: CLLocationCoordinate2D) {
        let sydney = GMSCameraPosition.camera(
            withLatitude: point.latitude,
            longitude: point.longitude,
            zoom: 16.0
            //zoom: mapView?.camera.zoom ?? 20.0
        )
        mapView?.camera = sydney
    }
    
    
    func customizeHeatsColors() {
        let gradientColors: [UIColor] = [#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
        let gradientStartPoints: [NSNumber] = [0.2, 0.25, 0.4]
        
        heatmapLayer.gradient = GMUGradient(colors: gradientColors, startPoints: gradientStartPoints, colorMapSize: 100)
    }
    
    func radiusOfHeatZone(for zoom: Float) -> UInt {
        let weight = (1.0/zoom) * 12600.0
        let coef: Float = 75.0
        print(UInt(weight * coef))
        return UInt(weight)
    }
    
    func addMarker(latitude: Double,
                   and longitude: Double,
                   title: String = "Default",
                   snippet: String = "") {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = snippet
        marker.icon = #imageLiteral(resourceName: "pinRed")
        marker.isDraggable = true
        marker.map = mapView
    }
    
    func addCircle(markerPosition: Position, and radius: Double) {
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: markerPosition.latitude, longitude: markerPosition.longitude), radius: radius)
        
        circle.fillColor = [#colorLiteral(red: 0.005960932001, green: 0.122812219, blue: 0.6545705795, alpha: 1), #colorLiteral(red: 0, green: 0.7376522422, blue: 0.9917584062, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)].randomElement()?.withAlphaComponent(0.4)
        
        circle.map = self.mapView
    }
    
    func style(enabled: Bool) {
        if enabled {
            mapView?.mapStyle = try! GMSMapStyle(jsonString: mapstyleBW)
        } else {
            mapView?.mapStyle = try! GMSMapStyle(jsonString: retroStyle)
        }
    }
}


fileprivate let mapstyleBW: String = """
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
"""

let retroStyle = """
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#523735"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#c9b2a6"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#dcd2be"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#ae9e90"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#93817c"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#a5b076"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#447530"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f1e6"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#fdfcf8"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f8c967"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#e9bc62"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e98d58"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#db8555"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#806b63"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8f7d77"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#ebe3cd"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dfd2ae"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#b9d3c2"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#92998d"
      }
    ]
  }
]
"""
