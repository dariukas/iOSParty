//
//  Extensions.swift
//  iOSParty
//
//  Created by Darius Miliauskas on 01/04/2017.
//  Copyright © 2017 Darius Miliauskas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func tesonetBlueColor() -> UIColor {
        return UIColor(red:53.0/255.0, green:58.0/255.0, blue:79.0/255.0, alpha:1);
        
    }
    
    class func tesonetGreenColor() -> UIColor {
        return UIColor(red:159.0/255.0, green:213.0/255.0, blue:51.0/255.0, alpha:1);
    }
}

extension UIImage {
    
    func maskWithColor(color:UIColor, in rect: CGRect) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.translateBy(x: 0, y: rect.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        //let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        if let image:CGImage  = self.cgImage {
            context.draw(image.cropping(to: CGRect(x: self.size.width/3, y: 0, width: self.size.width/3, height: self.size.height))!, in: rect)
        }
        
        context.setBlendMode(CGBlendMode.overlay)
        context.addRect(rect)
        context.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        //        else {
        //            return
        //        }
        
        UIGraphicsEndImageContext()
        
        return coloredImage!
    }
    
    func addImagePadding(x: CGFloat, y: CGFloat) -> UIImage {
        let width: CGFloat = self.size.width + x;
        let height: CGFloat = self.size.width + y;
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0);
        let context: CGContext = UIGraphicsGetCurrentContext()!;
        UIGraphicsPushContext(context);
        let origin: CGPoint = CGPoint(x: (width - self.size.width) / 2, y: (height - self.size.height) / 2);
        self.draw(at: origin)
        UIGraphicsPopContext();
        let imageWithPadding = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return imageWithPadding!
    }
    
//    func cropImage(imageToCrop:UIImage, toRect rect:CGRect) -> UIImage{
//        
//        let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: rect)!
//        let cropped:UIImage = UIImage(cgImage:imageRef)
//        return cropped
//    }
}



extension UILabel {
    //no override
    public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
}

extension UITextView {
    //no override
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
}

extension UITextField {
    //no override
    public var substituteFontName : String {
        get {
            return self.font?.fontName ?? "";
        }
        set {
            let fontNameToTest = self.font?.fontName.lowercased() ?? "";
            var fontName = newValue;
            if fontNameToTest.range(of: "bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "ultralight") != nil {
                fontName += "-UltraLight";
            }
            self.font = UIFont(name: fontName, size: self.font?.pointSize ?? 17)
        }
    }
}
