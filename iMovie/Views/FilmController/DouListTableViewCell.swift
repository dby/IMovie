//
//  DouListCell.swift
//  iMovie
//
//  Created by sys on 2016/12/19.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class DouListTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 添加控件
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(countLabel)
        self.contentView.addSubview(posterImageView)
        
    }
    
    class func cellWithTableView(_ tableView : UITableView) -> DouListTableViewCell {
        
        var cell = tableView.dequeueReusableCell() as DouListTableViewCell?
        if cell == nil {
            cell = DouListTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
            
            cell?.setupLayout()
        }
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:---Private Methods---
    func setupLayout() {
        
        self.posterImageView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-MovieInfoConstant.LeftEdge)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.width.height.equalTo(DouListViewConstant.ImageSize)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(MovieInfoConstant.LeftEdge)
            make.right.equalTo(self.posterImageView.snp.left).offset(-UIConstant.UI_MARGIN_15)
            make.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        self.countLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(MovieInfoConstant.LeftEdge)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(3)
            make.right.equalTo(self.posterImageView.snp.left).offset(-UIConstant.UI_MARGIN_15)
            make.height.equalTo(10)
        }
    }
    
    //MARK:---Setter and Getter---
    var model: DouModel! {
        didSet {
            self.titleLabel.text = model.title
            self.countLabel.text = String(model.followers_count).appending("收藏")
            
            let strs:[String] = model.merged_cover_url.components(separatedBy: "?")
            self.posterImageView.if_setImage(URL(string:strs[0]))
        }
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel: UILabel = UILabel()
        titleLabel.font = FontConstant.SYS_16
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    fileprivate lazy var countLabel: UILabel = {
        var countLabel: UILabel = UILabel()
        countLabel.font = FontConstant.SYS_12
        countLabel.textColor = UIColor.gray
        countLabel.numberOfLines = 0
        return countLabel
    }()
    
    internal lazy var posterImageView: UIImageView = {
        var posterImageView: UIImageView = UIImageView()
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.backgroundColor = UIColor.brown
        return posterImageView
    }()
}
