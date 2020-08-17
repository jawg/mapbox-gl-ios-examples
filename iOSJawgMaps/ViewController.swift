import UIKit

let accessToken = "YOUR_ACCESS_TOKEN"
let customStyleId = "YOUR_CUSTOM_STYLE_ID" // Only used for the custom style example

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!

    var titles = [
        "Simple map",
        "Add a marker",
        "Add a geometry",
        "Change style",
        "Custom style",
        "Map with popup",
        "Change language"
    ]

    var titleImages: [UIImage] = [
        UIImage(named: "simpleMap.png")!,
        UIImage(named: "addAMarker.png")!,
        UIImage(named: "addAGeometry.png")!,
        UIImage(named: "changeStyle.png")!,
        UIImage(named: "customStyle.png")!,
        UIImage(named: "mapWithPopup.png")!,
        UIImage(named: "changeLanguage.png")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderCollectionReusableView.self,forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        // Do any additional setup after loading the view.
    }

    func showAlertAPICallError(messageToDisplay: String) {
        let alertController = UIAlertController(title: "API call error", message:
            messageToDisplay, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.viewLabel.text = titles[indexPath.item]
        cell.viewImage.image = titleImages[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let name = titles[indexPath.item]
        let view = storyboard?.instantiateViewController(identifier: name)
        if(accessToken == "YOUR_ACCESS_TOKEN"){
            showAlertAPICallError(messageToDisplay: "Please update the access token in ViewController.swift file.")
        }else if(name == "Custom style" && customStyleId == "YOUR_CUSTOM_STYLE_ID"){
            showAlertAPICallError(messageToDisplay: "Please update the custom style id in ViewController.swift file.")
        }
        self.navigationController?.pushViewController(view!, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
        header.configure()
        return header
    }

}
