//
//  UIView.swift
//  TamatemPlus
//
//  Created by zaid farouqi on 13/06/2023.
//

import Foundation
import UIKit
 

extension UIView {
    
    var viewWidth: CGFloat { return frame.width }
    var viewHeight: CGFloat { return frame.height }
    
    func roundCorner(withRadis: CGFloat) {
        self.layer.cornerRadius = withRadis
        self.layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setBorderColor(_ color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    @IBInspectable
    var cornersRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func roundBottomCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    func roundTopCorners(radius: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    
    func removeFromSuperViewAsWellAsAnySubViews() {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        self.removeFromSuperview()
    }
    
    
    func animateBorderWidth(toValue: CGFloat, duration: Double) {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
    }

    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }

        func isHidden(_ value : Bool){
            UIView.performWithoutAnimation {
                if value {
                    if !self.isHidden{
                        self.isHidden = true
                    }
                }
                else {
                    if self.isHidden {
                        self.isHidden = false
                    }
                }
            }
        }
    
}
