//
//  MQLiveCommonController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQLiveCommonController: 常用直播列表界面

import UIKit

private let kItemW : CGFloat = kScreenW / 3
private let kItemH : CGFloat = kItemW * 5 / 6
private let kHeaderViewH : CGFloat = 50
private let kTopHeaderGameViewH : CGFloat = 90
private let kTopHeaderViewTotalY : CGFloat = kHeaderViewH + kTopHeaderGameViewH
private let kLiveCommonCellID = "kLiveCommonCellID"
private let kLiveCommonHeaderViewID = "kLiveCommonHeaderViewID"

class MQLiveCommonController: MQBaseController {

    // MARK： lazy
    
    /// viewModel
    fileprivate lazy var commonViewModel = MQLiveCommonViewModel()
    /// topHeadView
    fileprivate lazy var topHeadViews: MQRecommendHeadView = {
        let topHeadViews = MQRecommendHeadView.recommendHeadView()
        topHeadViews.frame = CGRect(x: 0, y: -kTopHeaderViewTotalY, width: kScreenW, height: kHeaderViewH)
        topHeadViews.groupHeadTitle.text = "常见"
        topHeadViews.groupHeadIcon.image = UIImage(named: "Img_orange")
        topHeadViews.groupHeadMore.isHidden = true
        return topHeadViews
    }()
    /// topHeadGame
    fileprivate lazy var topHeadGames: MQRecommendGameView = {
        let topHeadGames = MQRecommendGameView.recommendGemeView()
        topHeadGames.frame = CGRect(x: 0, y: -kTopHeaderGameViewH, width: kScreenW, height: kTopHeaderGameViewH)
        
        return topHeadGames
    }()
    
    /// collectionView
    fileprivate lazy var collectionViews: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        var collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.dataSource = self
        collectionViews.backgroundColor = UIColor.white
        collectionViews.register(UINib(nibName: "MQRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kLiveCommonCellID)
        collectionViews.register(UINib(nibName: "MQRecommendHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kLiveCommonHeaderViewID)
        // 相对于父控件宽高不变
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        return collectionViews
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getCommonListData()
    }
}

// MARK: - 设置UI界面
extension MQLiveCommonController {
    override func setupUI() {
        contentView = collectionViews
        view.addSubview(collectionViews)
        collectionViews.addSubview(topHeadViews)
        collectionViews.addSubview(topHeadGames)
        collectionViews.contentInset = UIEdgeInsets(top: kTopHeaderViewTotalY, left: 0, bottom: 0, right: 0)
        
        super.setupUI()
    }
}

// MARK:- UICollectionViewDataSource
extension MQLiveCommonController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commonViewModel.commonLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kLiveCommonCellID, for: indexPath) as! MQRecommendGameCell
        cell.baseGameModel = commonViewModel.commonLists[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headViews = collectionViews.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kLiveCommonHeaderViewID, for: indexPath) as! MQRecommendHeadView
        headViews.groupHeadTitle.text = "全部"
        headViews.groupHeadIcon.image = UIImage(named: "Img_orange")
        headViews.groupHeadMore.isHidden = true
        return headViews
    }
}

//MARK:- 常用直播：网络请求
extension MQLiveCommonController{
    // MARK: 获取常用直播列表
    fileprivate func getCommonListData() {
        commonViewModel.getCommonWithLiveList { [unowned self] in
            self.collectionViews.reloadData()
            // 获取前10条数据
            self.topHeadGames.gameList = Array(self.commonViewModel.commonLists[0..<10])
            
            // 数据请求完成，关闭动画
            self.loadDataFinished()
        }
    }
}

