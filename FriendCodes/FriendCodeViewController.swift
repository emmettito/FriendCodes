//
//  FriendCodeViewController.swift
//

import UIKit

class FriendCodeViewController: UIViewController {
    
    var data: DataStorage
    
    @IBOutlet weak var qRCodeView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("FriendCodeView")
        print(data.myFriendCode.toJson())
    
        let image = generateQRCode("https://www.emmettito.com", qRCodeView.frame.size.width, qRCodeView.frame.size.height)
        
        if image != nil {
            qRCodeView.image = image
        }
        
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Redisplay the navigation bar when switching to child views
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
