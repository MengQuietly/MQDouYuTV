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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseTopMenuBGCellID, for: indexPath) as! MQAmuseTopMenuCell
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
