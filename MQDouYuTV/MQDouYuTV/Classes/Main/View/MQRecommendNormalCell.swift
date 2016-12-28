//
//  MQRecommendNormalCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/20.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendNormalCell: 推荐界面 NormalCell

import UIKit

class MQRecommendNormalCell: MQRecommendBaseCell {

    // MARK:-控件属性
    @IBOutlet weak var anchorPlayType: UIButton!
    @IBOutlet weak var anchorRoomName: UILabel!
    // MARK:-定义模型属性
    override var anchorModel:MQAnchorModel?{
        didSet {
            super.anchorModel = anchorModel
            anchorPlayType.isHidden = anchorModel?.isVertical == 0 ? true : false
            anchorRoomName.text = anchorModel?.room_name
        }
    }
}
