//
//  MQBannerModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/28.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐首页：banner Model

import UIKit

class MQBannerModel: NSObject {
    /// banner 标题
    var title:String = ""
    /// banner 展示图片
    var pic_url:String = ""
    /// banner 展示图
    var tv_pic_url:String = ""
    /// 主播信息对应字典
    var room:[String:Any]?{
        didSet {
            guard let room = room else { return }
            anchorModel = MQAnchorModel(dict: room)
        }
    }
    
    /// 主播信息对应模型对象
    var anchorModel:MQAnchorModel?
    
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
