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
        
        // 自定义Pan手势 替换 系统 POP 手势
        convertSystemPopGesture()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏底部 tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}

extension MQNavigationController {
    /// 替换系统POP手势（系统手势：只有左边缘能右滑返回，自定义Pan手势：整个屏幕都能右滑返回）
    fileprivate func convertSystemPopGesture() {
        guard let systemPopGesture = interactivePopGestureRecognizer else { return }
        // 获取手势添加到 View 中
        guard let gestureView = systemPopGesture.view else { return }
        
//        // 1.利用运行时机制查看所有属性名称
//        var count: UInt32 = 0
//        // 获取 UIGestureRecognizer 中的所有属性名称列表
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let ivar = ivars[Int(i)]
//            // 获取属性名
//            let name = ivar_getName(ivar)!
//            // 输出属性名
//            let nameString = String(cString: namei)
//            print("i = \(nameString)")
//        }
        
        /// 获取系统 target ／ action
        // 获取targes数组
        let targets = systemPopGesture.value(forKey: "_targets") as? [NSObject]
        guard let targetObj = targets!.first else { return }
        // 获取 target
        guard let target = targetObj.value(forKey: "target") else { return }
        // 获取action
        let action = Selector(("handleNavigationTransition:"))
        // 添加手势
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(target, action: action)
        gestureView.addGestureRecognizer(panGesture)
    }
}
