//
//  MQRecommendController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/19.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendController 推荐界面

import UIKit

private let kPrettyScoreItemH : CGFloat = kBaseAnchorItemW * 4 / 3
private let kRecommendBannerViewH : CGFloat = kScreenW * 3 / 8
private let kRecommendGameViewH : CGFloat = 90
private let kRecommendBannerViewY : CGFloat = kRecommendBannerViewH + kRecommendGameViewH

class MQRecommendController: MQBaseAnchorController {

    fileprivate lazy var recommentViewModel = MQRecommentViewModel()
    
    // banner
    fileprivate lazy var bannerViews: MQRecommendBannerView = {
        let bannerViews = MQRecommendBannerView.recommendBannerView()
        bannerViews.frame = CGRect(x: 0, y: (-kRecommendBannerViewY), width: kScreenW, height: kRecommendBannerViewH)
        return bannerViews
    }()
    
    fileprivate lazy var gameViews: MQRecommendGameView = {
        let gameViews = MQRecommendGameView.recommendGemeView()
        gameViews.frame = CGRect(x: 0, y: -kRecommendGameViewH, width: kScreenW, height: kRecommendGameViewH)
        return gameViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - 设置UI界面
extension MQRecommendController{
    override func setupUI(){
        super.setupUI()
        collectionViews.delegate = self
        collectionViews.addSubview(bannerViews)
        collectionViews.addSubview(gameViews)
        collectionViews.contentInset = UIEdgeInsets(top: kRecommendBannerViewY, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - 实现代理方法
extension MQRecommendController: UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionNum = self.recommentViewModel.anchorGroupList[indexPath.section]
        let anchor = sectionNum.anchorList[indexPath.item]
        
        var cell: MQRecommendBaseCell!
        if indexPath.section == 1 {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kBaseAnchorPrettyScoreCellID, for: indexPath) as! MQPrettyScoreCell
            cell.anchorModel = anchor
            return cell
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kBaseAnchorItemW, height: kPrettyScoreItemH)
        }
        return CGSize(width: kBaseAnchorItemW, height: kBaseAnchorItemH)
    }
}

// MARK:- 推荐首页：网络请求
extension MQRecommendController{
    override func getBaseAnchorListData() {
        
        baseAnchorViewModel = recommentViewModel
        
        // 获取banner列表数据
        recommentViewModel.getBannerListData { [unowned self] in
            self.bannerViews.bannerModelList = self.recommentViewModel.bannerLists
        }
        
        // 获取热门房间列表数据
        recommentViewModel.getRoomGroupListData { [unowned self] in
    
            self.collectionViews.reloadData()
            
            var gameList = self.recommentViewModel.anchorGroupList
            gameList.removeFirst()
            gameList.removeFirst()
            let moreGame = MQAnchorGroupModel()
            moreGame.tag_name = "更多"
            moreGame.icon_url = "home_more_btn"
            gameList.append(moreGame)
            
            self.gameViews.gameList = gameList
        }
    }
}
