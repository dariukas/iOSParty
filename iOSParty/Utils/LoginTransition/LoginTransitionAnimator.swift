//
//  LoginTransitionAnimator.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 02/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import UIKit

class LoginTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
//    var transitionContext: UIViewControllerContextTransitioning?
    var originFrame = CGRect.zero
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //ovalAnimation(transitionContext: transitionContext)
        revealAnimation(transitionContext: transitionContext)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
    
    //https://www.raywenderlich.com/110536/custom-uiviewcontroller-transitions
    func revealAnimation(transitionContext: UIViewControllerContextTransitioning) {
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
    
    //Source: http://zappdesigntemplates.com/expanding-circle-viewcontroller-transition/
    func ovalAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //self.transitionContext = transitionContext
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! LoadingViewController
        let containerView = transitionContext.containerView
        let destinationController: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let destinationView = destinationController.view
        containerView.addSubview(fromViewController.view)
        containerView.addSubview(destinationView!)
        
        let initialFrame = fromViewController.loaderView.frame
        let maskPath = UIBezierPath(ovalIn: initialFrame)
        
        // define the masking layer to be able to show that circle animation
        let maskLayer = CAShapeLayer()
        maskLayer.frame = (destinationView?.frame)!
        maskLayer.path = maskPath.cgPath
        destinationController.view.layer.mask = maskLayer
        
        // define the end frame
        let finalFrame = transitionContext.finalFrame(for: destinationController)
        let bigCirclePath = UIBezierPath(ovalIn: finalFrame)
        
        // create the animation
        let pathAnimation = CABasicAnimation(keyPath: "path")
        //pathAnimation.delegate = self
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = transitionDuration(using: transitionContext)
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathAnimation")
    }

    // MARK: - CAAnimationDelegate
    
//    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        if let transitionContext = self.transitionContext {
//            transitionContext.completeTransition(true)
//        }
//    }
    
}
