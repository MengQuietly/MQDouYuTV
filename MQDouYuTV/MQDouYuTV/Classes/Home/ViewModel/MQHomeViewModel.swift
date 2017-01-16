//
//  MQHomeViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/6.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQHomeViewModel:首页 ViewModel

import UIKit

class MQHomeViewModel {
    lazy var subTitleList:[MQHomeSubTitleModel] = [MQHomeSubTitleModel]()
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
            for dict in dataArray {
                let subTitleModel = MQHomeSubTitleModel(dict: dict)
                
                self.subTitleList.append(subTitleModel)
            }

            
//            let path = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
//            
//            //向沙盒中写入文件
//            //写入文件
//            guard let paths = path else {return}
//            let fileP = paths.appendingPathComponent("Preferences/text1.txt")
//            let arr1: NSArray = ["code","change","world","OK"]
//            arr1.write(toFile: "\(fileP.path)", atomically: true)
//            
//            print("path= \(fileP)")
//            
//            let cachesPaths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
//            guard let cachesPath = cachesPaths else {return}
//            let fileP2 = cachesPath.appending("/text2.txt")
//            arr1.write(toFile: "\(fileP2)", atomically: true)
            
            
            finishCallBack()

            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
    }
}
