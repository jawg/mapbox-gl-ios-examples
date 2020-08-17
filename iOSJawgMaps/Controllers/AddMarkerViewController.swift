import UIKit
import Mapbox

class AddMarkerViewController: UIViewController, MGLMapViewDelegate {

    // Update the token here if you want to customize the token for this controller in your own project.
    // Otherwise update the value at the top of the main controller: ViewController.swift.
    // let accessToken = "YOUR_ACCESS_TOKEN"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title
        title = "Simple marker"
        let url = URL(string: "https://api.jawg.io/styles/jawg-sunny.json?access-token="+accessToken)
        let mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900), zoomLevel: 12, animated: false)
        // Add a point annotation
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: -33.85416325, longitude: 151.20916)
        annotation.title = "Opera House"
        annotation.subtitle = "The most beautiful opera house in the world!"
        mapView.addAnnotation(annotation)
        view.addSubview(mapView)
    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
}
