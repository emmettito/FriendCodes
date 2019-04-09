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
        
        let myFriendCode = data.getMyFriendCode()
        
        nameField.text = myFriendCode.name
        codeField.text = myFriendCode.code
        pictureField.text = myFriendCode.pictureURL!.absoluteString
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
        var myFriendCode = data.getMyFriendCode()
        
        if let name = nameField.text, myFriendCode.name != name {
            myFriendCode.name = name
        }
        
        if let code = codeField.text, myFriendCode.code != code {
            myFriendCode.code = code
        }
        
        if let picture = URL(string: pictureField.text!), myFriendCode.pictureURL != picture {
            if myFriendCode.loadImage(url: picture) {
                myFriendCode.pictureURL = picture
            }
        }
        
        self.data.setMyFriendCode(myFriendCode)
    }
}
