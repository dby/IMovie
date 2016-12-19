//
//  MovieViewCell.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class MovieViewCell: UICollectionViewCell, Reusable {
    
    class func cellWithCollectionView(_ collectionView: UICollectionView, indexPath: IndexPath) -> MovieViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as? MovieViewCell
        
        if cell == nil {
            cell = MovieViewCell()
        }
        return cell!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(moviePoster)
        addSubview(movieLabel)
        addSubview(ratingLabel)
        addSubview(ratingBar)
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--- Private Method ---
    func setupLayout() {
        moviePoster.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.height.equalTo(MovieViewConstant.IMAGE_HEIGHT)
            make.width.equalTo(MovieViewConstant.IMAGE_WIDTH)
        }
        
        movieLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.moviePoster.snp.bottom)
            make.height.equalTo(MovieInfoConstant.TitleHeight)
        }
        
        ratingBar.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.movieLabel.snp.bottom)
            make.height.equalTo(MovieInfoConstant.RatingHeight)
            make.width.equalTo(80)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.ratingBar.snp.right).offset(2)
            make.right.equalTo(self.contentView)
            make.top.equalTo(self.movieLabel.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    //MARK:--- Getter or Setter ---
    var model: MovieModel! {
        didSet {
            if model.rating != nil {
                self.ratingLabel.text = String(format: "%.2f", model.rating.value)
                self.ratingBar.rating = CGFloat(model.rating.value/2.0)
            }
            
            self.movieLabel.text  = model.title
                
            let strs:[String] = model.cover.url.components(separatedBy: "?")

            self.moviePoster.if_setImage(URL(string: strs[0]))
        }
    }
    
    fileprivate lazy var moviePoster: UIImageView = {
        let moviePoster: UIImageView = UIImageView()
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.clipsToBounds = true;
        return moviePoster
    }()
    
    fileprivate lazy var movieLabel: UILabel = {
        let movieLabel: UILabel = UILabel()
        movieLabel.font = FontConstant.SYS_16
        //movieLabel.backgroundColor = UIColor.red
        return movieLabel
    }()
    
    fileprivate lazy var ratingBar: RatingBar = {
        let ratingBar: RatingBar = RatingBar()
        return ratingBar
    }()
    
    fileprivate lazy var ratingLabel: UILabel = {
        let ratingLabel: UILabel = UILabel()
        ratingLabel.font = FontConstant.SYS_14
        //ratingLabel.backgroundColor = UIColor.purple
        return ratingLabel
    }()
}
