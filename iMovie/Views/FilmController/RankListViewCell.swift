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
        self.contentView.addSubview(image1)
        self.contentView.addSubview(image2)
        self.contentView.addSubview(image3)
        
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        
        let smallWidth: CGFloat = self.width / 3.0
        let bigWidth: CGFloat   = self.width - smallWidth
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self.contentView)
            make.height.equalTo(30)
        }
        
        image1.snp.makeConstraints({ (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self.contentView)
            make.width.height.equalTo(bigWidth)
        })
            
        image2.snp.makeConstraints({ (make) in
            make.left.equalTo(image1.snp.right)
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.width.equalTo(smallWidth)
        })
            
        image3.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView)
            make.top.equalTo(image2.snp.bottom)
            make.width.height.equalTo(smallWidth)
        })
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
            }
        }
    }
    
    public lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        //titleLabel.backgroundColor = UIColor.green
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 20)
        return titleLabel
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
