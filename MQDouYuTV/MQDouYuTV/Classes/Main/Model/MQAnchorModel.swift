//
//  MQAnchorModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/26.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  主播信息

import UIKit

class MQAnchorModel: NSObject {
    var avatar_mid: String = "live_cell_default_phone"
    var avatar_small: String = "live_cell_default_phone"
    var cate_id:Int = 0
    var child_id:Int = 0
    var game_name:String = ""
    // 是否为电脑直播：0-电脑直播，1-手机直播
    var isVertical:Int = 0
    // 主播昵称
    var nickname:String = ""
    // 在线观看人数
    var online:Int = 0
    // 房间ID
    var room_id:Int = 0
    // 房间名称
    var room_name:String = ""
    var room_src:String = ""
    var specific_status:Int = 0
    var show_time:Int = 0
    // 房间图片Url
    var vertical_src:String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
