//
//  MQRecommendGameCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/29.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐首页：gameView cell

import UIKit
import Kingfisher

class MQRecommendGameCell: UICollectionViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var groupIcon: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    
    // MARK: 定义模型属性
    var gameModel: MQAnchorGroupModel? {
        didSet {
            guard let gameModel = gameModel else { return }
            guard let bannerImgUrl = URL(string: gameModel.icon_url) else {return}
            groupIcon.kf.setImage(with: bannerImgUrl, placeholder: Image(named:"home_more_btn"))
            groupName.text = gameModel.tag_name
        }
    }
}
