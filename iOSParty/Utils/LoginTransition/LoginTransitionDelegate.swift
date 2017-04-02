//
//  LoginTransitionDelegate.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 02/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let loginTransitionAnimator = LoginTransitionAnimator()
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        loginTransitionAnimator.originFrame = source.view.frame
        return loginTransitionAnimator
    }
    
    //    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    //        return LoginTransitionAnimatorDismiss()
    //    }
}
