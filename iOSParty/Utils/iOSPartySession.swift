//
//  iOSPartySession.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit
import Alamofire

let api = "http://playground.tesonet.lt/v1/"

class iOSPartySession: NSObject {
    
    class func postRequest(api: String, parameters: [String:String]?, headers: HTTPHeaders?, completion: @escaping (_ success: Bool, _ json: Dictionary<String, String>) -> Void) {
        Alamofire.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON(completionHandler: {response in
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    //print("JSON: \(json)")
                    completion(true, json as! Dictionary<String, String>)
                }
            case .failure(let error):
                completion(false, ["Error":error.localizedDescription])
            }
        }
        )
    }
    
    class func getRequest(api: String, headers: HTTPHeaders?, completion: @escaping (_ success : Bool, _ json: AnyObject) -> Void) {
        Alamofire.request(api, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON(completionHandler: {response in
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    //print("JSON: \(json)")
                    completion(true, json as AnyObject)
                }
            case .failure(let error):
                completion(false, error as AnyObject)
                break
                //print(error)
                //completion(error as! Dictionary<String, String>)
                //completion(false, ["Error":error.localizedDescription])
            }
        }
        )
    }
}
