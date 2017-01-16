//
//  MQHomeSubTitleModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/6.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQHomeSubTitleModel: 首页 SubTitle Model

import UIKit

class MQHomeSubTitleModel: NSObject {
    
    var identification:String = ""
    var is_video = 0
    var show_order = 0
    var title = ""
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {}
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
