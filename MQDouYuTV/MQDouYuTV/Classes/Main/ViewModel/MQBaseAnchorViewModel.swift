//
//  MQBaseAnchorViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/16.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQBaseAnchorViewModel：推荐／娱乐 viewModel 基类

import UIKit

class MQBaseAnchorViewModel {
    // MQAnchorGroupModel 数组(所有数据组)
    lazy var anchorGroupList: [MQAnchorGroupModel] = [MQAnchorGroupModel]()
}

extension MQBaseAnchorViewModel{
    func getAnchorData(urlString: String, parameters:[String:Any]?=nil,finishCallBack:@escaping ()->()) {
        MQNetworkingTool.sendRequest(url: urlString, parameters:parameters, succeed: {  [unowned self] (responseObject, isBadNet) in
            
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
