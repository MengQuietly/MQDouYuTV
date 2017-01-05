//
//  MQBaseGameModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAnchorGroupModel & MQLiveCommonModel 抽取父类

import UIKit

class MQBaseGameModel: NSObject {

    // 该对象象征图标
    var icon_url : String = ""
    /// 该组显示标题
    var tag_name : String = ""
    
    // MARK：构造函数－ 快速创建模型
    override init() {}
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
