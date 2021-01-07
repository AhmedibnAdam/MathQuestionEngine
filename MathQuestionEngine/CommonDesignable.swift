//
//  CommonDesignable.swift
//  MathQuestionEngine
//
//  Created by Adam on 07/01/2021.
//


import Foundation
import UIKit

@IBDesignable extension UIView {
    
    @IBInspectable var viewRadius: CGFloat {
        get {
            return CGFloat(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var viewBorderWidth: Double {
           get {
               return Double(self.layer.borderWidth)
           }
           set {
               self.layer.borderWidth = CGFloat(newValue)
           }
       }
    @IBInspectable var viewBorderColor: UIColor? {
           get {
               return UIColor(cgColor: self.layer.borderColor!)
           }
           set {
               self.layer.borderColor = newValue?.cgColor
           }
       }
}
@IBDesignable extension UIButton {
    @IBInspectable var buttonRadius: Double {
            get {
                return Double(self.layer.cornerRadius)
            }
            set {
                self.layer.cornerRadius = CGFloat(newValue)
            }
        }
    @IBInspectable var buttonBorderWidth: Double {
           get {
               return Double(self.layer.borderWidth)
           }
           set {
               self.layer.borderWidth = CGFloat(newValue)
           }
       }
       @IBInspectable var buttonBorderColor: UIColor? {
           get {
               return UIColor(cgColor: self.layer.borderColor!)
           }
           set {
               self.layer.borderColor = newValue?.cgColor
           }
       }
}
@IBDesignable extension UIImageView {
@IBInspectable var imageViewRaduis: CGFloat {
           get {
               return CGFloat(self.layer.cornerRadius)
           }
           set {
               self.layer.cornerRadius = newValue
           }
       }
}
extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

