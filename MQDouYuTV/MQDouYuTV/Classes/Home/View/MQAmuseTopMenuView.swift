//
//  MQAmuseTopMenuView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/17.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//

import UIKit

/// bgCell
private let kAmuseTopMenuBGCellID = "kAmuseTopMenuBGCellID"

class MQAmuseTopMenuView: UIView {
    
    var groupModelList: [MQAnchorGroupModel]? {
        didSet {
            amuseTopMenuBgCollectionView.reloadData()
        }
    }

    @IBOutlet weak var amuseTopMenuBgCollectionView: UICollectionView!
    @IBOutlet weak var amuseTopMenuPageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        amuseTopMenuBgCollectionView.register(UINib(nibName: "MQAmuseTopMenuCell", bundle: nil), forCellWithReuseIdentifier: kAmuseTopMenuBGCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = amuseTopMenuBgCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = amuseTopMenuBgCollectionView.bounds.size
    }
}

// MARK:-快速实现View
extension MQAmuseTopMenuView {
    class func amuseTopMenuView() -> MQAmuseTopMenuView {
        return Bundle.main.loadNibNamed("MQAmuseTopMenuView", owner: nil, options: nil)?.first as! MQAmuseTopMenuView
    }
}

// MARK:- 实现代理
extension MQAmuseTopMenuView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groupModelList == nil { return 0 }
        let pageNum = (groupModelList!.count - 1) / 8 + 1
        print("count = \(groupModelList!.count)")
        amuseTopMenuPageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseTopMenuBGCellID, for: indexPath) as! MQAmuseTopMenuCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    // 设置cell 数据
    private func setupCellDataWithCell(cell: MQAmuseTopMenuCell, indexPath: IndexPath) {
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        // 判断越界
        if endIndex > groupModelList!.count - 1 {
            endIndex = groupModelList!.count - 1
        }
        cell.anchorGroupModelList = Array(groupModelList![startIndex ... endIndex])
    }
}

// MARK: - UICollectionViewDelegate
extension MQAmuseTopMenuView:UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        amuseTopMenuPageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}

