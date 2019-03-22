//
//  SettingsCodeViewController.swift
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var data: DataStorage
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
        
        // encode image to base64
        let imageData = image.pngData()!
        let image64: String = imageData.base64EncodedString(options: .lineLength64Characters)
        print(image64)
        
        // decode image from base64
        let decodedData = Data(base64Encoded: image64, options: .ignoreUnknownCharacters)!
        let decodedImage = UIImage(data: decodedData)
        imageView.image = decodedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
