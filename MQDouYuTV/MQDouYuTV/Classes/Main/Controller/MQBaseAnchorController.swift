//
//  MQBaseAnchorController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/16.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQBaseAnchorController:推荐／娱乐 Controller 基类

import UIKit

/// itemMarginW
private let kBaseAnchorItemMarginW : CGFloat = 10
/// itemW,H
let kBaseAnchorItemW : CGFloat = (kScreenW - kBaseAnchorItemMarginW * 3) * 0.5
let kBaseAnchorItemH : CGFloat = kBaseAnchorItemW * 3 / 4
/// headerViewH
private let kBaseAnchorHeaderViewH : CGFloat = 50

/// 默认 Cell ID
private let kBaseAnchorNormalCellID = "kBaseAnchorNormalCellID"
/// 颜值 Cell ID
let kBaseAnchorPrettyScoreCellID = "kBaseAnchorPrettyScoreCellID"
/// HeaderView ID
private let kBaseAnchorHeaderViewCellID = "kBaseAnchorHeaderViewCellID"

class MQBaseAnchorController: UIViewController {

    // MARK: viewModel
    var baseAnchorViewModel: MQBaseAnchorViewModel!
    
    // MARK: 懒加载 collectionView
    lazy var collectionViews: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kBaseAnchorItemW, height: kBaseAnchorItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kBaseAnchorItemMarginW
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kBaseAnchorItemMarginW, bottom: 0, right: kBaseAnchorItemMarginW)
        
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kBaseAnchorHeaderViewH)
        
        
        let collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.backgroundColor = UIColor.white
        
        collectionViews.dataSource = self
//        collectionViews.delegate = self
       
        // 相对于父控件宽高不变
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        
        // 注册cell
//        collectionViews.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
//        collectionViews.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionViews.register(UINib(nibName: "MQRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: kBaseAnchorNormalCellID)
        collectionViews.register(UINib(nibName: "MQPrettyScoreCell", bundle: nil), forCellWithReuseIdentifier: kBaseAnchorPrettyScoreCellID)
        
        collectionViews.register(UINib(nibName: "MQRecommendHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kBaseAnchorHeaderViewCellID)
        return collectionViews
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getBaseAnchorListData()
    }

}

// MARK:- 设置界面
extension MQBaseAnchorController {
    func setupUI() {
        view.addSubview(collectionViews)
    }
}

// MARK:- UICollectionViewDataSource
extension MQBaseAnchorController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseAnchorViewModel == nil { return 1 }
        return baseAnchorViewModel.anchorGroupList.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if baseAnchorViewModel == nil { return 20 }
        
        let groupSection = baseAnchorViewModel.anchorGroupList[section]
        return groupSection.anchorList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBaseAnchorNormalCellID, for: indexPath) as! MQRecommendNormalCell
        if baseAnchorViewModel == nil { return cell }
        
        let sectionNum = baseAnchorViewModel.anchorGroupList[indexPath.section]
        let anchor = sectionNum.anchorList[indexPath.item]
        cell.anchorModel = anchor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerViews = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kBaseAnchorHeaderViewCellID, for: indexPath) as! MQRecommendHeadView
        if baseAnchorViewModel == nil { return headerViews }
        headerViews.anchorGroupModel = baseAnchorViewModel.anchorGroupList[indexPath.section]
        
        return headerViews
    }
}

// MARK:- 网络请求
extension MQBaseAnchorController {
    
    func getBaseAnchorListData(){
        
    }
}
