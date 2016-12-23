//
//  NSDate+Extension.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import Foundation

extension NSDate{
    //MARK:- 获取当前时间豪秒数
    class func getCurrentDateNumber() -> String{
        let currentDateNumber = Int(NSDate().timeIntervalSince1970)
        return "\(currentDateNumber)"
    }
}
