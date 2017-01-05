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
private let kLiveCommonCellID = "kLiveCommonCellID"

class MQLiveCommonController: UIViewController {

    // MARK： lazy
    
    fileprivate lazy var commonViewModel = MQLiveCommonViewModel()
    
    fileprivate lazy var collectionViews:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        var collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.dataSource = self
        collectionViews.backgroundColor = UIColor.white
        collectionViews.register(UINib(nibName: "MQRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kLiveCommonCellID)
        // 相对于父控件宽高不变
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        return collectionViews
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI界面
extension MQLiveCommonController {
    fileprivate func setupUI() {
        view.addSubview(collectionViews)
        getCommonListData()
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
}

//MARK:- 常用直播：网络请求
extension MQLiveCommonController{
    // MARK: 获取常用直播列表
    fileprivate func getCommonListData() {
        commonViewModel.getCommonWithLiveList { [unowned self] in
            self.collectionViews.reloadData()
        }
    }
}

