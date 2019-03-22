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
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
