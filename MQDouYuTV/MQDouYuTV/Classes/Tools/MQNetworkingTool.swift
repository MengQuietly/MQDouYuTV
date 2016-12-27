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

typealias succeed = (_ objc:Any?, _ badNetwork: Bool)->()
typealias failture = (_ error: NSError?, _ badNetwork: Bool)->()

class MQNetworkingTool {
    
//    // 测试
//    class func sendGetRequest2(url:String,parameters:[String:Any]?=nil,succeed: @escaping succeed, failure:@escaping failture) {
//        
////        let configuration = URLSessionConfiguration.default
////        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
////        let manager = SessionManager(configuration: configuration)
//        
////        var urlRequest = URLRequest(url: URL(string: url)!)
////        urlRequest.httpMethod = "GET"
////        let parameters2 = //["foo": "bar"]
////        do {
////            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
////        } catch {
////            // No-op
////        }
////        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
////        
////        Alamofire.request(urlRequest).responseJSON { (response) in
//    
//        Alamofire.request(url).validate(contentType: ["application/json"]).responseJSON { response in
//            MQLog(response.timeline)
//    
//            if #available(iOS 10.0, *) {
//                MQLog(response.metrics)
//            }
//            
//            MQLog("请求时间＝\(response.timeline)\n请求URL＝\(response.request!)\n请求返回值＝\(response.result.value)")
//            if response.result.isSuccess{
//                if let dict = response.result.value as? [String: AnyObject]{
//                    succeed(dict, false)
//                }else{//没有数据.网络错误
//                    let error = response.result.error as NSError?
//                    failure(error, true)
//                }
//            }else{//网络错误
//                let error = response.result.error as NSError?
//                failure(error, true)
//            }
//        }
//    }
    
    // MARK:- GET
    class func sendGetRequest(url:String,parameters:[String:Any]?=nil,succeed: @escaping succeed, failure:@escaping failture)->Void {
        
        Alamofire.request(url).validate(contentType: ["application/json"]).responseJSON { response in
            MQLog(response.timeline)
            
            
            if #available(iOS 10.0, *) {
                MQLog(response.metrics)
            }
            
            MQLog("请求时间＝\(response.timeline)\n请求URL＝\(response.request!)\n返回值＝\(response.result.value)")
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
    
    // MARK:- POST
    class func sendPostRequest(url:String,parameters:[String:Any]?=nil,succeed: @escaping succeed, failure:@escaping failture) -> Void {
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
            
            MQLog("请求时间＝\(response.timeline)\n请求URL＝\(response.request)\n返回值＝\(response.result.value)")
            
            if response.result.isSuccess{
//                guard let result = response.result.value as? [String:NSObject] else {return}
               
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
    
    
//    // MARK:- 发送请求（mg）
//    class func requestData(type:MQMethodType,url:String,parameters:[String:Any]?=nil,finishCallBack:@escaping (_ result:AnyObject)->()) {
//        
//        //请求头
////        let requestHeader:HTTPHeaders = ["Content-Type":"allication/json"];
//        let headers: HTTPHeaders = [
//            "Accept": "application/json"
//        ]
//
//        
//        var methods:HTTPMethod
//        if type == .GET {
//            methods = HTTPMethod.get
//        }else{
//            methods = HTTPMethod.post
//        }
////        Alamofire.SessionManager.defaultHTTPHeaders
//        
////        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: Parameters?, encoding: <#T##ParameterEncoding#>, headers: HTTPHeaders?)
//        
//        
//        
////        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
////        configuration.httpAdditionalHeaders = headers
////        configuration.timeoutIntervalForRequest = 15
////        let manager = SessionManager(configuration: configuration)
//        
//        
////        //设置manager属性
////        var manger:SessionManager
//////        //设置manager属性
//////        var manger:SessionManager
////        //配置 , 通常默认即可
////        let config:URLSessionConfiguration = URLSessionConfiguration.default
////        //设置超时时间为15S
////        
////        config.timeoutIntervalForRequest = 15
////        //根据config创建manager
////        manger = SessionManager(configuration: config)
//        Alamofire.request(url).validate(contentType: ["application/json"]).responseJSON { response in
//            MQLog(response.timeline)
////        }
////        
////        Alamofire.request(url, method: methods, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse) in
//            
//            MQLog("请求：\(response.request!),\(response.result.value)")
//            
//            guard let result = response.result.value else{
//                MQLog("MG 请求失败：\(response.result.error)")
//                return
//            }
//            finishCallBack(result as AnyObject)
//        }
//    }
//    // MARK:- 发送请求（自己）
//    class func sendRequest(type:MQMethodType,url:String,parameters:[String:AnyObject]?=nil,succeed: @escaping succeed, failure:@escaping failture){
//        
//        var methods:HTTPMethod
//        if type == .GET {
//            methods = HTTPMethod.get
//        }else{
//            methods = HTTPMethod.post
//        }
//        Alamofire.request(url, method: methods, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse) in
//
//            
////            switch(response.result) {
////            case .success(_):
////                if let data = response.result.value{
////                    MQLog(data)
////                    finish(data as AnyObject, false)
////                }
////                break
////                
////            case .failure(_):
////                MQLog(response.result.error)
////                finish(response.result.error as AnyObject, true)
////                break
////            }
//        }
//        
//    }
}


