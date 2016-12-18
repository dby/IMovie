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
        self.headerView.addSubview(self.movieRatingBar)
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
            make.left.equalTo(self.headerView).offset(20)
            make.top.equalTo(self.headerView).offset(20)
            make.bottom.equalTo(self.headerView).offset(-20)
            make.width.equalTo(self.moviePosterImage.snp.height).multipliedBy(0.6666667)
        }
        self.movieRatingBar.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.moviePosterImage.snp.centerY)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        self.movieRatingLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.moviePosterImage.snp.centerY)
            make.left.equalTo(self.movieRatingBar.snp.right).offset(5)
            make.right.equalTo(self.headerView).offset(-20)
            make.height.equalTo(30)
        }
        self.movieNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.movieRatingLabel.snp.top)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(10)
            make.right.equalTo(self.headerView).offset(-20)
            make.height.equalTo(30)
        }
        self.movieInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.movieRatingLabel.snp.bottom)
            make.left.equalTo(self.moviePosterImage.snp.right).offset(10)
            make.right.equalTo(self.headerView).offset(-20)
            make.height.equalTo(30)
        }
    }
    
    func layout() {
        
        headerViewLayout()
        
        self.headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.top.equalTo(self.contentView).offset(10)
            make.height.equalTo(UIConstant.SCREEN_WIDTH / 2)
        }
        self.cincismInfoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp.bottom)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(20)
        }
        self.cincismTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cincismInfoLabel.snp.bottom)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(30)
        }
        self.cincismBriefLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.cincismTitleLabel.snp.bottom)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.bottom.equalTo(self.separateLineView.snp.top).offset(-30)
        }
        self.separateLineView.snp.makeConstraints { (make) in
            make.bottom.centerX.equalTo(self)
            make.width.equalTo(30)
            make.height.equalTo(2)
        }
    }
    
    // 计算CincismTableViewCell Height
    class func estimateCellHeight(_ content : String, font: UIFont) -> CGFloat {
        
        let size    = CGSize(width: UIConstant.SCREEN_WIDTH - 30, height: 2000)
        let attrs   = NSMutableAttributedString(string: content)
        let paragphStyle = NSMutableParagraphStyle()
        
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;
        
        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]
        
        
        attrs.addAttribute(NSFontAttributeName,
                           value: font,
                           range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSParagraphStyleAttributeName, value: paragphStyle, range: NSMakeRange(0, (content.characters.count)))
        attrs.addAttribute(NSKernAttributeName, value: 1.0, range: NSMakeRange(0, (content.characters.count)))
        
        let labelRect : CGRect = content.boundingRect(with: size,
                                                      options: .usesLineFragmentOrigin,
                                                      attributes: dic as [String : AnyObject],
                                                      context: nil)
        
        // 96: 其他控件的高度 + 间隔
        return UIConstant.SCREEN_WIDTH/2 + 90 + labelRect.height
    }
    
    // 获得 “导演/演员” 的字符串
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
            let ratingNum: CGFloat = CGFloat(model.subject.rating.value * Double(10) / Double(model.subject.rating.max))

            self.movieNameLabel.text   = model.subject.title
            self.movieRatingBar.rating = ratingNum/2.0
            self.movieRatingLabel.text = String(format: "%.2f", ratingNum)
            self.movieInfoLabel.text   = getMovieActorsInfo(model: model)
            
            self.cincismInfoLabel.text  = model.user.name.appending(" 评论 《").appending(model.subject.title).appending("》")
            self.cincismTitleLabel.text = model.title
            self.cincismBriefLabel.attributedText = UILabel.setAttributText(model.abstract, lineSpcae: 5.0)
            
            let strs:[String] = model.subject.pic.normal.components(separatedBy: "?")
            self.moviePosterImage.if_setImage(URL(string: strs[0]))
            self.headerView.if_setImage(URL(string: strs[0]))
        }
    }
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
    // 电影RatingBar
    internal lazy var movieRatingBar: RatingBar = {
        let movieRatingBar: RatingBar = RatingBar()
        
        return movieRatingBar
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
    // headView
    internal lazy var headerView: UIImageView = {
        let headerView: UIImageView = UIImageView()
        headerView.contentMode = .scaleAspectFill
        headerView.clipsToBounds = true
        //headerView.backgroundColor = UIColor.purple
        //headerView.backgroundColor = UIColor(patternImage: UIImage(named: "live_background")!)
        headerView.image =  UIImage(named: "live_background")
        return headerView
    }()
    // cincism info 谁评价的电影
    internal lazy var cincismInfoLabel: UILabel = {
        let cincismInfoLabel: UILabel = UILabel()
        //cincismInfoLabel.backgroundColor = UIColor.cyan
        cincismInfoLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 11)
        cincismInfoLabel.textColor = UIColor.darkGray
        return cincismInfoLabel
    }()
    // cincism title
    internal lazy var cincismTitleLabel: UILabel = {
        let cincismTitleLabel = UILabel()
        //cincismTitleLabel.backgroundColor = UIColor.blue
        cincismTitleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 16)
        return cincismTitleLabel
    }()
    // cincism brief
    internal lazy var cincismBriefLabel: UILabel = {
        let cincismBriefLabel: UILabel = UILabel()
        //cincismBriefLabel.backgroundColor = UIColor.green
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
