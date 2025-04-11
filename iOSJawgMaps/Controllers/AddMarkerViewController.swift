import MapLibre
import UIKit

class AddMarkerViewController: UIViewController, MLNMapViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple marker"
        
        let url = URL(
            string: "https://api.jawg.io/styles/jawg-streets.json?access-token="
                + accessToken)
        let mapView = MLNMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900),
            zoomLevel: 12, animated: false)
        // Add a point annotation
        let annotation = MLNPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: -33.85416325, longitude: 151.20916)
        annotation.title = "Opera House"
        annotation.subtitle = "The most beautiful opera house in the world!"
        mapView.addAnnotation(annotation)
        view.addSubview(mapView)
    }

    func mapView(
        _ mapView: MLNMapView,
        annotationCanShowCallout annotation: MLNAnnotation
    ) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
}
