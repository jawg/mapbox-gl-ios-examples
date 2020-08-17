import UIKit
import Mapbox

class ChangeLanguageViewController: UIViewController, MGLMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    // Update the token here if you want to customize the token for this controller in your own project.
    // Otherwise update the value at the top of the main controller: ViewController.swift.
    // let accessToken = "YOUR_ACCESS_TOKEN"

    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet weak var changeLanguage: UIBarButtonItem!

    let languages = ["en","fr","it","es","de","nl","zh"]
    var mapView = MGLMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize title and first style
        title = languages[0]
        // Initialize map
        let url = URL(string: "https://api.jawg.io/styles/jawg-sunny.json?lang="+title!+"&access-token="+accessToken)
        mapView = MGLMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900), zoomLevel: 3, animated: false)
        // Add the map to the view
        view.addSubview(mapView)
        // Display picker on click button
        languagePicker.isHidden = true
        // Higher priority for the stylePicker
        view.layer.zPosition = 0
        languagePicker.layer.zPosition = 10
    }

    // Click button
    @IBAction func selected(_ sender: UIBarButtonItem) {
        mapView.isUserInteractionEnabled = false
        languagePicker.isHidden = !languagePicker.isHidden
    }

    // Click picker
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        title = languages[row]
        mapView.styleURL = URL(string: "https://api.jawg.io/styles/jawg-sunny.json?lang="+title!+"&access-token="+accessToken)
        languagePicker.isHidden = true
        mapView.isUserInteractionEnabled = true
    }

    // Config - Initialize pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
}
