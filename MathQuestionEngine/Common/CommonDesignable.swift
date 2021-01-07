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

