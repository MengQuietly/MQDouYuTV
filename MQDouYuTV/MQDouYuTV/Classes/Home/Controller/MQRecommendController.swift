//
//  MQRecommendController.swift
//  MQDouYuTV
//
//  Created by mengmeng on 16/12/19.
//  Copyright © 2016年 mengQuietly. All rights reserved.
//  MQRecommendController 推荐界面

import UIKit

private let kItemMarginW : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - kItemMarginW * 3) * 0.5
private let kItemH : CGFloat = kItemW * 3 / 4
private let kPrettyScoreItemH : CGFloat = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kPrettyScoreCellID = "kPrettyScoreCellID"

class MQRecommendController: UIViewController {

    // MARK: 懒加载 collectionView
    lazy var collectionViews: UICollectionView = { [unowned self] in

        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMarginW
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMarginW, bottom: 0, right: kItemMarginW)
        
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionViews = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionViews.backgroundColor = UIColor.white
        collectionViews.dataSource = self
        collectionViews.delegate = self
        // 相对于父控件宽高不变
        collectionViews.autoresizingMask = [UIViewAutoresizing.flexibleHeight,UIViewAutoresizing.flexibleWidth]
        // 注册cell
//        collectionViews.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
//        collectionViews.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionViews.register(UINib(nibName: "MQRecommendHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionViews.register(UINib(nibName: "MQRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionViews.register(UINib(nibName:"MQPrettyScoreCell", bundle: nil), forCellWithReuseIdentifier: kPrettyScoreCellID)
    
        return collectionViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getRecommentListData()
    }
}

// MARK: - 设置UI界面
extension MQRecommendController{
    func setupUI(){
        view.addSubview(collectionViews)
//        collectionViews.register(UINib(nibName:"MQPrettyScoreCell", bundle: nil), forCellWithReuseIdentifier: kPrettyScoreCellID)
    }
}

// MARK: - 实现代理方法
extension MQRecommendController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifierID: String = String()
        if indexPath.section == 1 {
            identifierID = kPrettyScoreCellID
        } else {
            identifierID = kNormalCellID
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierID, for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerViews = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        headerViews.backgroundColor = UIColor.white
        return headerViews
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kPrettyScoreItemH)
        }
        return CGSize(width: kItemW, height: kItemH)
    }
}

// MARK:- 网络请求
extension MQRecommendController{
    func getRecommentListData(){
        let url = "https://httpbin.org/post"

        MQNetworkingTool.requestData(type: MQMethodType.POST, url: url) { (responseObject:AnyObject) in
            print("MG responseObject = \(responseObject)")
        }
        
        MQNetworkingTool.sendRequest(type: MQMethodType.POST, url: url, succeed: { (responseObject:[String : AnyObject]?, badNet:Bool) -> ()? in
            print("responseObject=\(responseObject),badNet=\(badNet)")
            
        }) { (error:NSError?, badNet:Bool) -> ()? in
                print("error=\(error),badNet=\(badNet)")
        }
    }
}
