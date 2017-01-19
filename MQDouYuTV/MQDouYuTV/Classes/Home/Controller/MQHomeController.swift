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


class MQHomeController: UIViewController {
    
    // MARK: Lazy
    fileprivate lazy var homeViewModel = MQHomeViewModel()
    
    fileprivate let pageTitleViewWithTitle:[String] = ["推荐","游戏","手游","娱乐","趣玩"]
    
    // 懒加载属性
    fileprivate lazy var pageTitleViews: MQPageTitleView = {

        let pageTitleViewF = CGRect(x: 0, y: kStatusBarH + kNaviagtionBarH, width: kScreenW, height: kPageTitleViewH)
        let pageTitleView = MQPageTitleView(frame: pageTitleViewF, title: self.pageTitleViewWithTitle)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentViews: MQPageContentView = {[weak self] in
        
        let pageContentViewY = kStatusBarH + kNaviagtionBarH + kPageTitleViewH
        let pageContentViewH = kScreenH - kStatusBarH - kNaviagtionBarH - kPageTitleViewH - kTabBarH
        let pageContentViewF = CGRect(x: 0, y: pageContentViewY, width: kScreenW, height: pageContentViewH)
        
        var pageContentWithVC = [UIViewController]()
        // 添加推荐界面
        pageContentWithVC.append(MQRecommendController())
        // 添加游戏界面
        pageContentWithVC.append(MQLiveCommonController())
        // 添加手游界面
        pageContentWithVC.append(UIViewController())
        // 添加娱乐界面
        let amuseVC = MQAmuseController()
        amuseVC.identifications = kAmuseIdentification
        pageContentWithVC.append(amuseVC)
        
        // 添加趣玩界面
        let funnyVC = MQFunnyController()
        funnyVC.identifications = kFunnyIdentification
        pageContentWithVC.append(funnyVC)
        
        let pageContentView = MQPageContentView(frame: pageContentViewF, childVCList: pageContentWithVC, parentVC: self)
        
        pageContentView.pageContentViewDelegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getHomeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- 数据请求
extension MQHomeController {
    fileprivate func getHomeData() {

        if kFirstStartApp == false{
            // 设置 UI 界面
            self.setupUI()
        }else{
            homeViewModel.getHomeSubTitle { [unowned self] in
                DispatchQueue.main.async(execute: {
                    self.setupUI()
                })
            }
        }
    }
}

// MARK:- 设置 UI 界面
extension MQHomeController {
 
    // 设置 UI 界面
    fileprivate func setupUI() {
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
    fileprivate func setupNav() {
        
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
    func pageTitleView(_ titleView: MQPageTitleView, currentSelIndex selIndex: Int) {
        pageContentViews.setCurrentIndex(selIndex)
    }
}

// MARK:-实现 MQPageContentViewDelegate(设置contentView滚动信息)
extension MQHomeController: MQPageContentViewDelegate{
    func pageContentViewWithSetScroll(_ contentView: MQPageContentView, progress: CGFloat, startIndex: Int, endIndex: Int) {
        pageTitleViews.setPageTitleViewWithScroll(progress, startIndex: startIndex, endIndex: endIndex)
    }
}
