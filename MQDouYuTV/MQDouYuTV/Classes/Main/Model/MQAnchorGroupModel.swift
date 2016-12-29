//
//  MQAnchorGroupModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/26.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  主播组信息

import UIKit

class MQAnchorGroupModel: NSObject {
    /// 该组中对应的房间列表
    var room_list : [[String: NSObject]]?{
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchorList.append(MQAnchorModel(dict: dict))
            }
        }
    }
    /// 该组显示标题
    var tag_name : String = ""
    /// 该组显示的icon
    var icon_name : String = "home_header_normal"
    
    // 该对象象征图标
    var icon_url : String = "home_header_normal"
    /// 定义主播模型对象数组
    lazy var anchorList:[MQAnchorModel] = [MQAnchorModel]()
    
    // MARK：构造函数－ 快速创建模型
    override init() {}
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

    /* 使用 KVC 转换，或者直接食用 list 的didSet 替代
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[String:NSObject]] {
                for dict in dataArr{
                    anchorList.append(MQAnchorModel(dict: dict))
                }
            }
        }
    } */
}
