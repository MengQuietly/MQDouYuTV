//
//  MQAmuseViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/6.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAmuseViewModel：娱乐界面 ViewModel

import UIKit

class MQAmuseViewModel: MQBaseAnchorViewModel {

}

// MARK:- 数据请求
extension MQAmuseViewModel {
    
    func getAmuseListData(identifications:String,finishCallBack:@escaping ()->()){
        let amuseUrl = HOST_URL.appending(AMUSE_GET_AMUSE_LIST)
        let amuseDict = ["identification":identifications]
        
        getAnchorData(urlString: amuseUrl, parameters:amuseDict, finishCallBack: finishCallBack)
    }
}
