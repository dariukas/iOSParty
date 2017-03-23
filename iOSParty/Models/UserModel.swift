//
//  UserModel.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

private let _sharedModel = UserModel()

class UserModel: NSObject {
    
    var token: String?
    
    class var sharedModel : UserModel {
        return _sharedModel
    }
    
    class func getToken(completion: @escaping () -> Void) {
        iOSPartySession.postRequest(api: api+"tokens", parameters: ["username": "tesonet", "password": "partyanimal"], headers: ["Content-Type": "application/json"]) {(success, json) in
            if (success) {
                self.parseModel(userDictionary: json)
                completion()
            } else {
                //alert
            }
        }
    }
    
    class func parseModel(userDictionary: Dictionary<String, String>) {
        let model = UserModel()
        if let token = userDictionary["token"] {
            model.token = token
            print(token)
            let defaults = UserDefaults.standard
            defaults.setValue(token, forKey: "Token")
            defaults.synchronize()
        }
        //userModel.token             = Utils.encryptToken(userDictionary.valueForKey("Token") as! String)
       // UserModel.sharedModel = userModel
    }
    
    class func saveLoginData(userModel : UserModel?) -> Void {
        let userModelDic = NSMutableDictionary()
        userModelDic.setValue(userModel?.token, forKey: "Token")
        //Utils.addDefaultsValue(userModelDic.mutableCopy(), key: "LoginUserModel")
    }
}
