//
//  SettingsCodeViewController.swift
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    var data: DataStorage
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var pictureField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        
        nameField.text = data.myFriendCode.name
        codeField.text = data.myFriendCode.code
        pictureField.text = data.myFriendCode.pictureURL!.absoluteString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Redisplay the navigation bar when switching to child views
        
        if let name = nameField.text, data.myFriendCode.name != name {
            data.myFriendCode.name = name
        }
        
        if let code = codeField.text, data.myFriendCode.code != code {
            data.myFriendCode.code = code
        }
        
        if let picture = URL(string: pictureField.text!), data.myFriendCode.pictureURL != picture {
            if data.myFriendCode.loadImage(url: picture) {
                data.myFriendCode.pictureURL = picture
            }
        }
        
        UserDefaults.standard.set(data.myFriendCode, forKey: "code")
    }
}
