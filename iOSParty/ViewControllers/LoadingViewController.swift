//
//  LoadingViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var loaderView: CircularLoaderView!
    fileprivate let loginTransitionAnimator = LoginTransitionAnimator()
    var models = [ServerModel]()
    var userModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let username = userModel.username, let password = userModel.password {
            getList(credentials: ["username": username, "password": password])
        }
//        let keychainItemWrapper = KeychainItemWrapper(identifier: "identifier for this item", accessGroup: "access group if shared")
//        if let username = keychainItemWrapper["secretUsername"] as? String, let password = keychainItemWrapper["secretPassword"] as? String {
//                    getList(credentials: ["username": username, "password": password])
//        }
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
            self.view.backgroundColor = UIColor(patternImage: image.maskWithColor(color: .tesonetBlueColor(), in: self.view.bounds))
        }
        //        loaderView.progress = CGFloat(i/10)/CGFloat(1)
    }
    
    // MARK: - Backend methods
    
    func getList(credentials: [String: String]) {
        UserModel.getToken(credentials)
        {success in
            if (success) {
                let sm = ServerModel()
                sm.getServers() {models in
                    self.models = models
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loadingToServers", sender: nil)
                    }
                }
            } else{
                let alert = UIAlertController(title: "tesonet", message: "The username or the password is incorrect! Please, check them.", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                    self.performSegue(withIdentifier: "loadingToLogin", sender: nil)
                })
                self.present(alert, animated: true)
            }
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "loadingToServers", let destinationViewController: ServersViewController  = segue.destination as? ServersViewController {
            destinationViewController.transitioningDelegate = self
            destinationViewController.models = self.models
//             destinationViewController.transitioningDelegate = LoginTransitionDelegate()
//            destinationViewController.modalPresentationStyle = .custom
//            let destinationViewController: UIViewController = segue.destination as UIViewControlle
            //           DispatchQueue.main.async {
            //self.present(destinationViewController, animated: true, completion: { _ in })
            //            }
        }
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        loginTransitionAnimator.originFrame = view.frame
        return loginTransitionAnimator
    }
}

//extension LoadingViewController: UIViewControllerTransitioningDelegate {

//}

