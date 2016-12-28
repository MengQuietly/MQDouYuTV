//
//  MQPrettyScoreCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQPrettyScoreCell: 推荐界面 颜值Cell

import UIKit

class MQPrettyScoreCell: MQRecommendBaseCell {
    
    // MARK:-控件属性
    @IBOutlet weak var anchorRoomCity: UIButton!
    
    // MARK:-定义模型属性
    override var anchorModel:MQAnchorModel?{
        didSet {
            super.anchorModel = anchorModel
            anchorRoomCity.setTitle(anchorModel?.anchor_city, for: UIControlState.normal)
        }
    }
}
