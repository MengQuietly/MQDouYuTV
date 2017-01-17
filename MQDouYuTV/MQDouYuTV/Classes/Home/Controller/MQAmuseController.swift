//
//  MQAmuseController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAmuseController：娱乐界面

import UIKit

class MQAmuseController: MQBaseAnchorController {
    
    var identifications:String = String()
    // MARK: Lazy
    fileprivate lazy var amuseViewModel = MQAmuseViewModel()
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


