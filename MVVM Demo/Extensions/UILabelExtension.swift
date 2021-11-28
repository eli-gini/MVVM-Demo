//
//  UIButtonExtension.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

extension UILabel {
    
    func pulsate() {
    let pulse = CASpringAnimation(keyPath: "transform.scale")
    pulse.duration = 0.4
    pulse.fromValue = 0.97
    pulse.toValue = 1.0
    pulse.autoreverses = true
//    pulse.repeatCount = .infinity
    pulse.initialVelocity = 0.5
    pulse.damping = 1.0
    layer.add(pulse, forKey: nil)
    }
    
    func flash() {
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.3
    flash.fromValue = 1
    flash.toValue = 0.1
    flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 3
    layer.add(flash, forKey: nil)
    }
}
