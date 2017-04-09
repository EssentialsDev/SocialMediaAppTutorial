//
//  CircleImage.swift
//  socialapp
//
//  Created by Kasey Schlaudt on 3/7/17.
//  Copyright © 2017 Kasey Schlaudt. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.width / 2
        
        self.clipsToBounds = true
    }
}
