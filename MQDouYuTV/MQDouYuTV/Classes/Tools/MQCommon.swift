//
//  MQCommon.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  常用属性、方法定义

import UIKit

// 屏幕 size、width、height
let kScreenS = UIScreen.main.bounds
let kScreenW: CGFloat = kScreenS.width
let kScreenH: CGFloat = kScreenS.height

// statusBar-height、NaviagtionBar-height
let kStatusBarH: CGFloat = 20
let kNaviagtionBarH: CGFloat = 44
let kTabBarH: CGFloat = 49

let kFirstStartApp: Bool = UserDefaults.standard.bool(forKey: "firstLaunch")

let kAmuseIdentification: String = UserDefaults.standard.object(forKey: "娱乐") as! String
let kMobileGameIdentification: String = UserDefaults.standard.object(forKey: "手游") as! String
let kGameIdentification: String = UserDefaults.standard.object(forKey: "游戏") as! String
let kFunnyIdentification: String = UserDefaults.standard.object(forKey: "趣玩") as! String

// 随即色
let kRandomColor: UIColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))

// 打印数据
func MQLog<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        let url = URL(fileURLWithPath: filename)
        let className:String! = url.lastPathComponent == nil ? filename: url.lastPathComponent
        // \(filename)
        print("****[WARNING]****\(Date()) \(className!)(\(line)) 方法：\(funcname)，打印数据＝\(object!)\n")
    #endif
}

