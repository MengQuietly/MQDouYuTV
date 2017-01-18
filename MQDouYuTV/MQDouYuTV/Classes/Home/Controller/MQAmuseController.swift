//
//  MQAmuseController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAmuseController：娱乐界面

import UIKit

private let kAmuseTopMenuViewH: CGFloat = 200

class MQAmuseController: MQBaseAnchorController {
    
    var identifications:String = String()
    // MARK: Lazy
    fileprivate lazy var amuseViewModel = MQAmuseViewModel()
    
    fileprivate lazy var amuseTopMenuView: MQAmuseTopMenuView = {
        let amuseTopMenuView = MQAmuseTopMenuView.amuseTopMenuView()
        amuseTopMenuView.frame = CGRect(x: 0, y: -kAmuseTopMenuViewH, width: kScreenW, height: kAmuseTopMenuViewH)
        amuseTopMenuView.backgroundColor = UIColor.red
        return amuseTopMenuView
    }()
}

// MAKR:- 设置UI界面
extension MQAmuseController {
    override func setupUI() {
        super.setupUI()
        collectionViews.addSubview(amuseTopMenuView)
        collectionViews.contentInset = UIEdgeInsets(top: kAmuseTopMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- 网络请求
extension MQAmuseController {
    
    override func getBaseAnchorListData() {
        
        // 给父类viewModel 赋值
        baseAnchorViewModel = amuseViewModel
        
        amuseViewModel.getAmuseListData(identifications: identifications) { [unowned self] in
            self.collectionViews.reloadData()
        }
    }
}


