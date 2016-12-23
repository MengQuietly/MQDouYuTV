//
//  MQCommon.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

// 屏幕 size、width、height
let kScreenS = UIScreen.main.bounds
let kScreenW: CGFloat = kScreenS.width
let kScreenH: CGFloat = kScreenS.height

// statusBar-height、NaviagtionBar-height
let kStatusBarH: CGFloat = 20
let kNaviagtionBarH: CGFloat = 44
let kTabBarH: CGFloat = 49

// 随即色
let kRandomColor: UIColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))

// 打印数据
func MQLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        let url = NSURL(fileURLWithPath: filename)
        let className:String! = url.lastPathComponent == nil ? filename: url.lastPathComponent!
        // \(filename)
        print("****[WARNING]****\(Date()) \(className!)(\(line)) 方法：\(funcname)，打印数据＝\(object!)\n")
    #endif
}

