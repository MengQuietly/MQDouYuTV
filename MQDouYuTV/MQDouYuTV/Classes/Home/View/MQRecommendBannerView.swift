//
//  MQRecommendBannerView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/28.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面：banner View

import UIKit

private let kRecommendBannerViewID = "kPrettyScoreCellID"

class MQRecommendBannerView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageView: UIPageControl!
    
    // MARK:-定义模型数组属性
    var bannerModelList:[MQBannerModel]?{
        didSet {
            bannerCollectionView.reloadData()
            bannerPageView.numberOfPages = bannerModelList?.count ?? 0
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件拉伸而拉伸（bannerView.y = -height无法展示问题）
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        bannerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kRecommendBannerViewID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = bannerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = bannerCollectionView.bounds.size
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.showsHorizontalScrollIndicator = false
    }
}

extension MQRecommendBannerView {
    // MARK: - 快速创建View
    class func recommendBannerView() -> MQRecommendBannerView {
        return Bundle.main.loadNibNamed("MQRecommendBannerView", owner: nil, options: nil)!.first as! MQRecommendBannerView
    }
}

// MARK：－ UICollectionViewDataSource
extension MQRecommendBannerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bannerModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendBannerViewID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
}
