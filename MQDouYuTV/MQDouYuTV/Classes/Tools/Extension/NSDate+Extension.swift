//
//  NSDate+Extension.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import Foundation

extension Date{
    //MARK:- 获取当前时间豪秒数
    static func getCurrentDateNumber() -> String{
        let currentDateNumber = Int(Date().timeIntervalSince1970)
        return "\(currentDateNumber)"
    }
}
