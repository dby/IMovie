//
//  FilmTableCell.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

class MovieInfoView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        self.addSubview(dataCollectionView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Private Method ---
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(150)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-1 * MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(100)
        }
        dataCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight)
        }
    }
    
    //MARK: --- Getter and Setter ---
    public var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        //titleLabel.backgroundColor = UIColor.green
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 20)
        return titleLabel
    }()
    
    public var moreButton: UIButton = {
        let moreButton: UIButton = UIButton()
        moreButton.setTitle("查看全部>", for: .normal)
        moreButton.setTitleColor(UIColor.darkGray, for: .normal)
        moreButton.contentHorizontalAlignment = .right
        //moreButton.backgroundColor = UIColor.brown
        moreButton.titleLabel?.font = FontConstant.SYS_14
        return moreButton
    }()
    
    public var dataCollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, MovieConstant.LeftEdge, 0, MovieConstant.LeftEdge)
        
        let dataCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        dataCollectionView.bounces = false
        dataCollectionView.isPagingEnabled = false
        dataCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: String(describing: MovieViewCell.self))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self))
        dataCollectionView.backgroundColor = UIColor.white

        return dataCollectionView
    }()
}
