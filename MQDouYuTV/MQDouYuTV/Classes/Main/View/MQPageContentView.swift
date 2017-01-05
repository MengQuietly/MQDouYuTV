//
//  MQPageContentView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/9/23.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  Home PageContentView

import UIKit

private let kPageContentCollectionCellID = "PageContentCollectionCellID"
// MARK:- 定义代理，传递滚动信息(“:class” 表此协议只能被类遵守)
protocol MQPageContentViewDelegate: class {
    func pageContentViewWithSetScroll(_ contentView:MQPageContentView,progress: CGFloat,startIndex: Int,endIndex: Int)
}

// MARK:- MQPageContentView
class MQPageContentView: UIView {
    
    // MARK:- 定义属性
    fileprivate var childVCList:[UIViewController] = [UIViewController]()
    fileprivate weak var parentVC: UIViewController? // weak 修饰可选链
    fileprivate var startContentOffSetX:CGFloat = 0 // 开始滑动的OffsetX]
    fileprivate var isForbidScrollDelegate: Bool = false // 禁止scrollView滚动
    weak var pageContentViewDelegate : MQPageContentViewDelegate?

    // MARK:- 懒加载数据
    fileprivate lazy var contentCollectionViews: UICollectionView = {[weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = (self?.bounds.size)!
        
        let contentCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        contentCollectionView.showsHorizontalScrollIndicator = false
        contentCollectionView.bounces = false
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kPageContentCollectionCellID)
        return contentCollectionView
    }()
    
    init(frame: CGRect,childVCList: [UIViewController], parentVC: UIViewController?) {
        super.init(frame: frame)
        self.childVCList = childVCList
        self.parentVC = parentVC
        
        // 设置 UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置布局
extension MQPageContentView {
    
    fileprivate func setupUI() {
        for child in childVCList {
            child.view.frame = bounds
            parentVC?.addChildViewController(child)
        }
        contentCollectionViews.frame = bounds
        addSubview(contentCollectionViews)
    }
}

// MARK: - UICollectionViewDataSource
extension MQPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPageContentCollectionCellID, for: indexPath)
        for cellSubViews in cell.contentView.subviews {
            cellSubViews.removeFromSuperview()
        }
        
        let childvc = childVCList[indexPath.item]
        cell.contentView.addSubview(childvc.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MQPageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startContentOffSetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 判断是否为点击事件
        if isForbidScrollDelegate { return }
        
        let currentContentOfSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        // 设置需要的属性
        var progress:CGFloat = 0
        var startIndex:Int = 0
        var endIndex:Int = 0
        
        if currentContentOfSetX > startContentOffSetX {
             progress = currentContentOfSetX / scrollViewW - floor(currentContentOfSetX / scrollViewW)
            startIndex = (Int)(currentContentOfSetX/scrollViewW)
            endIndex = startIndex + 1
            if endIndex >= childVCList.count {
                endIndex = childVCList.count - 1
            }
            if currentContentOfSetX - startContentOffSetX == scrollViewW {
                progress = 1
                endIndex = startIndex
            }
//            MQLog("左滑 startIndex=\(startIndex),endIndex=\(endIndex)")
            
        } else {
            progress = 1 - (currentContentOfSetX / scrollViewW - floor(currentContentOfSetX / scrollViewW))
            endIndex = (Int)(currentContentOfSetX/scrollViewW)
            startIndex = endIndex + 1
//            MQLog("右滑 startIndex=\(startIndex),endIndex=\(endIndex)")
        }
        
        // 传递滚动信息
//        MQLog("progress=\(progress)，StartIndex=\(startIndex),endIndex=\(endIndex)")
        pageContentViewDelegate?.pageContentViewWithSetScroll(self, progress: progress, startIndex: startIndex, endIndex: endIndex)
    }
}

// MARK: - 对外暴露的方法
extension MQPageContentView{
    func setCurrentIndex(_ currentIndex: Int){
        // 记录需禁止执行代理方法
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * contentCollectionViews.frame.width
        contentCollectionViews.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
}
