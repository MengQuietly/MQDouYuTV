//
//  MQBaseController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/19.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//  基础类：设置统一动画展示效果

import UIKit

class MQBaseController: UIViewController {
    
    // 数据未加载完成不展示各个VC中的CollectionView
    var contentView : UIView?
    fileprivate lazy var animationImageView: UIImageView = { [unowned self] in
        let animationImageView = UIImageView(image: UIImage(named: "loading-1"))
        var imageList: Array = [UIImage]()
        for i in 1..<5 {
            imageList.append(UIImage(named: "loading-\(i)")!)
        }
        animationImageView.isUserInteractionEnabled = false
        animationImageView.animationImages = imageList
        animationImageView.animationDuration = 0.5
        animationImageView.animationRepeatCount = LONG_MAX
        animationImageView.center = self.view.center
        animationImageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return animationImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

// MARK: - 设置UI界面
extension MQBaseController {
    func setupUI() {
        view.backgroundColor = UIColor(red: 250, green: 250, blue: 250)
        contentView?.isHidden = true
        view.addSubview(animationImageView)
        animationImageView.stopAnimating()
        animationImageView.startAnimating()
    }
    
    // 数据请求完成，关闭动画，展示 collectionView
    func loadDataFinished() {
        animationImageView.stopAnimating()
        animationImageView.isHidden = true
        contentView?.isHidden = false
    }
}
