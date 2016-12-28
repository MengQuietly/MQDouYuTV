//
//  MQRecommendBannerCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/28.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面：banner View Cell

import UIKit
import Kingfisher

class MQRecommendBannerCell: UICollectionViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var bannerImg: UIImageView!
    
    // MARK:-定义模型属性
    var bannerModel:MQBannerModel?{
        didSet {
            guard let bannerModel = bannerModel else { return }
            guard let bannerImgUrl = URL(string: bannerModel.pic_url) else {return}
            bannerImg.kf.setImage(with: bannerImgUrl)
        }
    }
}
