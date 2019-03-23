//
//  FriendCodeViewController.swift
//

import UIKit

class FriendCodeViewController: UIViewController {
    
    var data: DataStorage!
    var pictureURL: URL!
    
    @IBOutlet weak var qRCodeView: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        pictureURL = data.myFriendCode.pictureURL
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func generateQRCode(_ string: String, _ x: CGFloat, _ y: CGFloat) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            let scaleX = x / (filter.outputImage?.extent.size.width)!
            let scaleY = y / (filter.outputImage?.extent.size.height)!
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if name.text == nil || code.text == nil || pictureURL == nil || name.text != data.myFriendCode.name || code.text != data.myFriendCode.code || pictureURL != data.myFriendCode.pictureURL {
            updateViews()
        }
    }
    
    func updateViews() {
        print("updateViews")
        let image = generateQRCode(data.myFriendCode.toJson(), qRCodeView.frame.size.width, qRCodeView.frame.size.height)
        
        if image != nil {
            qRCodeView.image = image
        }
        
        picture.layer.cornerRadius = picture.frame.height / 2
        picture.clipsToBounds = true

        pictureURL = data.myFriendCode.pictureURL
        
        picture.image = data.myFriendCode.picture
        name.text = data.myFriendCode.name
        code.text = data.myFriendCode.code
    }
    
}

//    ASYNCHRONOUS IMAGE LOADER
//    USAGE: imageView.downloaded(from: URL)
//
//    extension UIImageView {
//        func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//            contentMode = mode
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                guard
//                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                    let data = data, error == nil,
//                    let image = UIImage(data: data)
//                    else { return }
//                DispatchQueue.main.async() {
//                    self.image = image
//                }
//                }.resume()
//        }
//
//        func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//            guard let url = URL(string: link) else { return }
//            downloaded(from: url, contentMode: mode)
//        }
//    }
//
