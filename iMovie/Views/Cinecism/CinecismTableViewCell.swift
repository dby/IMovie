//
//  CinecismTableViewCell.swift
//  iMovie
//
//  Created by sys on 2016/12/10.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class CinecismTableViewCell: UITableViewCell, Reusable {
    
    class func cellWithTableView(_ tableView : UITableView) -> CinecismTableViewCell {
        
        var cell: CinecismTableViewCell? = tableView.dequeueReusableCell() as CinecismTableViewCell?
        if cell == nil {
            cell = CinecismTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.headerView.addSubview(self.movieNameLabel)
        self.headerView.addSubview(self.moviePosterImage)
        self.headerView.addSubview(self.movieRatingLabel)
        self.headerView.addSubview(self.movieInfoLabel)
        
        self.contentView.addSubview(self.headerView)
        self.contentView.addSubview(self.cincismInfoLabel)
        self.contentView.addSubview(self.cincismTitleLabel)
        self.contentView.addSubview(self.cincismBriefLabel)
        self.contentView.addSubview(self.separateLineView)
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARKL:---Private Methods---
    func headerViewLayout() {
        //
        self.moviePosterImage.snp.makeConstraints { (make) in
            make.left.equalTo(self.headerView).offset(30)
            make.top.equalTo(self.headerView).offset(20)
            make.bottom.equalTo(self.headerView).offset(-20)
            make.width.equalTo(self.moviePosterImage.snp.height).multipliedBy(0.6666667)
        }
        self.movieRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.moviePosterImage.snp.centerY)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(20)
            make.right.equalTo(self.headerView).offset(-30)
            make.height.equalTo(30)
        }
        self.movieNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.movieRatingLabel.snp.top).offset(-5)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(20)
            make.right.equalTo(self.headerView).offset(-30)
            make.height.equalTo(30)
        }
        self.movieInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.movieRatingLabel.snp.bottom).offset(5)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(20)
            make.right.equalTo(self.headerView).offset(-30)
            make.height.equalTo(30)
        }
        self.separateLineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-UIConstant.UI_MARGIN_5)
            make.centerX.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(2)
        }
    }
    
    func layout() {
        
        headerViewLayout()
        
        self.headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(UIConstant.SCREEN_WIDTH / 2)
        }
        self.cincismInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.height.equalTo(20)
        }
        self.cincismTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cincismInfoLabel.snp.bottom).offset(3)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.height.equalTo(30)
        }
        self.cincismBriefLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cincismTitleLabel.snp.bottom).offset(3)
            make.left.equalTo(self.contentView).offset(15)
            make.right.equalTo(self.contentView).offset(-15)
            make.height.equalTo(50)
        }
    }
    
    func getMovieActorsInfo(model: ReviewModel) -> String {
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
    
    //MARK:---Getter and Setter---
    var model: ReviewModel! {
        didSet {
            self.movieNameLabel.text = model.subject.title
            self.movieRatingLabel.text = String(model.rating.value)
            self.movieInfoLabel.text = getMovieActorsInfo(model: model)
            
            self.cincismInfoLabel.text = model.user.name.appending("评价了").appending(model.subject.title)
            self.cincismTitleLabel.text = model.title
            self.cincismBriefLabel.text = model.abstract
            
            let strs:[String] = model.subject.pic.normal.components(separatedBy: "?")
            self.moviePosterImage.if_setImage(URL(string: strs[0]))
        }
    }
    // 海报
    internal lazy var moviePosterImage: UIImageView = {
        let moviePosterImage: UIImageView = UIImageView()
        moviePosterImage.contentMode = .scaleAspectFill
        moviePosterImage.clipsToBounds = true
        moviePosterImage.backgroundColor = UIColor.yellow
        return moviePosterImage
    }()
    // 电影名称
    internal lazy var movieNameLabel: UILabel = {
        let movieNameLabel: UILabel = UILabel()
        movieNameLabel.backgroundColor = UIColor.red
        movieNameLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 16)
        return movieNameLabel
    }()
    // 电影评分
    internal lazy var movieRatingLabel: UILabel = {
        let movieRatingLabel: UILabel = UILabel()
        movieRatingLabel.backgroundColor = UIColor.orange
        movieRatingLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 15)
        return movieRatingLabel
    }()
    // movieInfoLabel
    internal lazy var movieInfoLabel: UILabel = {
        let movieInfoLabel: UILabel = UILabel()
        movieInfoLabel.backgroundColor = UIColor.brown
        movieInfoLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 15)
        return movieInfoLabel
    }()
    // headView
    internal lazy var headerView: UIView = {
        let headerView: UIView = UIView()
        headerView.backgroundColor = UIColor.purple
        return headerView
    }()
    // cincism info 谁评价的电影
    internal lazy var cincismInfoLabel: UILabel = {
        let cincismInfoLabel: UILabel = UILabel()
        cincismInfoLabel.backgroundColor = UIColor.cyan
        cincismInfoLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 11)
        cincismInfoLabel.textColor = UIColor.darkGray
        return cincismInfoLabel
    }()
    // cincism title
    internal lazy var cincismTitleLabel: UILabel = {
        let cincismTitleLabel = UILabel()
        cincismTitleLabel.backgroundColor = UIColor.blue
        cincismTitleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 14)
        return cincismTitleLabel
    }()
    // cincism brief
    internal lazy var cincismBriefLabel: UILabel = {
        let cincismBriefLabel: UILabel = UILabel()
        cincismBriefLabel.backgroundColor = UIColor.green
        cincismBriefLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 14)
        cincismBriefLabel.numberOfLines = 0
        return cincismBriefLabel
    }()
    // 小黄线
    fileprivate lazy var separateLineView: UIView = {
        let separateLineView = UIView()
        separateLineView.backgroundColor = UIColor.brown
        return separateLineView
    }()
}
