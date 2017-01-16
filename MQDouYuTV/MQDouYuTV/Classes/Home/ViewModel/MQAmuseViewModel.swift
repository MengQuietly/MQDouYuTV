//
//  MQAmuseViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/6.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQAmuseViewModel：娱乐界面 ViewModel

import UIKit

class MQAmuseViewModel {

    // MQAnchorGroupModel 数组(所有数据组)
    lazy var anchorGroupList: [MQAnchorGroupModel] = [MQAnchorGroupModel]()
}

// MARK:- 数据请求
extension MQAmuseViewModel {
    
    func getAmuseListData(identifications:String,finishCallBack:@escaping ()->()){
        let amuseUrl = HOST_URL.appending(AMUSE_GET_AMUSE_LIST)
        let amuseDict = ["identification":identifications]
        MQNetworkingTool.sendRequest(url: amuseUrl, parameters:amuseDict, succeed: {  [unowned self] (responseObject, isBadNet) in
            
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else  {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray {
                self.anchorGroupList.append(MQAnchorGroupModel(dict: dict))
            }
            finishCallBack()
            
        }) { (error, isBadNet) in
            MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        
        
    }
}
