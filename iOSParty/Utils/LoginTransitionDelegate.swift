//
//  LoginTransitionDelegate.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 02/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return LoginTransitionAnimator()
//    }
    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return LoginTransitionAnimatorDismiss()
//    }
}

//class LoginTransitionAnimator: UIViewControllerAnimatedTransitioning {
//
//    var transitionContext: UIViewControllerContextTransitioning?
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        self.transitionContext = transitionContext
//        
//        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as ViewController
//        let destinationController: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
//        let destinationView = destinationController.view
//        
//        let containerView = transitionContext.containerView
//        
//        // we are not done yet
//    }
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.5
//    }
//}
