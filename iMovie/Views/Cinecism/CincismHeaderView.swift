//
//  CincismHeaderView.swift
//  iMovie
//
//  Created by sys on 2016/12/16.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class CincismHeaderView: UIImageView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        
        self.addSubview(self.moviePosterImage)
        self.addSubview(self.movieNameLabel)
        self.addSubview(self.movieRatingLabel)
        self.addSubview(self.movieInfoLabel)
        
        headerViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARKL:---Private Methods---
    //MARK:---Getter and Setter---
    var model: DetailCincismModel! {
        didSet {
            self.movieNameLabel.text = model.subject.title
            self.movieRatingLabel.text = String(model.rating.value)
            self.movieInfoLabel.text = getMovieActorsInfo(model: model)
                        
            let strs:[String] = model.subject.pic.normal.components(separatedBy: "?")
            self.moviePosterImage.if_setImage(URL(string: strs[0]))
            self.if_setImage(URL(string: strs[0]))
        }
    }

    // 获得 “导演/演员” 的字符串
    func getMovieActorsInfo(model: DetailCincismModel) -> String {
        var str: String = ""
        
        for item in model.subject.directors {
            str = str.appending(item).appending("/")
        }
        
        for item in model.subject.actors {
            str = str.appending(item).appending("/")
        }
        
        if !(str.isEmpty) {
            
        }
        
        return str
    }

    func headerViewLayout() {
        //
        self.moviePosterImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.top.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-20)
            make.width.equalTo(self.moviePosterImage.snp.height).multipliedBy(0.6666667)
        }
        self.movieRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.moviePosterImage.snp.centerY)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
        self.movieNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.movieRatingLabel.snp.top)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
        self.movieInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.movieRatingLabel.snp.bottom)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.height.equalTo(30)
        }
    }

    //MARK:---Getter and Setter---
    // 海报
    internal lazy var moviePosterImage: UIImageView = {
        let moviePosterImage: UIImageView = UIImageView()
        moviePosterImage.contentMode = .scaleAspectFill
        moviePosterImage.clipsToBounds = true
        //moviePosterImage.backgroundColor = UIColor.yellow
        return moviePosterImage
    }()
    // 电影名称
    internal lazy var movieNameLabel: UILabel = {
        let movieNameLabel: UILabel = UILabel()
        movieNameLabel.textColor = UIColor.white
        //movieNameLabel.backgroundColor = UIColor.red
        movieNameLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 18)
        return movieNameLabel
    }()
    // 电影评分
    internal lazy var movieRatingLabel: UILabel = {
        let movieRatingLabel: UILabel = UILabel()
        movieRatingLabel.textColor = UIColor.white
        //movieRatingLabel.backgroundColor = UIColor.orange
        movieRatingLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 15)
        return movieRatingLabel
    }()
    // movieInfoLabel 导演/演员信息
    internal lazy var movieInfoLabel: UILabel = {
        let movieInfoLabel: UILabel = UILabel()
        movieInfoLabel.textColor = UIColor.white
        //movieInfoLabel.backgroundColor = UIColor.brown
        movieInfoLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 13)
        return movieInfoLabel
    }()
}
