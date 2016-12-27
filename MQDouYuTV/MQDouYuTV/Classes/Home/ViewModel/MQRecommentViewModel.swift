//
//  MQRecommentViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面 ViewModel

import UIKit

class MQRecommentViewModel {
    // MARK：－ 懒加载
    // MQAnchorGroupModel 数组
    lazy var anchorGroupList: [MQAnchorGroupModel] = [MQAnchorGroupModel]()
}

// MARK:- 网络请求
extension MQRecommentViewModel{
    func getData() {
        
        // 获取热门排行数据
        let hotUrl = HOST_URL.appending(RECOMMEND_GET_HOT_ROMM_LIST)
        
//        let hotUrl = "https://httpbin.org/get"
//        let parameters = ["foo": "bar"]
        // http://172.16.200.5:8063/live/list?account=10000000000&token=2364d30079c44ae3897c42f0
//        let hotUrl = "http://172.16.200.5:8063/live/list"
//        let parameters = ["account":"10000000000","token":"2364d30079c44ae3897c42f03851d694"]

//        "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&time=1482734520&offset=0"
        
        let time = NSDate.getCurrentDateNumber()
        MQLog("date=\(time)")
        
//        let parameters = ["time":"\(time)","limit":"4","offset":"0"]
        let parameters = ["aid":"ios","client_sys":"ios","time":"\(time)","auth":"ddc8cda0a77453f40bf3b26926a15aba"]
        
        MQNetworkingTool.sendGetRequest(url: hotUrl, parameters: parameters, succeed: { (responseObject, isBadNet) in
            
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray{
                let groupModel = MQAnchorGroupModel(dict: dict)
                self.anchorGroupList.append(groupModel)
            }
            for group in self.anchorGroupList{
                print("dict = \(group.tag_name)")
                for anchor in group.anchorList{
                    print("nickName=\(anchor.nickname)")
                }
            }
            
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
    }
}
