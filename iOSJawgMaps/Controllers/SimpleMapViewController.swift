import MapLibre
import UIKit

class SimpleMapViewController: UIViewController, MLNMapViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title
        title = "Simple street map"
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
        view.addSubview(mapView)
    }
}
