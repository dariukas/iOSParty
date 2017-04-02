//
//  LoginTransitionAnimator.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 02/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//
//https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions

import UIKit

class LoginTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    //var transitionContext: UIViewControllerContextTransitioning?
    var originFrame = CGRect.zero
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //        self.transitionContext = transitionContext
        //        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! LoadingViewController
        //        let containerView = transitionContext.containerView
        //        let destinationController: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        //        let destinationView = destinationController.view
        
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let containerView = transitionContext.containerView
        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        snapshot?.layer.cornerRadius = 25
        snapshot?.layer.masksToBounds = true
        containerView.addSubview(snapshot!)
        
        containerView.addSubview(toVC.view)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView: containerView)
        snapshot?.layer.transform = AnimationHelper.yRotation(angle: M_PI_2)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                // 2
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                    fromVC.view.layer.transform = AnimationHelper.yRotation(angle: -M_PI_2)
                })
                
                // 3
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    snapshot?.layer.transform = AnimationHelper.yRotation(angle: 0.0)
                })
                
                // 4
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    snapshot?.frame = finalFrame
                })
        },
            completion: { _ in
                // 5
                toVC.view.isHidden = false
                fromVC.view.layer.transform = AnimationHelper.yRotation(angle: 0.0)
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
        
    }
}
