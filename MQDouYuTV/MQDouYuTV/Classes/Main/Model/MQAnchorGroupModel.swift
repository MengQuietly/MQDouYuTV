//
//  MQAnchorGroupModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/26.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  主播组信息

import UIKit

class MQAnchorGroupModel: MQBaseGameModel {
    /// 该组中对应的房间列表
    var room_list : [[String: NSObject]]?{
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list{
                anchorList.append(MQAnchorModel(dict: dict))
            }
        }
    }
    
    /// 该组显示的icon
    var icon_name : String = "home_header_normal"
    
    /// 定义主播模型对象数组
    lazy var anchorList:[MQAnchorModel] = [MQAnchorModel]()
    
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
