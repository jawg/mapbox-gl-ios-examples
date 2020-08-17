import UIKit
import Mapbox

class AddGeometryViewController: UIViewController, MGLMapViewDelegate {

    // Update the token here if you want to customize the token for this controller in your own project.
    // Otherwise update the value at the top of the main controller: ViewController.swift.
    // let accessToken = "YOUR_ACCESS_TOKEN"

    var mapView = MGLMapView()
    var timer: Timer?
    var polylineSource: MGLShapeSource?
    var currentIndex = 1
    var allCoordinates: [CLLocationCoordinate2D]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title
        title = "Simple geometry"
        let url = URL(string: "https://api.jawg.io/styles/jawg-dark.json?access-token="+accessToken)
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: 48.8534, longitude: 2.3488),
        zoomLevel: 10,
        animated: false)
        view.addSubview(mapView)
        allCoordinates = coordinates
    }

    // Paris boundaries
    let coordinates = [(2.319887,48.90046),(2.329981,48.901163),(2.38515,48.902008),(2.394906,48.898444),(2.397627,48.894578),(2.398846,48.887109),(2.408308,48.880409),(2.41327,48.872892),(2.413838,48.864376),(2.416341,48.849234),(2.412246,48.834539),(2.422139,48.835798),(2.41939,48.842577),(2.42813,48.841528),(2.447699,48.844818),(2.463438,48.842089),(2.467426,48.838891),(2.467582,48.833133),(2.462696,48.81906),(2.458705,48.81714),(2.438448,48.818232),(2.421462,48.824054),(2.406032,48.827615),(2.390939,48.826079),(2.379296,48.821214),(2.363947,48.816314),(2.345958,48.816036),(2.331898,48.817011),(2.332461,48.818247),(2.292196,48.827142),(2.279052,48.83249),(2.272793,48.82792),(2.263174,48.83398),(2.255144,48.83481),(2.251709,48.838822),(2.250612,48.845555),(2.239978,48.849702),(2.224219,48.853517),(2.228225,48.865183),(2.231736,48.869069),(2.245678,48.876435),(2.25541,48.874264),(2.258467,48.880387),(2.277487,48.877968),(2.282327,48.883923),(2.291507,48.889472),(2.319887,48.90046)].map({CLLocationCoordinate2D(latitude: $0.1, longitude: $0.0)})

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        addPolyline(to: mapView.style!)
        // To get an animation, uncomment this line and remove the code at the end of addPolyline()
        //animatePolyline()
    }

    func addPolyline(to style: MGLStyle) {
        // Add an empty MGLShapeSource, we’ll keep a reference to this and add points to this later.
        let source = MGLShapeSource(identifier: "polyline", shape: nil, options: nil)
        style.addSource(source)
        polylineSource = source
        // Add a layer to style our polyline.
        let layer = MGLLineStyleLayer(identifier: "polyline", source: source)
        layer.lineJoin = NSExpression(forConstantValue: "round")
        layer.lineCap = NSExpression(forConstantValue: "round")
        layer.lineColor = NSExpression(forConstantValue: UIColor.systemBlue)
        // The line width should gradually increase based on the zoom level.
        layer.lineWidth = NSExpression(format: "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",[14: 5, 18: 20])
        style.addLayer(layer)
        // Update polyline - remove if an animated polyline is desired
        let polyline = MGLPolylineFeature(coordinates: allCoordinates, count: UInt(allCoordinates.count))
        polylineSource?.shape = polyline
    }

    func animatePolyline() {
        currentIndex = 1
        // Start a timer that will simulate adding points to our polyline. This could also represent coordinates being added to our polyline from another source, such as a CLLocationManagerDelegate.
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }

     @objc func tick() {
        if currentIndex > allCoordinates.count {
            timer?.invalidate()
            timer = nil
            return
        }
        // Create a subarray of locations up to the current index.
        let coordinates = Array(allCoordinates[0..<currentIndex])
        // Update our MGLShapeSource with the current locations.
        updatePolylineWithCoordinates(coordinates: coordinates)
        currentIndex += 1
    }

     func updatePolylineWithCoordinates(coordinates: [CLLocationCoordinate2D]) {
        var mutableCoordinates = coordinates
        let polyline = MGLPolylineFeature(coordinates: &mutableCoordinates, count: UInt(mutableCoordinates.count))
        // Updating the MGLShapeSource’s shape will have the map redraw our polyline with the current coordinates.
        polylineSource?.shape = polyline
    }
}
