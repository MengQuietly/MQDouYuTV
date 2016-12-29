//
//  MQRecommendBannerView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/28.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面：banner View

import UIKit

private let kMQRecommendBannerCellID = "kMQRecommendBannerCellID"

class MQRecommendBannerView: UIView {

    // MARK: - 控件属性
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerPageView: UIPageControl!
    
    var timer : Timer?
    
    // MARK:-定义模型数组属性
    var bannerModelList:[MQBannerModel]?{
        didSet {
            bannerCollectionView.reloadData()
            bannerPageView.numberOfPages = bannerModelList?.count ?? 0
            // 滚动到指定位置
            let indexPath = IndexPath(item: (bannerModelList?.count ?? 0)*10, section: 0)
            bannerCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件拉伸而拉伸（bannerView.y = -height无法展示问题）
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
    
        bannerCollectionView.register(UINib(nibName: "MQRecommendBannerCell", bundle: nil), forCellWithReuseIdentifier: kMQRecommendBannerCellID)
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
        // 设置无线滚动
        return (self.bannerModelList?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMQRecommendBannerCellID, for: indexPath) as! MQRecommendBannerCell
        
        cell.bannerModel = self.bannerModelList?[indexPath.item % bannerModelList!.count]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MQRecommendBannerView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + bannerCollectionView.bounds.size.width * 0.5
        let index = Int(offsetX / self.bannerCollectionView.bounds.size.width)
        self.bannerPageView.currentPage = index % (bannerModelList?.count ?? 0)
    }
}
