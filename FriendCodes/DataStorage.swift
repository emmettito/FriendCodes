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
        
        //temporary json
        let json = "{\"name\": \"My Name\", \"code\": \"ABCDEFGHIJKL\", \"picture\": \"https://photos.emmettito.com/jolina_black.png\"}"
        
        // temporary picture
        let picture = "https://photos.emmettito.com/jolina_black.png"
        
        // temporary friend data
        myFriendCode = friendCodeFromJson(json)
        friendCodes.append(FriendCode("Friend1", "ABCDEFGHIJKL", picture))
        friendCodes.append(FriendCode("Friend2", "ABCDEFGHIJKL", picture))
        friendCodes.append(FriendCode("Friend3", "ABCDEFGHIJKL", picture))
    }
    
}
