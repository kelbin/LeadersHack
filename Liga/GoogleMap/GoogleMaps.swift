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

protocol GoogleMap: AnyObject {
    func generateKey()
    func addMarker(latitude: Double, and longitude: Double, title: String, snippet: String)
    func addCircle(markerPosition: Position, and radius: Double)
    
    var mapView: GMSMapView? { get set }
}

final class GoogleMapImp: GoogleMap {
    
    var mapView: GMSMapView?
    var heatmapLayer: GMUHeatmapTileLayer!
    var position: Position?
    
    enum Const {
        static let provideKey: String = "AIzaSyDYErovCxubBuqZt3ZQjHlGTb33be-LBJg"
    }
    
    init(view: UIView, position: [Position]) {
        let camera = GMSCameraPosition.camera(withLatitude: position[0].latitude,
                                              longitude: position[0].longitude,
                                              zoom: 12)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        
        mapView?.settings.myLocationButton = true
        
        initHeatMap()
        
        view.addSubview(mapView ?? GMSMapView(frame: .zero))
    }
    
    init() {}
    
    func generateKey() {
        GMSServices.provideAPIKey(Const.provideKey)
    }
    
    func initHeatMap() {
        heatmapLayer = GMUHeatmapTileLayer()
        
        heatmapLayer.opacity = 0.3
        heatmapLayer.radius = 150
        
        customizeHeatsColors()
        parseHeatMap()
        
        heatmapLayer.map = mapView
    }
    
    func customizeHeatsColors() {
        
        let gradientColors: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0, green: 0.7376522422, blue: 0.9917584062, alpha: 1)]
        let gradientStartPoints: [NSNumber] = [0.2, 1.0]
        
        heatmapLayer.gradient = GMUGradient(colors: gradientColors, startPoints: gradientStartPoints, colorMapSize: 256)
    }
    
    func parseHeatMap() {
        
        guard let path = Bundle.main.url(forResource: "heats", withExtension: "json") else {
            return
        }
        guard let data = try? Data(contentsOf: path) else {
            return
        }
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return
        }
        
        guard let object = json as? [[String: Any]] else {
            print("Could not read the JSON.")
            return
        }
        
        var list = [GMUWeightedLatLng]()
        
        for item in object {
            
            let lat = item["lat"] as! CLLocationDegrees
            let lng = item["lng"] as! CLLocationDegrees
            let coords = GMUWeightedLatLng(
                coordinate: CLLocationCoordinate2DMake(lat, lng),
                intensity: 1.0
            )
            list.append(coords)
        }

        heatmapLayer.weightedData = list
    }
    
    func addMarker(latitude: Double,
                   and longitude: Double,
                   title: String = "Default",
                   snippet: String = "") {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = snippet
        marker.icon = #imageLiteral(resourceName: "image_2021-10-16_18-00-59")
        marker.isDraggable = true
        marker.map = mapView
    }
    
    func addCircle(markerPosition: Position, and radius: Double) {
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: markerPosition.latitude, longitude: markerPosition.longitude), radius: radius)
        
        circle.fillColor = [#colorLiteral(red: 0.005960932001, green: 0.122812219, blue: 0.6545705795, alpha: 1), #colorLiteral(red: 0, green: 0.7376522422, blue: 0.9917584062, alpha: 1), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)].randomElement()?.withAlphaComponent(0.4)
        
        circle.map = self.mapView
    }
}
