//
//  UIColor+Extension.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/23.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(displayP3Red: CGFloat, green: CGFloat, blue: CGFloat) {
        
       self.init(displayP3Red: displayP3Red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
}
