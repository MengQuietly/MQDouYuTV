//
//  UIColor+Extension.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/23.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

extension UIColor {
    // MARK:-RGB值
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        } else {
            self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
        }
    }
    
    // MARK:-随机色
    class func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)))
    }
}
