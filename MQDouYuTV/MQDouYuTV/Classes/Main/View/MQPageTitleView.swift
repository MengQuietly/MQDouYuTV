//
//  MQPageTitleView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/22.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  Home MQPageTitleView

import UIKit

// TitleBottomLabelWithLineView-height、TitleScrollViewWithBottomLineView-height
private let kTitleLabelWithBottomLineViewH: CGFloat = 2
private let kTitleScrollViewWithBottomLineViewH: CGFloat = 1
//private let kTitleScrollViewWithBottomLineViewY: CGFloat =

// MARK:- MQPageTitleView
class MQPageTitleView: UIView {

    // 定义属性
    var title = [String]()
    
    // 懒加载属性
    lazy var titleLabelList:[UILabel] = [UILabel]()
    lazy var titleScrollViews: UIScrollView = {
        let titleScrollView = UIScrollView()
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.scrollsToTop = false
        titleScrollView.bounces = false
        return titleScrollView
    }()
    
    lazy var titleLabelWithBottomLineViews: UIView = {
        let titleLabelWithBottomLineView = UIView()
        titleLabelWithBottomLineView.backgroundColor = UIColor.orange
        return titleLabelWithBottomLineView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, title:[String]) {
        self.title = title
        super.init(frame: frame)
        
        // 设置 UI 界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置 MQPageTitleView－UI
extension MQPageTitleView {
    
    func setupUI() {
        
        // 添加 titleScrollView
        titleScrollViews.frame = bounds
        self.addSubview(titleScrollViews)
        
        // 添加 [titleLabel]
        setTitleLabels()
        
        // 设置 TitleScrollViewWithBottomLineView
        setTitleScrollViewWithBottomLineView()
    }
    
    // set title label Arr
    func setTitleLabels() {
        
        let titleLabelY: CGFloat = 0
        let titleLabelW: CGFloat = frame.width / CGFloat(title.count)
        let titleLabelH: CGFloat = frame.height

        for (index,labelTitle) in title.enumerated() {
            let titleLabel = UILabel()
            titleLabel.tag = index
            titleLabel.text = labelTitle
            titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
            titleLabel.adjustsFontForContentSizeCategory = true
            if index == 1 || index == 3 {
                titleLabel.backgroundColor = UIColor.blue
            } else {
                titleLabel.backgroundColor = UIColor.yellow
            }
            titleLabel.textColor = UIColor.black
            titleLabel.textAlignment = .center
            let titleLabelX: CGFloat = titleLabelW * CGFloat(index)
            
            titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            
            titleScrollViews.addSubview(titleLabel)
            titleLabelList.append(titleLabel)
        }
    }
    
    // set title scrollView Bottom line
    func setTitleScrollViewWithBottomLineView() {
        
        // 添加 TitleScrollViewWithBottomLineView
        let titleScrollViewWithBottomLineView = UIView()
        titleScrollViewWithBottomLineView.backgroundColor = UIColor.lightGray
        titleScrollViewWithBottomLineView.frame = CGRect(x: 0, y: bounds.height - kTitleScrollViewWithBottomLineViewH, width: kScreenW, height: kTitleScrollViewWithBottomLineViewH)
        self.addSubview(titleScrollViewWithBottomLineView)

        // 添加 TitleLabelWithBottomLineView
        guard let currentLabel = titleLabelList.first else { return }
        currentLabel.textColor = UIColor.orange
        let currentLabelF = currentLabel.frame
        let titleLabelWithBottomLineViewY: CGFloat = currentLabelF.size.height - kTitleLabelWithBottomLineViewH
        titleLabelWithBottomLineViews.frame = CGRect(x: currentLabelF.origin.x, y: titleLabelWithBottomLineViewY, width: currentLabelF.size.width, height: kTitleLabelWithBottomLineViewH)
        titleScrollViews.addSubview(titleLabelWithBottomLineViews)

    }
}
