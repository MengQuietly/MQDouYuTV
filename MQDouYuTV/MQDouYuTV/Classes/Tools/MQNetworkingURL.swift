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

// MARK:- 首页
// 获取首页副标题列表（无推荐）
// http://capi.douyucdn.cn/api/homeCate/getCateList?client_sys=ios
let HOME_GET_SUBTITLE_LIST = "api/homeCate/getCateList"

// MARK：－ 推荐界面
/// 最热列表（first）POST(token)
// http://capi.douyucdn.cn/api/v1/getbigDataRoom?client_sys=ios
let RECOMMEND_POST_HOTTEST_ROMM_LIST = "api/v1/getbigDataRoom"

/// 颜值列表 GET
// http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&client_sys=ios&offset=0
let RECOMMEND_GET_PERTTY_ROMM_LIST = "api/v1/getVerticalRoom"

/// 非颜值类其它热门列表 POST(token:58329051_11_c896fb45d9451c3b_2_75461464)
// http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1483005840&auth=690f8a95e6e66401f61dbdec2eb8d207
let RECOMMEND_POST_HOT_ROMM_LIST = "api/v1/getHotCate"

/// banner 列表 GET
// http://capi.douyucdn.cn/api/v1/slide/6?version=2.421&client_sys=ios
let RECOMMEND_GET_BANNER_LIST = "api/v1/slide/6"

// 趣玩列表（弃用）
// http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=30&offset=0

//// （附加）游戏全部列表(api/v1/getColumnDetail?shortName=game)
//let GAME_GET_ALLGAME_LIST = "api/v1/getColumnDetail"

// GET 常用直播列表
// http://capi.douyucdn.cn/api/v1/getColumnDetail?client_sys=ios
let LIVE_GET_COMMON_LIST = "api/v1/getColumnDetail"

/// 娱乐点击 GET (api/homeCate/getHotRoom?identification=9acf9c6f117a4c2d02de30294ec29da9&client_sys=ios)
let AMUSE_GET_AMUSE_LIST = "api/homeCate/getHotRoom"

/// （未使用）banner 图 第1、2张下载（posid ＝ 800002,800003,800015，roomid ＝ 0）
let RECOMMEND_POST_ONE_BANNER_LIST = "lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1482300540&token=93676757_11_9eed6478969f8f6e_2_80941920&auth=0e6a1681b5cba6e39854545c35205663"


// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1482300540&token=93676757_11_9eed6478969f8f6e_2_80941920&auth=0e6a1681b5cba6e39854545c35205663

// 12.29-6:06
/*PoST:
 getinfo?aid
 getPrivateMessage
 getTaskNum
 remind_tags
 member_pay_info
 rtpv
 getinfo
 getHotCate
 getbigData
 */

// POST
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483582260&token=58329051_11_7832db991623594c_2_75461464&auth=b13a8d3d942147104d8b23471694bd17

// GET
// 检查更新
// http://capi.douyucdn.cn/api/ios_app/check_update
// 获取等级图标
// http://capi.douyucdn.cn/api/v1/getExpRule/2?client_sys=ios
// 获取荣耀图标
// http://capi.douyucdn.cn/lapi/live/app/reward?aid=ios&client_sys=ios&time=1483685220&auth=1feccde54b99ad866edd2d6f8815f687

// http://capi.douyucdn.cn/api/v1/getclientface?client_sys=ios
// http://capi.douyucdn.cn/api/v1/gethonorimg?level=2&client_sys=ios
// http://msg.douyu.com/user
// http://capi.douyucdn.cn/lapi/live/app/reward?aid=ios&client_sys=ios&time=1483005840&auth=dae37a7bccfc1849de6ab199dcf71957
// http://capi.douyucdn.cn/api/v1/station_effect?client_sys=ios
// http://capi.douyucdn.cn/api/v1/followremindinfo?client_sys=ios
// http://capi.douyucdn.cn/api/applivecompanion/getUploadSwitch?client_sys=ios
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483005840&token=58329051_11_c896fb45d9451c3b_2_75461464&auth=f96e624ed1ecb671a57d9d8d8de78031

// http://capi.douyucdn.cn/api/app_api/get_app_list?sign=e382b51f0b41840ce8b06cda02d927f2&client_sys=ios&devid=0310B283-98D1-44B4-AD25-FC0E4EEBCC4F&time=1483005840&type=ios
// http://capi.douyucdn.cn/wb_share/config?client_sys=ios
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483005840&token=58329051_11_c896fb45d9451c3b_2_75461464&auth=086ed96a32bcb3a4868e19d3e286421d


// tabbar: 直播点击

// GET
// http://capi.douyucdn.cn/api/v1/getColumnList?client_sys=ios
// POST
// http://capi.douyucdn.cn/api/v1/live?limit=20&client_sys=ios&offset=0
// POST: posid	800007,800008,800009 roomid	0
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483582980&token=58329051_11_7832db991623594c_2_75461464&auth=dc4ffa5929684270f33f9315a417b1e1
// GET 常用列表
// http://capi.douyucdn.cn/api/v1/getColumnDetail?client_sys=ios

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

/// 手游点击
// POST posid	800004 roomid	0
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483684560&token=58329051_11_7832db991623594c_2_75461464&auth=5f9e92560cdfbfa4c812903147b3145a

// GET
// http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=3e760da75be261a588c74c4830632360&client_sys=ios
/// 娱乐点击
// POST posid	800005 roomid	0
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483684620&token=58329051_11_7832db991623594c_2_75461464&auth=ab4655251a370d4197f6526c31c37adf
// GET
// http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=9acf9c6f117a4c2d02de30294ec29da9&client_sys=ios

/// 游戏
// POST posid	800006 roomid	0
// http://capi.douyucdn.cn/lapi/sign/appapi/getinfo?aid=ios&client_sys=ios&time=1483684800&token=58329051_11_7832db991623594c_2_75461464&auth=e01ebe2f687ba0e01b5e74ba0d0ae7d2

// GET
// http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=ba08216f13dd1742157412386eee1225&client_sys=ios

/// 趣玩
// GET
// http://capi.douyucdn.cn/api/homeCate/getHotRoom?identification=393b245e8046605f6f881d415949494c&client_sys=ios
