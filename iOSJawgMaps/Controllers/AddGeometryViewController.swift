import MapLibre
import UIKit

class AddGeometryViewController: UIViewController, MLNMapViewDelegate {
    var mapView = MLNMapView()
    var parisBoundaries: [CLLocationCoordinate2D]! = [
        (2.319887, 48.90046), (2.329981, 48.901163), (2.38515, 48.902008),
        (2.394906, 48.898444), (2.397627, 48.894578), (2.398846, 48.887109),
        (2.408308, 48.880409), (2.41327, 48.872892), (2.413838, 48.864376),
        (2.416341, 48.849234), (2.412246, 48.834539), (2.422139, 48.835798),
        (2.41939, 48.842577), (2.42813, 48.841528), (2.447699, 48.844818),
        (2.463438, 48.842089), (2.467426, 48.838891), (2.467582, 48.833133),
        (2.462696, 48.81906), (2.458705, 48.81714), (2.438448, 48.818232),
        (2.421462, 48.824054), (2.406032, 48.827615), (2.390939, 48.826079),
        (2.379296, 48.821214), (2.363947, 48.816314), (2.345958, 48.816036),
        (2.331898, 48.817011), (2.332461, 48.818247), (2.292196, 48.827142),
        (2.279052, 48.83249), (2.272793, 48.82792), (2.263174, 48.83398),
        (2.255144, 48.83481), (2.251709, 48.838822), (2.250612, 48.845555),
        (2.239978, 48.849702), (2.224219, 48.853517), (2.228225, 48.865183),
        (2.231736, 48.869069), (2.245678, 48.876435), (2.25541, 48.874264),
        (2.258467, 48.880387), (2.277487, 48.877968), (2.282327, 48.883923),
        (2.291507, 48.889472), (2.319887, 48.90046),
    ].map({ CLLocationCoordinate2D(latitude: $0.1, longitude: $0.0) })

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add geometry"
        
        let url = URL(
            string: "https://api.jawg.io/styles/jawg-dark.json?access-token="
                + accessToken)
        mapView = MLNMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: 48.8534, longitude: 2.3488),
            zoomLevel: 10,
            animated: false)
        view.addSubview(mapView)

    }

    func mapViewDidFinishLoadingMap(_ mapView: MLNMapView) {
        addPolyline(to: mapView.style!)
    }

    func addPolyline(to style: MLNStyle) {
        // Add the data source to the loaded style
        let polyline = MLNPolylineFeature(
            coordinates: parisBoundaries, count: UInt(parisBoundaries.count))
        let source = MLNShapeSource(
            identifier: "polyline", shape: polyline, options: nil)
        style.addSource(source)
        
        // Add the styled layer to style our polyline
        let layer = MLNLineStyleLayer(identifier: "polyline", source: source)
        layer.lineJoin = NSExpression(forConstantValue: "round")
        layer.lineCap = NSExpression(forConstantValue: "round")
        layer.lineColor = NSExpression(forConstantValue: UIColor.systemBlue)
        // The line width should gradually increase based on the zoom level.
        layer.lineWidth = NSExpression(
            format:
                "mgl_interpolate:withCurveType:parameters:stops:($zoomLevel, 'linear', nil, %@)",
            [14: 5, 18: 20])
        style.addLayer(layer)
    }
}
