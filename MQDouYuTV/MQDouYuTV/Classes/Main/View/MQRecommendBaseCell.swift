//
//  MQRecommendBaseCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/28.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面：抽取normalCell & prettyCell 基础类

import UIKit
import Kingfisher

class MQRecommendBaseCell: UICollectionViewCell {
    // MARK:-控件属性
    @IBOutlet weak var anchorRoomImg: UIImageView!
    @IBOutlet weak var anchorRoomOnLine: UIButton!
    @IBOutlet weak var anchorNickName: UIButton!
    
    // MARK:-定义模型属性
    var anchorModel:MQAnchorModel?{
        didSet {
            guard let anchorModel = anchorModel else { return }
            guard let roomImgUrl:URL = URL(string: anchorModel.vertical_src) else { return }
            anchorRoomImg.kf.setImage(with: roomImgUrl)
            anchorNickName.setTitle(anchorModel.nickname, for: UIControlState.normal)
            var online = ""
            if anchorModel.online >= 10000{
                online = "\(Int(anchorModel.online)/10000)万"
            } else {
                online = "\(anchorModel.online)"
            }
            anchorRoomOnLine.setTitle(online, for: UIControlState.normal)
        }
    }
}
