//
//  DataStorage.swift
//  Singleton data storage
//

import Foundation

class DataStorage {
    
    static let shared = DataStorage()

    private var myFriendCode: FriendCode?
    
    private var friendCodes = [FriendCode]()

    private init(){
        // load/save data from UserDefaults
        let code = UserDefaults.standard.string(forKey: "code")
        let friends = UserDefaults.standard.array(forKey: "friends")
        
        if (code != nil) {
            myFriendCode = friendCodeFromJson(code!)
        }
        else {
            // temporary friend data
            let tempCode: String = "{\"name\": \"My Name\", \"code\": \"ABCDEFGHIJKL\", \"picture\": \"https://photos.emmettito.com/jolina_black.png\"}"
            setMyFriendCode(friendCodeFromJson(tempCode))
        }
        
        if (friends != nil) {
            for i in 0..<friends!.count {
                friendCodes.append(friendCodeFromJson(friends![i] as! String))
            }
        }
    }
    
    func getMyFriendCode() -> FriendCode {
        return myFriendCode!
    }
    
    func setMyFriendCode(_ myFriendCode: FriendCode) {
        self.myFriendCode = myFriendCode
        
        let code = friendCodeToJson(myFriendCode)
        UserDefaults.standard.set(code, forKey: "code")
    }
    
    func getFriendCodes() -> [FriendCode] {
        return friendCodes
    }
    
    func setFriendCodes(_ friendCodes: [FriendCode]) {
        self.friendCodes = friendCodes
        
        var codeStrings = [String]()
        
        for i in 0..<self.friendCodes.count {
            codeStrings.append(friendCodeToJson(self.friendCodes[i]))
        }
        
        UserDefaults.standard.set(codeStrings, forKey: "friends")
    }
}
