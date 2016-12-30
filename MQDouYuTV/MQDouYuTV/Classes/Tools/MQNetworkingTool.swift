//
//  MQNetworkingTool.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit
import Alamofire

enum MQMethodType {
    case get
    case post
}

typealias Finished = (_ responseObject:[String: AnyObject]?, _ error: NSError?, _ badNetwork: Bool) -> ()?

typealias succeed = (_ objc:Any?, _ badNetwork: Bool)->()
typealias failture = (_ error: NSError?, _ badNetwork: Bool)->()

class MQNetworkingTool {
    
    // MARK:- 发送请求
    class func sendRequest(type:MQMethodType?=MQMethodType.get,url:String,parameters:[String:Any]?=nil,succeed: @escaping succeed, failure:@escaping failture) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        let headers: HTTPHeaders = ["Accept": "application/json","client_sys":"ios"]
    
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { (response:DataResponse) in
            
//            MQLog("请求时间＝\(response.timeline)\n请求URL＝\(response.request)")
//            MQLog("返回值＝\(response.result.value)")
            print("请求URL＝\(response.request)")
            if response.result.isSuccess{
                
                if let dict = response.result.value as? [String: AnyObject]{
                    succeed(dict, false)
                }else{//没有数据.网络错误
                    let error = response.result.error as! NSError
                    failure(error, true)
                }
            }else{//网络错误
                let error = response.result.error as! NSError
                failure(error, true)
            }
        }
    }
}


