import UIKit
import Mapbox

class CustomStyleViewController: UIViewController, MGLMapViewDelegate {

    // Update the token here if you want to customize the token for this controller in your own project.
    // Otherwise update the value at the top of the main controller: ViewController.swift.
    // let accessToken = "YOUR_ACCESS_TOKEN"
    // let customStyleId = "YOUR_CUSTOM_STYLE_ID"

    var mapView = MGLMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title
        title = "Custom style"
        // Initialize map
        let url = URL(string: "https://api.jawg.io/styles/"+customStyleId+".json?access-token="+accessToken)
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900), zoomLevel: 13, animated: false)
        // Add the map to the view
        view.addSubview(mapView)
    }
}
