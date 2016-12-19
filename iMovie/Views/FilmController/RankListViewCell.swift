//
//  RankListViewCell.swift
//  iMovie
//
//  Created by sys on 2016/12/18.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class RankListViewCell: UICollectionViewCell, Reusable {
    
    class func cellWithCollectionView(_ collectionView: UICollectionView, indexPath: IndexPath) -> RankListViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? RankListViewCell
        if cell == nil {
            cell = RankListViewCell()
        }
        
        cell?.initUI()
        return cell!
    }
    
    //MARK:---Private Method---
    func initUI() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtileLabel)
        self.contentView.addSubview(image1)
        self.contentView.addSubview(image2)
        self.contentView.addSubview(image3)
        
        self.contentView.layer.cornerRadius = 5
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        
        let image1Width: CGFloat  = self.width/3.0
        let image1Height: CGFloat = image1Width * 2993.0 / 2000.0
        let image2Width: CGFloat  = image1Width - 10
        let image2Height: CGFloat = image2Width * 2993.0 / 2000.0
        
        self.image1.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.contentView.snp.centerX)
            make.bottom.equalTo(self.contentView).offset(-5)
            make.width.equalTo(image1Width)
            make.height.equalTo(image1Height)
        }
        
        self.image2.snp.makeConstraints { (make) in
            make.right.equalTo(self.image1.snp.left)
            make.width.equalTo(image2Width)
            make.height.equalTo(image2Height)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        
        self.image3.snp.makeConstraints { (make) in
            make.left.equalTo(self.image1.snp.right)
            make.width.equalTo(image2Width)
            make.height.equalTo(image2Height)
            make.bottom.equalTo(self.contentView).offset(-10)
        }
        self.subtileLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.image1.snp.top).offset(-5)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(20)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.subtileLabel.snp.top).offset(-5)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.subtileLabel.snp.top).offset(-5)
        }
    }
    
    //MARK:---Getter or Setter---
    var model: SelectedCollectionModel! {
        didSet {
            if model.covers.count == 3 {
                let str0s:[String] = model.covers[0].components(separatedBy: "?")
                image1.if_setImage(URL(string: str0s[0]))
                
                let str1s:[String] = model.covers[1].components(separatedBy: "?")
                image2.if_setImage(URL(string: str1s[0]))

                let str2s:[String] = model.covers[2].components(separatedBy: "?")
                image3.if_setImage(URL(string: str2s[0]))
                
                titleLabel.text = model.name
                subtileLabel.text = model.description
                
                self.contentView.backgroundColor = UIColor.colorWithHexString(hex: model.background_color)
            }
        }
    }
    
    public lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        //titleLabel.backgroundColor = UIColor.green
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    public lazy var subtileLabel: UILabel = {
        let subtitleLabel: UILabel = UILabel()
        //subtitleLabel.backgroundColor = UIColor.red
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        return subtitleLabel
    }()
    
    fileprivate lazy var image1: UIImageView = {
        let image1: UIImageView = UIImageView()
        image1.backgroundColor = UIColor.red
        image1.contentMode = .scaleAspectFill
        image1.clipsToBounds = true
        return image1
    }()
    
    fileprivate lazy var image2: UIImageView = {
        let image2: UIImageView = UIImageView()
        image2.backgroundColor = UIColor.orange
        image2.contentMode = .scaleAspectFill
        image2.clipsToBounds = true
        return image2
    }()
    
    fileprivate lazy var image3: UIImageView = {
        let image3: UIImageView = UIImageView()
        image3.backgroundColor = UIColor.yellow
        image3.contentMode = .scaleAspectFill
        image3.clipsToBounds = true
        return image3
    }()

}
