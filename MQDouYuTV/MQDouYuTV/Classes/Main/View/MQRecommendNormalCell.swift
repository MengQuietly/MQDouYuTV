//
//  MQRecommendNormalCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/20.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendNormalCell: 推荐界面 NormalCell

import UIKit
import Kingfisher

class MQRecommendNormalCell: UICollectionViewCell {

    // MARK:-控件属性
    @IBOutlet weak var anchorRoomImg: UIImageView!
    @IBOutlet weak var anchorNickName: UILabel!
    @IBOutlet weak var anchorRoomName: UILabel!
    @IBOutlet weak var anchorRoomOnLineNum: UIButton!
    // MARK:-定义模型属性
    var anchorModel:MQAnchorModel?{
        didSet {
            guard let anchorModel = anchorModel else { return }
            
            guard let roomImgUrl:URL = URL(string: anchorModel.vertical_src) else { return }            
            anchorRoomImg.kf.setImage(with: roomImgUrl)

            anchorNickName.text = anchorModel.nickname
            anchorRoomName.text = anchorModel.room_name
            
            var online = ""
            if anchorModel.online >= 10000{
                online = "\(Int(anchorModel.online)/10000)万在线"
            } else {
                online = "\(anchorModel.online)在线"
            }
            
            anchorRoomOnLineNum.setTitle(online, for: UIControlState.normal)
        }
    }
}
