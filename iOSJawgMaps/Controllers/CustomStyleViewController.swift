import MapLibre
import UIKit

class CustomStyleViewController: UIViewController, MLNMapViewDelegate {
    var mapView = MLNMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title
        title = "Custom style"
        // Initialize map
        let url = URL(
            string: "https://api.jawg.io/styles/" + customStyleId
                + ".json?access-token=" + accessToken)
        mapView = MLNMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900),
            zoomLevel: 13, animated: false)
        // Add the map to the view
        view.addSubview(mapView)
    }
}
