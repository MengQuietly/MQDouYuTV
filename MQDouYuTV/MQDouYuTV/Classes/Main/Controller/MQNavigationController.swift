//
//  MQNavigationController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/21.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  自定义 UINavigationController

import UIKit

class MQNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏底部 tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
