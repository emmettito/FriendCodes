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
        
        pictureView.layer.cornerRadius = pictureView.frame.height / 2
        pictureView.clipsToBounds = true
        pictureView.image = friendCode.picture
    }
}

class FriendListViewController: UIViewController {
    
    var data: DataStorage = DataStorage.shared
    
    @IBOutlet weak var friendListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendListTableView.delegate = self
        friendListTableView.dataSource = self
        
        friendListTableView.allowsSelection = false
        friendListTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        friendListTableView.reloadData()
    }
}

extension FriendListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.friendCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendListCell") as! FriendListCell
        cell.setFriendCode(data.friendCodes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let friendCode = data.friendCodes[indexPath.row]
            
            let message = "Delete \"\(friendCode.name)\" from your friends list?"
            
            let alert = UIAlertController(title: "Delete Friend", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                self.viewDidLoad()
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (action) -> Void in
                self.data.friendCodes.remove(at: indexPath.row)
                let codeStrings = friendCodesStrings()
                UserDefaults.standard.set(codeStrings, forKey: "friends")
                self.friendListTableView.reloadData()
            }))
            
            present(alert, animated: true)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! FriendListCell
//        cell.contentView.backgroundColor = UIColor.white
//    }
}
