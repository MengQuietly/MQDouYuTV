//
//  MQHomeViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/6.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQHomeViewModel:首页 ViewModel

import UIKit

class MQHomeViewModel {
    
}

// MARK:- 数据请求
extension MQHomeViewModel {
    // MARK: 获取首页 子标题
    func getHomeSubTitle(finishCallBack:@escaping ()->()){
        let homeSubTitleUrl = HOST_URL.appending(HOME_GET_SUBTITLE_LIST)
        MQNetworkingTool.sendRequest(url: homeSubTitleUrl, succeed: { (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            guard let resultDict = responseObject as? [String:NSObject] else  {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            let userDefault = UserDefaults.standard
            for dict in dataArray {
                let subTitleModel = MQHomeSubTitleModel(dict: dict)
                userDefault.set(subTitleModel.identification, forKey: subTitleModel.title)
                userDefault.synchronize()
            }
            finishCallBack()

            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
    }
}
