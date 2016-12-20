//
//  MQHomeController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  HomeController 首页主布局

import UIKit

// PageTitleView-height
private let kPageTitleViewH: CGFloat = 50

/** HomeController  */
class MQHomeController: UIViewController {
    
    // 懒加载属性
    lazy var pageTitleViews: MQPageTitleView = {

        let pageTitleViewF = CGRect(x: 0, y: kStatusBarH + kNaviagtionBarH, width: kScreenW, height: kPageTitleViewH)
        let pageTitleViewWithTitle = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = MQPageTitleView(frame: pageTitleViewF, title: pageTitleViewWithTitle)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    lazy var pageContentViews: MQPageContentView = {[weak self] in
        
        let pageContentViewY = kStatusBarH + kNaviagtionBarH + kPageTitleViewH
        let pageContentViewH = kScreenH - kStatusBarH - kNaviagtionBarH - kPageTitleViewH - kTabBarH
        let pageContentViewF = CGRect(x: 0, y: pageContentViewY, width: kScreenW, height: pageContentViewH)
        
        var pageContentWithVC = [UIViewController]()
        // 添加推荐界面
        pageContentWithVC.append(MQRecommendController())
        // 添加其它界面
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(displayP3Red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            pageContentWithVC.append(vc)
        }
        
        let pageContentView = MQPageContentView(frame: pageContentViewF, childVCList: pageContentWithVC, parentVC: self)
        
        pageContentView.pageContentViewDelegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置 UI 界面
        self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

// MARK:- 设置 UI 界面
extension MQHomeController {
 
    // 设置 UI 界面
    func setupUI() {
        // 不需要调整 UIScrollView 的内边距
        self.automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏
        setupNav()
        
        // 添加 PageTitleView
        self.view.addSubview(pageTitleViews)
        
        // 添加 PageContentView
        self.view.addSubview(pageContentViews)
    }
    
    // 设置导航栏
    private func setupNav() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        let itemSize = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: itemSize)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: itemSize)
         let scanItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: itemSize)
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, scanItem]
    }
    
}

// MARK:-实现 MQPageTitleViewDelegate
extension MQHomeController: MQPageTitleViewDelegate{
    func pageTitleView(titleView: MQPageTitleView, currentSelIndex selIndex: Int) {
        pageContentViews.setCurrentIndex(currentIndex: selIndex)
    }
}

// MARK:-实现 MQPageContentViewDelegate(设置contentView滚动信息)
extension MQHomeController: MQPageContentViewDelegate{
    func pageContentViewWithSetScroll(contentView: MQPageContentView, progress: CGFloat, startIndex: Int, endIndex: Int) {
        pageTitleViews.setPageTitleViewWithScroll(progress: progress, startIndex: startIndex, endIndex: endIndex)
    }
}
