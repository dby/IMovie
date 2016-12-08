//
//  FilmTableCell.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

class FilmTableViewCell: UITableViewCell, Reusable {
    
    class func cellWithTableView(_ tableView: UITableView) -> FilmTableViewCell {
        var cell = tableView.dequeueReusableCell() as FilmTableViewCell?
        if cell == nil {
            cell = FilmTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dataCollectionView.tag = self.tag
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(moreButton)
        self.contentView.addSubview(dataCollectionView)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Private Method ---
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(self.contentView)
            make.height.equalTo(30)
            make.width.equalTo(150)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        dataCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(MovieConstant.IMAGE_HEIGHT + MovieConstant.MovieTitleHeight + MovieConstant.MovieRatingHeight)
        }
    }
    
    //MARK: --- Getter and Setter ---
    public var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        return titleLabel
    }()
    
    public var moreButton: UIButton = {
        let moreButton: UIButton = UIButton()
        moreButton.setTitle("查看全部", for: .normal)
        moreButton.setTitleColor(UIColor.darkGray, for: .normal)
        return moreButton
    }()
    
    public var dataCollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        let dataCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        dataCollectionView.bounces = false
        dataCollectionView.isPagingEnabled = false
        dataCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
        dataCollectionView.backgroundColor = UIColor.white

        return dataCollectionView
    }()
}
