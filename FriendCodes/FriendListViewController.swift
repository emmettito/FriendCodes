//
//  FriendListViewController.swift
//

import UIKit

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: DataStorage
    var friendCodes: [FriendCode]
    
    required init?(coder aDecoder: NSCoder) {
        data = DataStorage.shared
        friendCodes = data.friendCodes
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "FriendListCell")
        cell.textLabel?.text = friendCodes[indexPath.row].code
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
