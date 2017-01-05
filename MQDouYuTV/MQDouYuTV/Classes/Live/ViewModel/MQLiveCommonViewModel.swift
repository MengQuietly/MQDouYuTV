//
//  MQLiveCommonViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/5.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  MQLiveCommonViewModel

import UIKit

class MQLiveCommonViewModel: NSObject {
    // MARK：－ 懒加载
    
    /// common List
     lazy var commonLists:[MQLiveCommonModel] = [MQLiveCommonModel]()
}

// MARK:-  网络请求
extension MQLiveCommonViewModel{
    
    // MARK: 获取直播：常用列表
    func getCommonWithLiveList(finishCallBack: @escaping()->()) {
        let commonUrl = HOST_URL.appending(GAME_GET_ALLGAME_LIST)
//        let commonDict = ["shortName":"game"] parameters:commonDict,
        MQNetworkingTool.sendRequest(url: commonUrl, succeed: { (responseObject, isBadNet) in
            
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray{
                self.commonLists.append(MQLiveCommonModel(dict: dict))
            }
            finishCallBack()
            
        }) { (error, isBadNet) in
            MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
    }
}

