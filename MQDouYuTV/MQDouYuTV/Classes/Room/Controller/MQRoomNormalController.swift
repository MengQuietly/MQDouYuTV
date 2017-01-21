//
//  MQRoomNormalController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/21.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//

import UIKit

class MQRoomNormalController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    }
    
}

extension MQRoomNormalController: UIGestureRecognizerDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏 navBar
        navigationController?.setNavigationBarHidden(true, animated: true)
        // 依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
