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
private let kTitleLabelWithNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kTitleLabelWithSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK: 设置 Delegate，“:class” 表此协议只能被类遵守
protocol MQPageTitleViewDelegate: class {
    func pageTitleView(_ titleView:MQPageTitleView,currentSelIndex selIndex:Int)
}

// MARK:- MQPageTitleView
class MQPageTitleView: UIView {

    // 当前label Index
    var currentSelectLabelIndex : Int = 0
    
    /// 定义属性
    var title = [String]()
    // 定义代理
    var delegate:MQPageTitleViewDelegate?
    
    /// 懒加载属性
    // titleLabel Array
    lazy var titleLabelList:[UILabel] = [UILabel]()
    // title ScrollView
    lazy var titleScrollViews: UIScrollView = {
        let titleScrollView = UIScrollView()
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.scrollsToTop = false
        titleScrollView.bounces = false
        return titleScrollView
    }()
    // titleLabel BottomLine
    lazy var titleLabelWithBottomLineViews: UIView = {
        let titleLabelWithBottomLineView = UIView()
        titleLabelWithBottomLineView.backgroundColor = UIColor.orange
        return titleLabelWithBottomLineView
    }()
    
    /// MARK:- 自定义构造函数
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
            if #available(iOS 10.0, *) {
                titleLabel.adjustsFontForContentSizeCategory = true
            }
            titleLabel.textColor = UIColor(displayP3Red: kTitleLabelWithNormalColor.0, green: kTitleLabelWithNormalColor.1, blue: kTitleLabelWithNormalColor.2)
            titleLabel.textAlignment = .center
            let titleLabelX: CGFloat = titleLabelW * CGFloat(index)
            
            titleLabel.frame = CGRect(x: titleLabelX, y: titleLabelY, width: titleLabelW, height: titleLabelH)
            
            titleScrollViews.addSubview(titleLabel)
            titleLabelList.append(titleLabel)
            // 添加手势
            titleLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(pageTitleLabelClick(tap:)))
            titleLabel.addGestureRecognizer(tap)
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
        currentLabel.textColor = UIColor(displayP3Red: kTitleLabelWithSelectColor.0, green: kTitleLabelWithSelectColor.1, blue: kTitleLabelWithSelectColor.2)

        let currentLabelF = currentLabel.frame
        let titleLabelWithBottomLineViewY: CGFloat = currentLabelF.size.height - kTitleLabelWithBottomLineViewH
        titleLabelWithBottomLineViews.frame = CGRect(x: currentLabelF.origin.x, y: titleLabelWithBottomLineViewY, width: currentLabelF.size.width, height: kTitleLabelWithBottomLineViewH)
        titleScrollViews.addSubview(titleLabelWithBottomLineViews)

    }
}

// MARK:- 监听titleLabel点击(注：事件方法前最好添加 “@objc”)
extension MQPageTitleView{
    @objc func pageTitleLabelClick(tap:UITapGestureRecognizer){
        
        guard let currentTitleLabel = tap.view as? UILabel else { return }
    
        // 判定当前是否选中了已选择的按钮
        if currentTitleLabel.tag == self.currentSelectLabelIndex {return}
        
        let beforeTitleLabel = titleLabelList[currentSelectLabelIndex]
        beforeTitleLabel.textColor = UIColor(displayP3Red: kTitleLabelWithNormalColor.0, green: kTitleLabelWithNormalColor.1, blue: kTitleLabelWithNormalColor.2)

        currentTitleLabel.textColor = UIColor(displayP3Red: kTitleLabelWithSelectColor.0, green: kTitleLabelWithSelectColor.1, blue: kTitleLabelWithSelectColor.2)
        
        currentSelectLabelIndex = currentTitleLabel.tag
        
        let titleLabelWithBottomLineViewX = CGFloat(currentSelectLabelIndex) * currentTitleLabel.frame.width
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.titleLabelWithBottomLineViews.frame.origin.x = titleLabelWithBottomLineViewX
        }
        // 通知代理
        delegate?.pageTitleView(self, currentSelIndex: currentSelectLabelIndex)

    }
}

// MARK: - 设置滚动信息（对外暴露方法，进行设值）
extension MQPageTitleView{
    func setPageTitleViewWithScroll(_ progress: CGFloat,startIndex: Int,endIndex: Int) {
     
        let startLabel = titleLabelList[startIndex]
        let endLabel = titleLabelList[endIndex]
        
        let moveTotalX = endLabel.frame.origin.x - startLabel.frame.origin.x
        let moveX = moveTotalX * progress
        titleLabelWithBottomLineViews.frame.origin.x = startLabel.frame.origin.x + moveX
        
        let colorDelta = (kTitleLabelWithSelectColor.0 - kTitleLabelWithNormalColor.0,kTitleLabelWithSelectColor.1 - kTitleLabelWithNormalColor.1,kTitleLabelWithSelectColor.2 - kTitleLabelWithNormalColor.2)
        
        startLabel.textColor = UIColor(displayP3Red: kTitleLabelWithSelectColor.0-colorDelta.0 * progress, green: kTitleLabelWithSelectColor.1-colorDelta.1 * progress, blue: kTitleLabelWithSelectColor.2-colorDelta.2 * progress)
        endLabel.textColor = UIColor(displayP3Red: kTitleLabelWithNormalColor.0+colorDelta.0 * progress, green: kTitleLabelWithNormalColor.1+colorDelta.1 * progress, blue: kTitleLabelWithNormalColor.2+colorDelta.2 * progress)
        
        // 记录最新的Index
        currentSelectLabelIndex = endIndex
    }
}
