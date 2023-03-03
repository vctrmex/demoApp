//
//  CustomButton.swift
//  demoApp
//
//  Created by VCTR on 02/03/23.
//

import UIKit

class CustomButton: UIButton {
    
    @IBInspectable public var buttonStyle: Int = 0 {
        didSet {
            style = CustomButtonStyle(rawValue: buttonStyle) ?? .none
        }
    }
    
    public var style: CustomButtonStyle = CustomButtonStyle.none {
        didSet {
            loadStyle()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadStyle()
    }
    
    func loadStyle() {
        self.layer.cornerRadius = 10
        self.setTitleColor(.white, for: .normal)
        switch style {
        case .none:
            break
        case .primary:
            self.backgroundColor = .blue
        case .secundary:
            self.backgroundColor = .red
        case .optional:
            self.backgroundColor = .green
        case .other:
            self.backgroundColor = .yellow
        case .star:
            self.setImage(UIImage(systemName: "star.fill"), for: .normal)
        case .starFill:
            self.setImage(UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
}
