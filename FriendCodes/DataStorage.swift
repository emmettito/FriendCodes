//
//  DataStorage.swift
//  Singleton data storage
//

import Foundation

class DataStorage {
    
    static let shared = DataStorage()

    var myFriendCode: FriendCode
    
    var friendCodes = [FriendCode]()

    private init(){
        // TODO: load/save data from UserDefaults
        let friends = UserDefaults.standard.array(forKey: "friends")
        var friendCode = UserDefaults.standard.string(forKey: "code")
        
        if (friends == nil) {
        
            //temporary json
            friendCode = "{\"name\": \"My Name\", \"code\": \"ABCDEFGHIJKL\", \"picture\": \"https://photos.emmettito.com/jolina_black.png\"}"
            
            // temporary picture
            let picture = "https://photos.emmettito.com/jolina_black.png"
            
            // temporary friend data
            myFriendCode = friendCodeFromJson(friendCode!)
            friendCodes.append(FriendCode("Friend1", "ABCDEFGHIJKL", picture))
            friendCodes.append(FriendCode("Friend2", "ABCDEFGHIJKL", picture))
            friendCodes.append(FriendCode("Friend3", "ABCDEFGHIJKL", picture))
            
            var codeStrings : [String] = []
            
            codeStrings.append(friendCodeToJson(friendCodes[0]))
            codeStrings.append(friendCodeToJson(friendCodes[1]))
            codeStrings.append(friendCodeToJson(friendCodes[2]))

            UserDefaults.standard.set(friendCode, forKey: "code")
            UserDefaults.standard.set(codeStrings, forKey: "friends")
        }
        else {
            //friendCodes = friends as! [FriendCode]
            if let length = friends?.count {
                for i in 0..<length {
                    friendCodes.append(friendCodeFromJson(friends?[i] as! String))
                }
            }
            
            myFriendCode = friendCodeFromJson(friendCode!)
        }
    }
}

func friendCodesStrings() -> [String] {
    var codeStrings : [String] = []
    for i in 0..<DataStorage.shared.friendCodes.count {
        codeStrings.append(friendCodeToJson(DataStorage.shared.friendCodes[i]))
    }
    
    return codeStrings
}
