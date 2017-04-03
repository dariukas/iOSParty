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
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addViewStyles()
        addGestures()
        setTextFieldsFromKeychain()
    }
    
    // MARK: - Style methods
    
    func addViewStyles() {
        //self.view.backgroundColor = .tesonetBlueColor()
        if let image:UIImage  = UIImage(named:"bg"){
            self.view.backgroundColor = UIColor(patternImage: image.maskWithColor(color: .tesonetBlueColor(), in: self.view.bounds))
        }
        addImageToTexField(usernameTextField, "ico-username")
        addImageToTexField(passwordTextField, "ico-password")
        loginButton.layer.cornerRadius = 5
        passwordTextField.isSecureTextEntry = true
    }
    
    func addGestures() {
        //gesture to navigate
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(LoginViewController.navigateNext))
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
    
    func setTextFieldsFromKeychain() {
        let keychainItemWrapper = KeychainItemWrapper(identifier: "identifier for this item", accessGroup: "access group if shared")
        if let username = keychainItemWrapper["secretUsername"] as? String, let password = keychainItemWrapper["secretPassword"] as? String {
            usernameTextField.text = username
            passwordTextField.text = password
        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
       login()
    }
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){
        
    }
    
    func hideKeyBoard(sender: UITapGestureRecognizer? = nil){
        view.endEditing(true)
    }
    
    func login() {
        guard let username = usernameTextField.text, let password = passwordTextField.text, username.characters.count>0,  password.characters.count>0  else {
            let alert = UIAlertController(title: "tesonet", message: "The username and the password are required! Please, type them.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
            })
            present(alert, animated: true)
            return
        }
        userModel.username = username
        userModel.password = password
    }
    
    func navigateNext() {
        login()
        self.performSegue(withIdentifier: "loginToLoading", sender: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    // MARK: - Backend methods
    
//    func request() {
//        UserModel.getToken()
//            {
//                var sm = ServerModel()
//                sm.getServers() {models in
//                    sm = models.first!
//                    print(sm)
//                }
//        }
//    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "loginToLoading", let destinationViewController: LoadingViewController  = segue.destination as? LoadingViewController {
            destinationViewController.userModel = self.userModel
        }
    }
}

