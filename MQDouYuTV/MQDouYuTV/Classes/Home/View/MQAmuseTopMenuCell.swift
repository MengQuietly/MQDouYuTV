//
//  MQAmuseTopMenuCell.swift
//  MQDouYuTV
//
//  Created by mengmeng on 17/1/17.
//  Copyright © 2017年 mengQuietly. All rights reserved.
//

import UIKit

private let kAmuseTopMenuWithGameCellID = "kAmuseTopMenuWithGameCellID"

class MQAmuseTopMenuCell: UICollectionViewCell {

    var anchorGroupModelList: [MQAnchorGroupModel]? {
        didSet {
            amuseTopMenuCollection.reloadData()
        }
    }
    @IBOutlet weak var amuseTopMenuCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        amuseTopMenuCollection.register(UINib(nibName: "MQRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kAmuseTopMenuWithGameCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = amuseTopMenuCollection.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = self.bounds.width / 4
        let itemH:CGFloat = self.bounds.height / 2
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension MQAmuseTopMenuCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroupModelList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseTopMenuWithGameCellID, for: indexPath) as! MQRecommendGameCell
        cell.clipsToBounds = true // cell 不展示 BottomLine
        cell.baseGameModel = anchorGroupModelList![indexPath.item]
        return cell
    }
}
