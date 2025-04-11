import MapLibre
import UIKit

class ChangeStyleViewController: UIViewController, MLNMapViewDelegate,
    UIPickerViewDelegate, UIPickerViewDataSource
{
    @IBOutlet weak var stylePicker: UIPickerView!
    @IBOutlet weak var changeStyle: UIBarButtonItem!

    let styles = [
        "jawg-lagoon", "jawg-streets", "jawg-dark", "jawg-terrain",
        "jawg-sunny", "jawg-light",
    ]
    var mapView = MLNMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title and first style
        title = "style - " + styles[0]
        // Initialize map
        let url = URL(
            string: "https://api.jawg.io/styles/" + styles[0]
                + ".json?access-token=" + accessToken)
        mapView = MLNMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900),
            zoomLevel: 12, animated: false)
        // Add the map to the view
        view.addSubview(mapView)
        // Display picker on click button
        stylePicker.isHidden = true
        // Higher priority for the stylePicker
        view.layer.zPosition = 0
        stylePicker.layer.zPosition = 10
    }

    // Click button
    @IBAction func selected(_ sender: UIBarButtonItem) {
        mapView.isUserInteractionEnabled = false
        stylePicker.isHidden = !stylePicker.isHidden
    }

    // Click picker
    func pickerView(
        _ pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int
    ) {
        title = "style - " + styles[row]
        mapView.styleURL = URL(
            string: "https://api.jawg.io/styles/" + styles[row]
                + ".json?access-token=" + accessToken)
        stylePicker.isHidden = true
        mapView.isUserInteractionEnabled = true
    }

    // Config - Initialize pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return styles[row]
    }

    func pickerView(
        _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
    ) -> Int {
        return styles.count
    }
}
