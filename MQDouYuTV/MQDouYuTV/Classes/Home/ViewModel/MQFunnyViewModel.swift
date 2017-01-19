//
//  MQFunnyViewModel.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/19.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//

import UIKit

class MQFunnyViewModel: MQBaseAnchorViewModel {

}

// MARK:- 数据请求
extension MQFunnyViewModel {
    func getFunnyListData (identifications:String,finishCallBack: @escaping ()->()) {
        let funnyUrl = HOST_URL.appending(AMUSE_GET_AMUSE_LIST)
        let funnyDict = ["identification" : identifications]
        getAnchorData(urlString: funnyUrl, parameters: funnyDict, finishCallBack: finishCallBack)
    }
}
