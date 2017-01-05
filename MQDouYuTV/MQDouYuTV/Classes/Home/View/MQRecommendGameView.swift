//
//  MQRecommendGameView.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/29.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  推荐界面：游戏view

import UIKit

let kMQRecommendGameCell = "kMQRecommendGameCell"
let kMQGameCollectionViewsWithEdgeInsetMargin : CGFloat = 15

class MQRecommendGameView: UIView {
    
    // MARK: - 控件属性
    @IBOutlet weak var gameCollectionViews: UICollectionView!
    
    // MARK:-定义模型数组属性
    var gameList : [MQBaseGameModel]?{
        didSet {
            gameCollectionViews.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        gameCollectionViews.register(UINib(nibName: "MQRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kMQRecommendGameCell)
        gameCollectionViews.contentInset = UIEdgeInsets(top: 0, left: kMQGameCollectionViewsWithEdgeInsetMargin, bottom: 0, right: kMQGameCollectionViewsWithEdgeInsetMargin)
        gameCollectionViews.showsHorizontalScrollIndicator = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = gameCollectionViews.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 90, height: 90)
    }
}

// MARK: - 快速创建View
extension MQRecommendGameView {
    class func recommendGemeView()->MQRecommendGameView{
        return Bundle.main.loadNibNamed("MQRecommendGameView", owner: nil, options: nil)?.first as! MQRecommendGameView
    }
}

// MARK:- 
extension MQRecommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMQRecommendGameCell, for: indexPath) as! MQRecommendGameCell
        cell.baseGameModel = self.gameList?[indexPath.item]
        
        return cell
    }
}
