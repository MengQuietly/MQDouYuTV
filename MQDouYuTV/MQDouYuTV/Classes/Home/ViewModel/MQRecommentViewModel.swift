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
    
    /// banners List
    lazy var bannerLists:[MQBannerModel] = [MQBannerModel]()
    
    // MQAnchorGroupModel 数组(所有数据组)
    lazy var anchorGroupList: [MQAnchorGroupModel] = [MQAnchorGroupModel]()
    // 热门组
    lazy var hotGroup:MQAnchorGroupModel = MQAnchorGroupModel()
    // 颜值组
    lazy var perttyGroup:MQAnchorGroupModel = MQAnchorGroupModel()
}

// MARK:- 网络请求
extension MQRecommentViewModel{
    
    // MARK: 获取banner 数据
    func getBannerListData(_ finishCallBack:@escaping ()->()) {
        let bannerUrl = HOST_URL.appending(RECOMMEND_GET_BANNER_LIST)
        let bannerDict = ["version":"2.421"]
        MQNetworkingTool.sendRequest(url:bannerUrl, parameters: bannerDict, succeed: { [unowned self] (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else  {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray {
                let bannerModel = MQBannerModel(dict: dict)
                self.bannerLists.append(bannerModel)
            }
        
            finishCallBack()
            
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        let time = Date.getCurrentDateNumber()
        let firUrl = "http://capi.douyucdn.cn/lapi/sign/appapi/getinfo"
        let firDict = ["aid":"ios","time":"\(time)","token":"58329051_11_c896fb45d9451c3b_2_75461464","auth":"086ed96a32bcb3a4868e19d3e286421d","posid":"800002,800003,800015","roomid":"0"]
        MQNetworkingTool.sendRequest(type: MQMethodType.post, url:firUrl,  parameters: firDict,succeed: { (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            /*
             adid = 1000002435;
             adtype = 0;
             ec = "<null>";
             level = 0;
             link = "http://act.jl.ztgame.com/landing/index.html?zttag=douyujiaodiantu";
             posid = 800002;
             proid = 1000000884;
             proname = "\U8857\U7bee";
             showtime = 5;
             srcid = "http://staticlive.douyucdn.cn/upload/signs/201612291838263960.jpg";
             */
            }) { (error, isBadNet) in
                MQLog("error=\(error),isBadNet=\(isBadNet)")
        }
        
        
    }
    
    // MARK: 获取热门组数据 (1-热门，2-颜值，3-剩余其它2-12组热门)
    func getRoomGroupListData(_ finishCallBack:@escaping ()->()) {
        // 创建group
        let netGroup = DispatchGroup() //dispatch_group_create()
        
        // 将当前网络操作添加到组中
        netGroup.enter() //dispatch_group_enter(netGroup)
        
        // MARK:获取最热排行数据
        let hotUrl = HOST_URL.appending(RECOMMEND_POST_HOTTEST_ROMM_LIST)
        MQNetworkingTool.sendRequest(type: MQMethodType.post, url:hotUrl, succeed: { [unowned self] (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            
            // 创建颜值组
            self.hotGroup.tag_name = "热门"
            self.hotGroup.icon_name = "home_header_hot"
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
        
        MQNetworkingTool.sendRequest(url:perttyUrl, parameters: perttyDict, succeed: { [unowned self] (responseObject, isBadNet) in
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
        
            self.perttyGroup.tag_name = "颜值"
            self.perttyGroup.icon_name = "home_header_pretty"
            for dict in dataArray{
                let anchor = MQAnchorModel(dict: dict)
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
        let otherHotUrl = HOST_URL.appending(RECOMMEND_POST_HOT_ROMM_LIST)
        
        let time = Date.getCurrentDateNumber()
        let otherHotDict = ["aid":"ios","time":"\(time)","auth":"ddc8cda0a77453f40bf3b26926a15aba"]
        
        MQNetworkingTool.sendRequest(type: MQMethodType.post, url:otherHotUrl, parameters: otherHotDict, succeed: { [unowned self] (responseObject, isBadNet) in
            
//            MQLog("responseObject=\(responseObject),isBadNet=\(isBadNet)")
            
            guard let resultDict = responseObject as? [String:NSObject] else {return}
            guard let dataArray = resultDict["data"] as? [[String:NSObject]] else {return}
            for dict in dataArray{
                let groupModel = MQAnchorGroupModel(dict: dict)
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
        netGroup.notify(queue: DispatchQueue.main) { [unowned self] in
            // 插入热门、颜值到group
            self.anchorGroupList.insert(self.perttyGroup, at: 0)
            self.anchorGroupList.insert(self.hotGroup, at: 0)
            finishCallBack()
        }
    }
}
