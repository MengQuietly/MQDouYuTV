//
//  MQPageContentView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/23.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

private let kPageContentCollectionCellID = "PageContentCollectionCellID"

// MARK:- MQPageContentView
class MQPageContentView: UIView {
    
    // MARK:- 定义属性
    var childVCList:[UIViewController] = [UIViewController]()
    var parentVC: UIViewController = UIViewController()

    // MARK:- 懒加载数据
    lazy var contentCollectionViews: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = self.bounds.size
        
        let contentCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.bounces = false
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageContentCollectionCellID)
        return contentCollectionView
    }()
    
    init(frame: CGRect,childVCList: [UIViewController], parentVC: UIViewController) {
        self.childVCList = childVCList
        self.parentVC = parentVC
        super.init(frame: frame)
        
        // 设置 UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置布局
extension MQPageContentView {
    
    func setupUI() {
        for child in childVCList {
            parentVC.addChildViewController(child)
        }
        contentCollectionViews.frame = bounds
        addSubview(contentCollectionViews)
        
    }
}

// MARK: - UICollectionViewDataSource
extension MQPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageContentCollectionCellID, for: indexPath)
        for cellSubViews in cell.contentView.subviews {
            cellSubViews.removeFromSuperview()
        }
        
        let childvc = childVCList[indexPath.item]
        cell.contentView.addSubview(childvc.view)
        
        return cell
    }
}
