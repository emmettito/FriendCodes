//
//  FriendCodeViewController.swift
//

import UIKit

class FriendCodeViewController: UIViewController {
    
    var data: DataStorage
    
    @IBOutlet weak var qRCodeView: UIImageView!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var code: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FriendCodeView")
    
        let image = generateQRCode(data.myFriendCode.toJson(), qRCodeView.frame.size.width, qRCodeView.frame.size.height)
        
        if image != nil {
            qRCodeView.image = image
        }
        
        
        print(picture.frame.height)
        print(picture.frame.width)
        picture.layer.cornerRadius = picture.frame.height / 2
        picture.clipsToBounds = true
        
        picture.downloaded(from: data.myFriendCode.picture)
        name.text = data.myFriendCode.name
        code.text = data.myFriendCode.code
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
        // Hide the navigation bar to match the other "sibling" views
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Redisplay the navigation bar when switching to child views
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
