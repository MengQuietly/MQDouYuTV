//
//  MQPrettyScoreCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQPrettyScoreCell: 推荐界面 颜值Cell

import UIKit
import Kingfisher

class MQPrettyScoreCell: UICollectionViewCell {

    // MARK:-控件属性
    @IBOutlet weak var anchorRoomImg: UIImageView!
    
    @IBOutlet weak var anchorRoomOnLine: UILabel!
    
    @IBOutlet weak var anchorNickName: UILabel!
    
    @IBOutlet weak var anchorRoomCity: UIButton!
    // MARK:-定义模型属性
    var anchorModel:MQAnchorModel?{
        didSet {
            guard let anchorModel = anchorModel else { return }
            
            guard let roomImgUrl:URL = URL(string: anchorModel.vertical_src) else { return }
            
            anchorRoomImg.kf.setImage(with: roomImgUrl)
            
            var online = ""
            if anchorModel.online >= 10000{
                online = "\(Int(anchorModel.online)/10000)万在线"
            } else {
                online = "\(anchorModel.online)在线"
            }
            anchorRoomOnLine.text = online
            anchorNickName.text = anchorModel.nickname
            anchorRoomCity.setTitle(anchorModel.anchor_city, for: UIControlState.normal)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
