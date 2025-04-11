import MapLibre
import UIKit

class AddPopupViewController: UIViewController, MLNMapViewDelegate {
    var mapView = MLNMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Custom Popup"

        let url = URL(
            string: "https://api.jawg.io/styles/jawg-sunny.json?access-token="
                + accessToken)
        mapView = MLNMapView(frame: view.bounds, styleURL: url)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(
            CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900),
            zoomLevel: 11, animated: false)
        // Add an annotation
        let operaHouseAnnotation = CustomAnnotation(
            coordinate: CLLocationCoordinate2D(
                latitude: -33.85416325, longitude: 151.20916),
            title: "Opera House",
            subtitle: "The most beautiful opera house in the world!",
            image: UIImage(named: "operaHouse.jpeg")!)
        mapView.addAnnotation(operaHouseAnnotation)
        // Add an annotation
        let sydneyParkAnnotation = CustomAnnotation(
            coordinate: CLLocationCoordinate2D(
                latitude: -33.9105284, longitude: 151.1846209),
            title: "Sydney Park",
            subtitle: "The open space is made of 40 hectares of lush grass",
            image: UIImage(named: "sydneyPark.jpeg")!)
        mapView.addAnnotation(sydneyParkAnnotation)
        // Add an annotation
        let bondiBeachAnnotation = CustomAnnotation(
            coordinate: CLLocationCoordinate2D(
                latitude: -33.890842, longitude: 151.274292),
            title: "Bondi Beach", subtitle: "Do not forget your surfboard",
            image: UIImage(named: "bondiBeach.jpeg")!)
        mapView.addAnnotation(bondiBeachAnnotation)
        // Add the map to the view
        view.addSubview(mapView)
    }

    // This delegate method is where you tell the map to load a view for a specific annotation. To load a static MLNAnnotationImage, you would use `-mapView:imageForAnnotation:`.
    func mapView(_ mapView: MLNMapView, viewFor annotation: MLNAnnotation)
        -> MLNAnnotationView?
    {
        // This example is only concerned with point annotations.
        guard annotation is CustomAnnotation else {
            return nil
        }
        // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
        let reuseIdentifier = "\(annotation.coordinate.longitude)"
        // For better performance, always try to reuse existing annotations.
        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: reuseIdentifier)
        // If there’s no reusable annotation view available, initialize a new one.
        if annotationView == nil {
            annotationView = CustomAnnotationView(
                annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView!.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
            // Set the annotation view’s background color to a value determined by its longitude.
            let hue = CGFloat(annotation.coordinate.longitude) / 100
            annotationView!.backgroundColor = UIColor(
                hue: hue, saturation: 0.5, brightness: 1, alpha: 1)
        }
        return annotationView
    }

    func mapView(
        _ mapView: MLNMapView,
        annotationCanShowCallout annotation: MLNAnnotation
    ) -> Bool {
        return true
    }

    func mapView(
        _ mapView: MLNMapView, calloutViewFor annotation: MLNAnnotation
    ) -> MLNCalloutView? {
        // Instantiate and return our custom callout view.
        return CustomCalloutView(annotation: annotation as! CustomAnnotation)
    }

    func mapView(
        _ mapView: MLNMapView, tapOnCalloutFor annotation: MLNAnnotation
    ) {
        // Optionally handle taps on the callout.
        print("Tapped the callout for: \(annotation)")
        // Hide the callout.
        mapView.deselectAnnotation(annotation, animated: true)
    }
}

class CustomAnnotation: NSObject, MLNAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage

    init(
        coordinate: CLLocationCoordinate2D, title: String, subtitle: String,
        image: UIImage
    ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

// MLNAnnotationView subclass
class CustomAnnotationView: MLNAnnotationView {

    override init(annotation: MLNAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Animate the border width in/out, creating an iris effect.
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? bounds.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
    }
}

class CustomCalloutView: UIView, MLNCalloutView {

    var representedObject: MLNAnnotation
    // Required views but unused for now, they can just relax
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()

    weak var delegate: MLNCalloutViewDelegate?

    //MARK: Subviews -
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let imageView: UIImageView = {
        let imageview = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()

    required init(annotation: CustomAnnotation) {
        self.representedObject = annotation
        // init with 100% of width and 200px tall
        super.init(
            frame: CGRect(
                origin: CGPoint(),
                size: CGSize(width: UIScreen.main.bounds.width, height: 200)))

        self.titleLabel.text = self.representedObject.title ?? ""
        self.subtitleLabel.text = self.representedObject.subtitle ?? ""
        self.imageView.image = annotation.image
        setup()
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        // setup this view's properties
        self.backgroundColor = UIColor.white
        // And their Subviews
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(imageView)
        // Add Constraints to subviews
        let spacing: CGFloat = 8.0
        imageView.topAnchor.constraint(
            equalTo: self.topAnchor, constant: spacing
        ).isActive = true
        imageView.leftAnchor.constraint(
            equalTo: self.leftAnchor, constant: spacing
        ).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 52.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 52.0).isActive = true

        titleLabel.topAnchor.constraint(
            equalTo: self.topAnchor, constant: spacing
        ).isActive = true
        titleLabel.leftAnchor.constraint(
            equalTo: self.imageView.rightAnchor, constant: spacing * 2
        ).isActive = true
        titleLabel.rightAnchor.constraint(
            equalTo: self.rightAnchor, constant: -spacing
        ).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive =
            true

        subtitleLabel.topAnchor.constraint(
            equalTo: self.titleLabel.bottomAnchor, constant: spacing
        ).isActive = true
        subtitleLabel.leftAnchor.constraint(
            equalTo: self.leftAnchor, constant: spacing
        ).isActive = true
        subtitleLabel.rightAnchor.constraint(
            equalTo: self.rightAnchor, constant: -spacing
        ).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive =
            true
    }

    func presentCallout(
        from rect: CGRect, in view: UIView,
        constrainedTo constrainedRect: CGRect, animated: Bool
    ) {
        //Center bottom
        self.center = view.center.applying(
            CGAffineTransform(
                translationX: 0,
                y: view.bounds.height / 2 - self.bounds.height / 2))
        view.addSubview(self)
    }

    func dismissCallout(animated: Bool) {
        if animated {
            //Implement animation here
            removeFromSuperview()
        } else {
            removeFromSuperview()
        }
    }
}
