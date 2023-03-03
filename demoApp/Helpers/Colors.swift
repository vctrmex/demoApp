//
//  Colors.swift
//  demoApp
//
//  Created by vctr on 01/03/23.
//

import UIKit

class Colors {
    var gl: CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 0.0 / 255.0, green: 238.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 222.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
