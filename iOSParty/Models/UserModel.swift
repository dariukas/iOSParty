//
//  UserModel.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import RNCryptor

private let _sharedModel = UserModel()

class UserModel: NSObject {
    
    //var token: String?
    var username: String?
    var password: String?
    
    class var sharedModel : UserModel {
        return _sharedModel
    }
    
    class func getToken(_ credentials: [String: String], completion: @escaping (_ success: Bool) -> Void) {
        iOSPartySession.postRequest(api: api+"tokens", parameters: credentials, headers: ["Content-Type": "application/json"]) {(success, json) in
            if (success) {
                saveToKeychain(credentials: credentials)
                self.parseModel(userDictionary: json)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    class func parseModel(userDictionary: Dictionary<String, String>) {
        //let model = UserModel()
        if let token = userDictionary["token"] {
            //model.token = token
            saveToDefaults(token: token)
        }
       // UserModel.sharedModel = userModel
    }

//    class func getToken(completion: @escaping () -> Void) {
//        iOSPartySession.postRequest(api: api+"tokens", parameters: ["username": "tesonet", "password": "partyanimal"], headers: ["Content-Type": "application/json"]) {(success, json) in
//            if (success) {
//                self.parseModel(userDictionary: json)
//                completion()
//            } else {
//                //alert
//            }
//        }
//    }
    
    // MARK: - Helpers
    
//    class func saveLoginData(userModel : UserModel?) -> Void {
//        let userModelDic = NSMutableDictionary()
        //userModelDic.setValue(userModel?.token, forKey: "Token")
//    }
    
    class func saveToDefaults(token: String) {
        //print(decryptToString(data: encryptString(string: token)))
        let defaults = UserDefaults.standard
        defaults.setValue(encryptString(string: token), forKey: "Token")
        defaults.synchronize()
    }
    
    class func saveToKeychain(credentials: [String: String]) {
        let keychainItemWrapper = KeychainItemWrapper(identifier: "identifier for this item", accessGroup: "access group if shared")
        keychainItemWrapper["secretUsername"] = credentials["username"] as AnyObject?
        keychainItemWrapper["secretPassword"] = credentials["password"] as AnyObject?
    }
    
    // Encryption
    class func encryptString(string: String) -> Data {
        guard let data: Data = string.data(using: .utf8) else {
            return Data()
        }
        return RNCryptor.encrypt(data: data, withPassword: "Secret")
    }
    
    // Decryption
    class func decryptToString(data: Data) -> String {
        do {
            let originalData = try RNCryptor.decrypt(data: data, withPassword: "Secret")
            if let string = String(data: originalData, encoding: .utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return String()
    }
}
