//
//  CircularLoaderView.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 01/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//
//https://www.raywenderlich.com/94302/implement-circular-image-loader-animation-cashapelayer

import UIKit

class CircularLoaderView: UIView, CAAnimationDelegate {

    let circlePathLayer = CAShapeLayer()
    let circleRadius: CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        circlePathLayer.frame = bounds
        circlePathLayer.lineWidth = 5
        circlePathLayer.fillColor = UIColor.clear.cgColor
        circlePathLayer.strokeColor = UIColor.white.cgColor
        layer.addSublayer(circlePathLayer)
        //backgroundColor = UIColor.red
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circlePathLayer.frame = bounds
        setPath(circlePathLayer)
        animate()
    }
    
    private func setPath(_ layer: CAShapeLayer) {
        layer.path = UIBezierPath(ovalIn: bounds.insetBy(dx: layer.lineWidth / 2, dy: layer.lineWidth / 2)).cgPath
    }
    
    var progress: CGFloat {
        get {
            return circlePathLayer.strokeEnd
        }
        set {
            if (newValue > 1) {
                circlePathLayer.strokeEnd = 1
            } else if (newValue < 0) {
                circlePathLayer.strokeEnd = 0
            } else {
                circlePathLayer.strokeEnd = newValue
            }
        }
    }
    
    func animate() {
        let pathStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        pathStartAnimation.duration = 1.0
//        pathStartAnimation.repeatCount = 9.0
        pathStartAnimation.fromValue = 0
        pathStartAnimation.toValue = 0.5
        
        let pathEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        //        pathEndAnimation.duration = 1.0
        //        pathEndAnimation.repeatCount = 10.0
        pathEndAnimation.fromValue = 0
        pathEndAnimation.toValue = 1

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [pathStartAnimation, pathEndAnimation]
        groupAnimation.duration = 1.0
        groupAnimation.repeatCount = 5.0
        groupAnimation.delegate = self
        circlePathLayer.add(groupAnimation, forKey: nil)
//        circlePathLayer.add(pathStartAnimation, forKey: "strokeStart")
//        circlePathLayer.add(pathEndAnimation, forKey: "strokeEnd")
        //#keyPath(circlePathLayer.strokeEnd)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - CAAnimation​Delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
    }

}
