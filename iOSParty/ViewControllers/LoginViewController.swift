//
//  LoginViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserModel.getToken()
           {
            var sm = ServerModel()
            sm.getServers() {model in
                sm = model.first!
                print(sm)
           }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Backend methods
    


}

