//
//  ShakingTextField.swift
//  Linker
//
//  Created by Luke Cheskin on 09/12/2016.
//  Copyright © 2016 IdleApps. All rights reserved.
//

import UIKit

class ShakingTextField: UITextField {

    func shakeTextField() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
        
    }

}
