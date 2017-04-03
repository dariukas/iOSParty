//
//  ServerModel.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class ServerModel: NSObject {
    
    var distance: Int?
    var name: String?
    
    func getServers(completion: @escaping (_ models: [ServerModel]) -> Void) {
        
        guard let data =  UserDefaults.standard.value(forKey: "Token") as? Data else {
            return
        }
        
        iOSPartySession.getRequest(api: api+"servers", headers: ["Content-Type": "application/json", "Authorization": UserModel.decryptToString(data: data)]) {(success, json) in
            if (success) {
                completion(self.parseModels(data: json as! Array<AnyObject>))
            } else {
                //alert
            }
        }
    }
    
    func parseModels(data: Array<AnyObject>) -> [ServerModel] {
        //print(data)
        return data.flatMap{parseModel($0 as! Dictionary<String, AnyObject>)}
    }
    
    func parseModel(_ userDictionary: Dictionary<String, AnyObject>) -> ServerModel {
        let model = ServerModel()
        if let distance = userDictionary["distance"] as? Int,  let name = userDictionary["name"] as? String {
            model.distance = distance
            model.name = name
        }
        return model
    }
    
}
