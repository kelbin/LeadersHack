//
//  ViewController.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import GoogleMaps
import UIKit
import MobileCoreServices
import Combine

protocol MapViewInput: AnyObject {
    func updateMarkers(position: Location)
}

final class MapViewController: UIViewController, LeftPanelDelegate, ToolbarDelegate, MapLayersCardViewDelegate {
        
    enum Constants {
        static let leftPanelWidth: CGFloat = 100
    }
    
    private lazy var leftPanel: LeftPanelView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isUserInteractionEnabled = true
        return $0
    }(LeftPanelView(frame: .zero))
    
    private lazy var mapLayersView: MapLayersCardView = {
        $0.delegate = self
        return $0
    }(MapLayersCardView())
    
    private lazy var lensView: MapLensCardView = {
        $0.delegate = self
        return $0
    }(MapLensCardView())

    var googleMap: GoogleMap?
    var presenter: MapPresenterInput!
    
    var markers: [Location] = []
    
    weak var geoView: UIView?
    weak var searchForPointView: UIView?
    
    var startZoomPosition: Float?
    
    override func viewDidLoad() {
        presenter = MapPresenter(view: self)
        
        super.viewDidLoad()
        prepareMaps()
        prepareLayout()
        
        showGeozones()
        showSearchForPoint()
        
        prepareDragAndDrop()
        
        geoView?.isHidden = true
        searchForPointView?.isHidden = true
        
        self.view.bringSubviewToFront(leftPanel)
        
        leftPanel.dataSource.delegate = self
        leftPanel.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showLeftPanel()
        }
        bindings()
        //googleMap?.setZoomingInteractionsState(enabled: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func bindings() {
        globalInteractor.$currentFrame.sink { _ in
        } receiveValue: { coordintates in
            let bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: coordintates.topLeftLatitude, longitude: coordintates.topLeftLongitude), coordinate: CLLocationCoordinate2D(latitude: coordintates.bottomRightLatitude, longitude: coordintates.bottomRightLongitude))
            self.googleMap?.focusOn(bounds: bounds)
        }.store(in: &cancellable)
        
        globalInteractor.$sportPoints.sink { _ in
        } receiveValue: { points in
            self.googleMap?.redrawPoints(points.map({ GoogleMapPoint(location: CLLocationCoordinate2D(latitude: $0.location.latitude, longitude: $0.location.longitude), power: 0) }))
            //self.googleMap?.showGradientMapForZoom()
        }.store(in: &cancellable)


    }
    
    private var cancellable = Set<AnyCancellable>()
    
    private func prepareMaps() {
        
        googleMap = GoogleMapImp(view: self.view,
                                 position: [Position(latitude: 55.748286, longitude: 37.622791)])
        
        //googleMap?.addMarker(latitude: 55.748286, and: 37.622791, title: "Тута", snippet: "Сдеся")
        
        googleMap?.mapView?.delegate = self
        
        startZoomPosition = googleMap?.mapView?.camera.zoom
    }
    
    private func prepareDragAndDrop() {
        
        let dragInteraction = UIDragInteraction(delegate: self)
        let dropInteraction = UIDropInteraction(delegate: self)
        
        dragInteraction.isEnabled = true
        
        leftPanel.toolButtonGeozone.addInteraction(dragInteraction)
        googleMap?.mapView?.addInteraction(dropInteraction)
    }
    
    private func prepareLayout() {
        
        view.addSubview(leftPanel)
        view.addSubview(lensView)
        view.addSubview(mapLayersView)
        
        lensView.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().offset(-40.0)
            maker.top.equalToSuperview().offset(80.0)
            maker.width.equalTo(162.0)
            maker.height.equalTo(170.0)
        }
        
        mapLayersView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(20.0)
            maker.trailing.equalToSuperview().offset(-40.0)
            maker.width.equalTo(96.0)
            maker.height.equalTo(48.0)
        }
        
        leftPanel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -Constants.leftPanelWidth).isActive = true
        leftPanel.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        leftPanel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        leftPanel.widthAnchor.constraint(equalToConstant: Constants.leftPanelWidth).isActive = true
    }
    
    private func showLeftPanel() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.leftPanel.transform = CGAffineTransform(translationX: Constants.leftPanelWidth, y: 0)
        }, completion: nil)
    }
    
    func updateLayers(forDropLocation dropLocation: CGPoint) {
        if leftPanel.toolButtonGeozone.frame.contains(dropLocation) {
            
        } else if view.frame.contains(dropLocation) {
            
        } else {
            
        }
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        geoView?.isHidden = false
    }
    
    func goToPointsList() {
        searchForPointView?.isHidden = !(searchForPointView?.isHidden ?? false)
        geoView?.isHidden = true
        leftPanel.didSelectedTool(with: 1)
    }
    
    func goToGeozones() {
        geoView?.isHidden = !(geoView?.isHidden ?? false)
        searchForPointView?.isHidden = true
        leftPanel.didSelectedTool(with: 2)
    }
    
    func goToSettings() {
        let vc = WorkSpaceViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func didTapedStyleButton() {
        if styleEnabled {
            styleEnabled = false
            googleMap?.style(enabled: false)
        } else {
            googleMap?.style(enabled: true)
            styleEnabled = true
        }
    }
    
    func didTapedLayerButton() {
        if heatMapEnabled {
            heatMapEnabled = false
            googleMap?.setZoomingInteractionsState(enabled: true)
            googleMap?.hideGradientMap()
        } else {
            heatMapEnabled = true
            googleMap?.showGradientMapForZoom()
            googleMap?.setZoomingInteractionsState(enabled: false)
        }
    }
    
    var styleEnabled: Bool = false {
        didSet { mapLayersView.setStyleSelected(value: styleEnabled) }
    }
    
    
    var heatMapEnabled: Bool = false {
        didSet { mapLayersView.setLayerSelected(value: heatMapEnabled) }
    }
    
}

extension MapViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        guard let image = leftPanel.toolButtonGlass.image else { return [] }
        
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        
        item.localObject = image
        
        return [item]
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.hasItemsConforming(toTypeIdentifiers: [kUTTypeImage as String]) && session.items.count == 1
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnter session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)

        let operation: UIDropOperation

        if leftPanel.toolButtonGeozone.frame.contains(dropLocation) {
            operation = session.localDragSession == nil ? .copy : .move
        } else {
            operation = .cancel
        }

        return UIDropProposal(operation: operation)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidExit session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
        print("DID EXIT")
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidEnd session: UIDropSession) {
        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
        print("DID END")
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, session: UIDragSession, didEndWith operation: UIDropOperation) {
        let dropLocation = session.location(in: view)
        let coordinate = googleMap?.mapView?.projection.coordinate(for: dropLocation)
        googleMap?.addMarker(latitude: coordinate?.latitude ?? 0,
                             and: coordinate?.longitude ?? 0,
                             title: "Поинт",
                             snippet: "Поинт")
        
        
    }
    func dropInteraction(_ interaction: UIDropInteraction, concludeDrop session: UIDropSession) {
        print("concludeDrop")
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: UIImage.self) { imageItems in
            let images = imageItems as! [UIImage]

            self.leftPanel.toolButtonGeozone.image = images.first
        }

        let dropLocation = session.location(in: view)
        updateLayers(forDropLocation: dropLocation)
        print("PERFORM DROP")
    }
    
}

extension MapViewController: MapLensCardViewDelegate {
    
        
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("draggeds")
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//        let projection = mapView.projection.visibleRegion()
//
//        presenter.fetchPlaceMarks(boxCoordinate: BoxCoordintate(topLeftLongitude:
//                                                                projection.farLeft.longitude,
//                                                                topLeftLatitude: projection.farLeft.latitude, bottomRightLongitude: projection.nearRight.longitude, bottomRightLatitude: projection.nearRight.latitude))
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("will move gesture =", mapView.camera.zoom)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        markers.forEach { position in
//            if !self.isMarkerWithinScreen(marker: GMSMarker(position: CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude))) {
//
//                self.markers.removeAll(where: { $0.fullAdressString == $0.fullAdressString })
//                self.googleMap?.mapView?.clear()
//            }
//        }

    }
    
}


extension MapViewController: MapViewInput {
    
    func updateMarkers(position: Location) {
        DispatchQueue.main.async {
            
           let isExist = self.markers.contains(where: { $0.fullAdressString == position.fullAdressString })
            
            print(self.markers.count)
            
            if !isExist {
                
                self.markers.append(position)
                self.googleMap?.addMarker(latitude: position.latitude, and: position.longitude, title: position.fullAdressString ?? "", snippet: "")
            }
        }
    }
    
    private func isMarkerWithinScreen(marker: GMSMarker) -> Bool {
        let region = googleMap?.mapView?.projection.visibleRegion()
        let bounds = GMSCoordinateBounds(region: region!)
        return bounds.contains(marker.position)
    }
    
}
