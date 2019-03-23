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
        // load data from UserDefaults
        // temporary picture
        let picture = "https://photos.emmettito.com/jolina_black.png"
        
        // temporary friend data
        myFriendCode = FriendCode("My Name", "ABCDEFGHIJKL", picture)
        friendCodes.append(FriendCode("Friend1", "ABCDEFGHIJKL", picture))
        friendCodes.append(FriendCode("Friend2", "ABCDEFGHIJKL", picture))
        friendCodes.append(FriendCode("Friend3", "ABCDEFGHIJKL", picture))
    }
    
}
