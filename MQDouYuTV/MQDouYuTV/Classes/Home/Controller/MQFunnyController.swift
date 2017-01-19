//
//  MQFunnyController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/18.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQFunnyController: 首页-趣玩

import UIKit

private let kCollectionViewMarginTop: CGFloat = 10

class MQFunnyController: MQBaseAnchorController {
    var identifications:String = String()
    fileprivate lazy var funnyViewModel  = MQFunnyViewModel()
}

// MARK:- 设置界面
extension MQFunnyController {
    override func setupUI() {
        super.setupUI()
        // 隐藏HeadView
//        let layout = collectionViews.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.headerReferenceSize = CGSize.zero
//        collectionViews.contentInset = UIEdgeInsets(top: kCollectionViewMarginTop, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 加载数据
extension MQFunnyController {
    
    override func getBaseAnchorListData() {
        baseAnchorViewModel = funnyViewModel
        
        funnyViewModel.getFunnyListData(identifications: identifications) { [unowned self] in
            self.collectionViews.reloadData()
        }
    }
}

