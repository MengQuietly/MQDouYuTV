//
//  MQTabBarController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//

import UIKit

class MQTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyboardName: "Home")
        addChildVC(storyboardName: "Live")
        addChildVC(storyboardName: "Follow")
        addChildVC(storyboardName: "Profile")
        
    }
    
    /// 添加 StoryBoard 控制器
    private func addChildVC(storyboardName: String) {
        let vc:UIViewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        self.addChildViewController(vc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
