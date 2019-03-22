//
//  DataStorage.swift
//  Singleton data storage
//

import Foundation

class DataStorage {
    
    static let shared = DataStorage()

    var name: String
    var code: String
    var picture: String
    
    var friendCodes = [FriendCode]()

    private init(){
        // load data from UserDefaults
        name = ""
        code = ""
        // temporary picture
        picture = "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"
        
        // temporary friend data
        friendCodes.append(FriendCode("Friend1", "code1", picture))
        friendCodes.append(FriendCode("Friend2", "code2", picture))
        friendCodes.append(FriendCode("Friend3", "code3", picture))
    }
    
}