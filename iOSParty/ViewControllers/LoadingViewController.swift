//
//  LoadingViewController.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 23/03/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController, UIViewControllerTransitioningDelegate  {
    
    @IBOutlet weak var loaderView: CircularLoaderView!
    fileprivate let loginTransitionAnimator = LoginTransitionAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserModel.getToken()
            {
                var sm = ServerModel()
                sm.getServers() {model in
                    sm = model.first!
                    print(sm)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loadingToServers", sender: nil)
                    }
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
        
        //        for i in 0..<10 {
        //        loaderView.progress = CGFloat(i/10)/CGFloat(1)
        //        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else { return }
        if id == "loadingToServers", let destinationViewController: UIViewController = segue.destination as? ServersViewController {
            destinationViewController.transitioningDelegate = self
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

