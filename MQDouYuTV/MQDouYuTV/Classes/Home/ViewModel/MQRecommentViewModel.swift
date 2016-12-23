//
//  MQRecommentViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面 ViewModel

import UIKit

class MQRecommentViewModel {

}

// MARK:- 网络请求
extension MQRecommentViewModel{
    func getData() {
        
        // 获取热门排行数据
        let hotUrl = HOST_URL.appending(RECOMMEND_POST_NO_PERTTY_ROMM_LIST)
        
//        let hotUrl = "https://httpbin.org/get"
//        let parameters = ["foo": "bar"]
        // http://172.16.200.5:8063/live/list?account=10000000000&token=2364d30079c44ae3897c42f0
//        let hotUrl = "http://172.16.200.5:8063/live/list"
//        let parameters = ["account":"10000000000","token":"2364d30079c44ae3897c42f03851d694"]

//        "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&time=1482461305&offset=0"
        let time = NSDate.getCurrentDateNumber()
        print("date=\(time)")
        let parameters = ["time":"\(time)","limit":"4","offset":"0"]
        MQNetworkingTool.sendGetRequest(url: hotUrl, parameters: parameters, succeed: { (responseObject:[String : AnyObject]?, isBadNet:Bool) -> ()? in
            print("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
        }) { (error:NSError?, isBadNet:Bool) -> ()? in
            print("error=\(error),isBadNet=\(isBadNet)")
        }
    }
}
