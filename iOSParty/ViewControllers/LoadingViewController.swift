//
//  LoadingViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addViewStyle()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Style methods
    
    func addViewStyle() {
        if let image:UIImage  = UIImage(named:"bg"){
            self.view.backgroundColor = UIColor(patternImage: image.maskWithColor(color: .red, in: self.view.bounds))
        }
    }
    
    // MARK: - Backend methods
    


}

