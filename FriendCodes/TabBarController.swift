//
//  TabBarController.swift
//

import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedViewController = self.viewControllers?[1]
    }
}
