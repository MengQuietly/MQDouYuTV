//
//  MQRecommendHeadView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/20.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendHeadView: 推荐界面 headerViewCell

import UIKit

class MQRecommendHeadView: UICollectionReusableView {
    
    // MARK:-控件属性
    @IBOutlet weak var groupHeadIcon: UIImageView!
    @IBOutlet weak var groupHeadTitle: UILabel!
    @IBOutlet weak var groupHeadMore: UIButton!
    // MARK:-定义模型属性
    var anchorGroupModel:MQAnchorGroupModel?{
        didSet {
            groupHeadIcon.image = UIImage(named: anchorGroupModel?.icon_url ?? "home_header_normal")
            groupHeadTitle.text = anchorGroupModel?.tag_name
        }
    }
}
