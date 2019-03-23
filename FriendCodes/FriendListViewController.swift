//
//  FriendListViewController.swift
//

import UIKit

class FriendListCell: UITableViewCell {
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var codeView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    func setFriendCode(_ friendCode: FriendCode) {
        nameView.text = friendCode.name
        codeView.text = friendCode.code
        
//        pictureView.layer.masksToBounds = false
//        pictureView.layer.cornerRadius = pictureView.frame.height/2
//        pictureView.clipsToBounds = true
        
        pictureView.image = friendCode.picture
    }
}

class FriendListViewController: UIViewController {
    
    var friendCodes: [FriendCode] = DataStorage.shared.friendCodes
    
    @IBOutlet weak var friendListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
    }
    
}

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell") as! FriendListCell
        cell.setFriendCode(friendCodes[indexPath.row])
        return cell
    }
}
