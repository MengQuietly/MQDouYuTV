//
//  MQRecommendController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/19.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendController 推荐界面

import UIKit

private let kItemMarginW : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMarginW * 3) * 0.5
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"

class MQRecommendController: UIViewController {

    // MARK: 懒加载 collectionView
    lazy var collectionViews: UICollectionView = { [unowned self] in

        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMarginW
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMarginW, bottom: 0, right: kItemMarginW)
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.backgroundColor = UIColor.green
        collectionViews.dataSource = self
        // 相对于父控件宽高不变
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        // 注册cell
        collectionViews.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionViews.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        return collectionViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

// MARK: - 设置UI界面
extension MQRecommendController{
    func setupUI(){
        view.addSubview(collectionViews)
    }
}

// MARK: - 实现代理方法
extension MQRecommendController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = kRandomColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerViews = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        headerViews.backgroundColor = UIColor.brown
        return headerViews
    }
}
