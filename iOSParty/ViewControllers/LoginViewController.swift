//
//  LoginViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addViewStyles()
        addGestures()
    }
    
    // MARK: - Style methods
    
    func addViewStyles() {
        //self.view.backgroundColor = .tesonetBlueColor()
        if let image:UIImage  = UIImage(named:"bg"){
            self.view.backgroundColor = UIColor(patternImage: image.maskWithColor(color: .red, in: self.view.bounds))
        }
        addImageToTexField(usernameTextField, "ico-username")
        addImageToTexField(passwordTextField, "ico-password")
        loginButton.layer.cornerRadius = 5
    }
    
    func addGestures() {
        //gesture to navigate
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector(("showSecondViewController")))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.up
        view.addGestureRecognizer(swipeGestureRecognizer)
        
        //tapping anywhere on the screen ends UITextField editting
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
    }
    
    func addImageToTexField(_ textField: UITextField, _ imageName: String) {
        if let image:UIImage  = UIImage(named: imageName){
            textField.leftViewMode = .always
            let imageView = UIImageView(image: image.addImagePadding(x: 15, y: 15))
               // = (textField.leftView?.frame.insetBy(dx: 10.0, dy: 10.0))!
            textField.leftView = imageView
            view.setNeedsDisplay()
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        
    }
    
    func hideKeyBoard(sender: UITapGestureRecognizer? = nil){
        view.endEditing(true)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: - Backend methods
    
}

