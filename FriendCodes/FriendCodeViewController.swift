//
//  FriendCodeViewController.swift
//

import UIKit

class FriendCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("FriendCodeView")
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
