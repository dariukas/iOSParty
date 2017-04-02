//
//  LoginTransitionDelegate.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 02/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    fileprivate let loginTransitionAnimator = LoginTransitionAnimator()
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        loginTransitionAnimator.originFrame = source.view.frame
        return loginTransitionAnimator
    }
    
    //    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    //        return LoginTransitionAnimatorDismiss()
    //    }
}
