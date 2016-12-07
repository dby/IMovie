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
        
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:--- Private Method ---
    func setupLayout() {
        moviePoster.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView)
            make.height.equalTo(UIConstant.IMAGE_HEIGHT)
            make.width.equalTo(UIConstant.IMAGE_WIDTH)
        }
        
        movieLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.moviePoster.snp.bottom)
            make.height.equalTo(30)
        }
        
        ratingLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(self.movieLabel.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    //MARK:--- Getter or Setter ---
    var model: MovieModel! {
        didSet {
            do {
                self.ratingLabel.text = String(model.rating.value)
                self.movieLabel.text  = model.title
                
                let strs:[String] = model.cover.url.components(separatedBy: "?")
                let data = try Data(contentsOf: URL.init(string: strs[0])!)
                let newImage = UIImage(data: data)
                
                self.moviePoster.image = newImage
                
            } catch {
                debugPrint("ERROR ERROR")
            }
        }
    }
    
    fileprivate lazy var moviePoster: UIImageView = {
        let moviePoster: UIImageView = UIImageView(image: UIImage(named: "ic_about"))
        moviePoster.backgroundColor = UIColor.cyan
        return moviePoster
    }()
    
    fileprivate lazy var movieLabel: UILabel = {
        let movieLabel: UILabel = UILabel()
        return movieLabel
    }()
    
    fileprivate lazy var ratingLabel: UILabel = {
        let ratingLabel: UILabel = UILabel()
        return ratingLabel
    }()
}
