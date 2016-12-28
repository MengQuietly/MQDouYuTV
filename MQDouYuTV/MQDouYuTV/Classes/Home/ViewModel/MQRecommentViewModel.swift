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
    // MQAnchorGroupModel 数组(所有数据组)
    lazy var anchorGroupList: [MQAnchorGroupModel] = [MQAnchorGroupModel]()
    // 热门组
    lazy var hotGroup:MQAnchorGroupModel = MQAnchorGroupModel()
    // 颜值组
    lazy var perttyGroup:MQAnchorGroupModel = MQAnchorGroupModel()
}

// MARK:- 网络请求
extension MQRecommentViewModel{
    
    // MARK: 获取热门组数据 (1-热门，2-颜值，3-剩余其它2-12组热门)
    func getHotGroupData(_ finishCallBack:@escaping ()->()) {
        // 创建group
        let netGroup = DispatchGroup() //dispatch_group_create()
        
        // 将当前网络操作添加到组中
        netGroup.enter() //dispatch_group_enter(netGroup)
        
        // MARK:获取最热排行数据
        let hotUrl = HOST_URL.appending(RECOMMEND_POST_HOT_ROMM_LIST)
        MQNetworkingTool.sendPostRequest(hotUrl, succeed: { (responseObject, isBadNet) in
            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            
            // 创建颜值组
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_url = "home_header_hot"
            for dict in dataArray{
                let anchor = MQAnchorModel(dict: dict)
                self.hotGroup.anchorList.append(anchor)
            }

            // 离开组
            netGroup.leave() //dispatch_group_leave(netGroup)
            
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        
        // 将当前网络操作添加到组中
        netGroup.enter()
        // MARK:获取颜值排行数据
        let perttyUrl = HOST_URL.appending(RECOMMEND_GET_PERTTY_ROMM_LIST)
        let perttyDict = ["limit":"4","offset":"0"]
        
        MQNetworkingTool.sendGetRequest(perttyUrl, parameters: perttyDict, succeed: { (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
        
            self.perttyGroup.tag_name = "颜值"
            self.perttyGroup.icon_url = "home_header_pretty"
            for dict in dataArray{
                let anchor = MQAnchorModel(dict: dict)
//                print("nickName=\(anchor.nickname)")
                self.perttyGroup.anchorList.append(anchor)
            }
            
            // 离开组
            netGroup.leave()
            
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        // 将当前网络操作添加到组中
        netGroup.enter()
        // MARK:获取2-12其它热门排行数据
        let otherHotUrl = HOST_URL.appending(RECOMMEND_GET_HOT_ROMM_LIST)
        
        let time = Date.getCurrentDateNumber()
//        MQLog("date=\(time)")
        
//        let otherHotDict = ["time":"\(time)","limit":"4","offset":"0"] // Post
        let otherHotDict = ["aid":"ios","time":"\(time)","auth":"ddc8cda0a77453f40bf3b26926a15aba"]
        
        MQNetworkingTool.sendGetRequest(otherHotUrl, parameters: otherHotDict, succeed: { (responseObject, isBadNet) in
            
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray{
                let groupModel = MQAnchorGroupModel(dict: dict)
                groupModel.icon_url = "home_header_normal"
                guard (groupModel.anchorList.count > 0) else {continue}
                self.anchorGroupList.append(groupModel)
            }

            // 离开组
            netGroup.leave()
            
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        // 网络组完成后，执行
//        dispatch_group_notify(netGroup, dispatch_get_main_queue()) { () -> Void in}
        netGroup.notify(queue: DispatchQueue.main) { 
            // 插入热门、颜值到group
            self.anchorGroupList.insert(self.perttyGroup, at: 0)
            self.anchorGroupList.insert(self.hotGroup, at: 0)
            finishCallBack()
        }
    }
}
