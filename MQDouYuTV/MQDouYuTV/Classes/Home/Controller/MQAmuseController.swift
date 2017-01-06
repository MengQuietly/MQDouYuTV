//
//  MQAmuseController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAmuseController：娱乐界面

import UIKit

private let kItemMarginW : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMarginW * 3) * 0.5
private let kItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50

private let kAmuseCellID = "kAmuseCellID"
private let kAmuseHeaderViewCellID = "kAmuseHeaderViewCellID"

class MQAmuseController: UIViewController {
    
    // MARK:- lazy
    
    fileprivate lazy var collectionViews: UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMarginW, bottom: 0, right: kItemMarginW)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        collectionViews.dataSource = self
        collectionViews.backgroundColor = UIColor.white
        collectionViews.register(UINib(nibName: "MQRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: kAmuseCellID)
        
        collectionViews.register(UINib(nibName: "MQRecommendHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kAmuseHeaderViewCellID)
        return collectionViews
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK:- 设置界面
extension MQAmuseController {
    fileprivate func setupUI() {
        view.addSubview(collectionViews)
    }
}

// MARK:- UICollectionViewDataSource
extension MQAmuseController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kAmuseHeaderViewCellID, for: indexPath)
        return header
    }
}


