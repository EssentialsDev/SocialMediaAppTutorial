//
//  RoundedView.swift
//  socialapp
//
//  Created by Kasey Schlaudt on 3/7/17.
//  Copyright © 2017 Kasey Schlaudt. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 20
        
        self.clipsToBounds = true
        
        layer.borderColor = UIColor.lightGray.cgColor
        
        layer.borderWidth = 0.5
    }

}
