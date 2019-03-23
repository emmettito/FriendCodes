//
//  FriendCode.swift
//

import Foundation
import UIKit

class FriendCode {
    
    var name: String
    var code: String
    var picture: URL
    
    init(_ name: String, _ code: String, _ picture: String) {
        self.name = name
        self.code = code
        self.picture = URL(string: picture)!
    }
    
    func encodeBase64Image(_ image: UIImage) -> String {
        // encode image to base64
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    func decodeBase64Image(_ image: String) -> UIImage {
        // decode image from base64
        let decodedData = Data(base64Encoded: image, options: .ignoreUnknownCharacters)!
        return UIImage(data: decodedData)!
    }
    
    func toJson() -> String {
//        let encodedImage = encodeBase64Image(picture!)
//        let json = "{\"name\": \"\(name!)\", \"code\": \"\(code!)\", \"picture\": \"\(encodedImage)\"}"
        let json = "{\"name\": \"\(name)\", \"code\": \"\(code)\", \"picture\": \"\(picture)\"}"
        return json
    }
}
