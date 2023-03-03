//
//  DesignableSegmentControl.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

@IBDesignable
class DesignableSegmentControl: UISegmentedControl{
    @IBInspectable
    var textColor: UIColor{
        get {
            return self.textColor
        }
        set {
            let unselectedAttributes = [NSAttributedString.Key.foregroundColor: newValue,
                                        NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)]
            self.setTitleTextAttributes(unselectedAttributes, for: .normal)
            self.setTitleTextAttributes(unselectedAttributes, for: .selected)
        }
    }
}
