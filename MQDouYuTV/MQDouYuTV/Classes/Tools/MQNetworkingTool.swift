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
    case GET
    case POST
}

typealias Finished = (_ responseObject:[String: AnyObject]?, _ error: NSError?, _ badNetwork: Bool) -> ()?

typealias succeed = (_ objc:[String: AnyObject]?, _ badNetwork: Bool)->()?
typealias failture = (_ error: NSError?, _ badNetwork: Bool)->()?

class MQNetworkingTool {
    // MARK:- 发送请求（mg）
    class func requestData(type:MQMethodType,url:String,parameters:[String:NSString]?=nil,finishCallBack:@escaping (_ result:AnyObject)->()) {
        var methods:HTTPMethod
        if type == .GET {
            methods = HTTPMethod.get
        }else{
            methods = HTTPMethod.post
        }
        
        Alamofire.request(url, method: methods, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse) in
            
            guard let result = response.result.value else{
                print("MG 请求失败：\(response.result.error)")
                return
            }
            finishCallBack(result as AnyObject)
        }
    }
    // MARK:- 发送请求（自己）
    class func sendRequest(type:MQMethodType,url:String,parameters:[String:NSString]?=nil,succeed: @escaping succeed, failure:@escaping failture){
        
        var methods:HTTPMethod
        if type == .GET {
            methods = HTTPMethod.get
        }else{
            methods = HTTPMethod.post
        }
        Alamofire.request(url, method: methods, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse) in
            
            if response.result.isSuccess{
                if let dict = response.result.value as? [String: AnyObject]{
                    succeed(dict, false)
                }else{//没有数据.网络错误
                    let error = response.result.error as NSError?
                    failure(error, true)
                }
            }else{//网络错误
                let error = response.result.error as NSError?
                failure(error, true)
            }
            
//            switch(response.result) {
//            case .success(_):
//                if let data = response.result.value{
//                    print(data)
//                    finish(data as AnyObject, false)
//                }
//                break
//                
//            case .failure(_):
//                print(response.result.error)
//                finish(response.result.error as AnyObject, true)
//                break
//            }
        }
        
    }
}


