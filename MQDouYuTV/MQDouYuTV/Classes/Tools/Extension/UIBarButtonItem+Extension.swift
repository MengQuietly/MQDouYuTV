//
//  UIBarButtonItem+Extension.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit


/** UIBarButtonItem + Extension */
extension UIBarButtonItem {
    
    /* 类方法：创建自定义View
    class func creatItem(imageName: String, hightImageName: String = "", size: CGSize = CGSize.zero) -> UIBarButtonItem {

        let navBtnItem = UIButton(type: .custom)
        navBtnItem.setImage(UIImage(named: imageName), for: .normal)
        
        if hightImageName != "" {
            navBtnItem.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            navBtnItem.sizeToFit()
        } else {
            navBtnItem.frame = CGRect(origin: .zero, size: size)
        }
        return UIBarButtonItem(customView: navBtnItem)
    }*/
    
    convenience init(imageName: String, hightImageName: String = "", size: CGSize = CGSize.zero) {
        let navBtnItem = UIButton(type: .custom)
        navBtnItem.setImage(UIImage(named: imageName), for: .normal)
        
        if hightImageName != "" {
            navBtnItem.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        
        if size == CGSize.zero {
            navBtnItem.sizeToFit()
        } else {
            navBtnItem.frame = CGRect(origin: .zero, size: size)
        }
        self.init(customView: navBtnItem)
    }
}
