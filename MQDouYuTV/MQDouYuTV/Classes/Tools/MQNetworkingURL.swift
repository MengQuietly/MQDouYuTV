//
//  MQNetworkingURL.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/21.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  URL 工具类

import UIKit

// hostUrl
let HOST_URL = "http://capi.douyucdn.cn/"

// 推荐界面
// 最热列表
let RECOMMEND_POST_HOT_ROMM_LIST = "api/v1/getbigDataRoom"
// 颜值列表
let RECOMMEND_GET_PERTTY_ROMM_LIST = "api/v1/getVerticalRoom"
// 非颜值类其它热门列表
let RECOMMEND_GET_HOT_ROMM_LIST = "api/v1/getHotCate"



// banner 图 第一张
let RECOMMEND_POST_ONE_BANNER_LIST = "lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1482300540&token=93676757_11_9eed6478969f8f6e_2_80941920&auth=0e6a1681b5cba6e39854545c35205663"
// banner 列表 GET
let RECOMMEND_POST_NO_ONE_OTHER_BANNER_LIST = "api/v1/slide/6?version=2.421&client_sys=ios"


//// 最热更多点击：
//// 副标题获取（除第一和最后一个外）： GET
//http://capi.douyucdn.cn/api/v1/getColumnList?client_sys=ios
//// 副标题：全部中的内容 GET
//http://capi.douyucdn.cn/api/v1/live?limit=20&client_sys=ios&offset=0
//// 副标题：全部中的广告
//http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1482301800&token=93676757_11_9eed6478969f8f6e_2_80941920&auth=52941834af1cf16094c6baa939f62b7d
//// 副标题：全部中的广告图
//http://staticlive.douyucdn.cn/upload/signs/201612201046162679.jpg
//
//// 副标题：热门游戏点击
//// 副标题列表：GET
//http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game&client_sys=ios
//// 内容：GET

