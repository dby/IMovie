//
//  CommentTableViewCell.swift
//  iMovie
//
//  Created by sys on 2016/12/16.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class CommentTableViewCell:  UITableViewCell, Reusable {
    
    //MARK:-----Variables-----
    var model: CommentModel? {
        didSet{
            self.contentLabel.attributedText = UILabel.setAttributText(model?.text, lineSpcae: 5.0)
            self.nameLabel.text = model?.author.name
            self.timeLabel.text = model?.create_time
            
            if let url = model?.author.avatar {
                self.avatarImageView.if_setImage(URL(string: url))
            }
            
            if (model?.ref_comment == nil) {
                
                self.setupLayout(hasRefComment: false)
            
            } else {
                
                self.setupLayout(hasRefComment: true)
                let refCommentModel: CommentModel = CommentModel(dict: model?.ref_comment)
                self.refCommentContentLabel.attributedText = UILabel.setAttributText(refCommentModel.text, lineSpcae: 5.0)
            }
        }
    }

    //MARK:-----init-----
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.refCommentContentLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-----Private Function-----
    class func cellWithTableView(_ tableView : UITableView) -> CommentTableViewCell {
        
        var cell: CommentTableViewCell? = tableView.dequeueReusableCell() as CommentTableViewCell?
        if cell == nil {
            cell = CommentTableViewCell(style: .default, reuseIdentifier: self.reuseIdentifier)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    // 计算内容的高度
    class func estimateCellHeight(_ model : CommentModel, font: UIFont, size: CGSize) -> CGFloat {
        
        let paragphStyle = NSMutableParagraphStyle()
        paragphStyle.lineSpacing = 5.0;
        paragphStyle.firstLineHeadIndent    = 0.0;
        paragphStyle.hyphenationFactor      = 0.0;
        paragphStyle.paragraphSpacingBefore = 0.0;

        let dic = [NSFontAttributeName : font,
                   NSParagraphStyleAttributeName: paragphStyle,
                   NSKernAttributeName : 1.0] as [String : Any]

        let commentRect: CGRect = model.text.boundingRect(with: size,
                                                          options: .usesLineFragmentOrigin,
                                                          attributes: dic as [String : AnyObject],
                                                          context: nil)
        if (model.ref_comment == nil) {
            
            return commentRect.height + 60
            
        } else {
            
            let refComment: CommentModel = CommentModel(dict: model.ref_comment)
            let refCommentRect: CGRect = refComment.text.boundingRect(with: size,
                                                                      options: .usesLineFragmentOrigin,
                                                                      attributes: dic as [String : AnyObject],
                                                                      context: nil)
            
            return commentRect.height + refCommentRect.height + 60
        }
    }
    
    //设置布局
    internal func setupLayout(hasRefComment: Bool) {
        
        if (!hasRefComment) {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(20)
                make.left.equalTo(self.contentView).offset(10)
                make.width.height.equalTo(30)
            }
            self.nameLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.avatarImageView.snp.centerY)
                make.left.equalTo(self.avatarImageView.snp.right).offset(10)
            }
            self.timeLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.avatarImageView.snp.centerY)
                make.left.equalTo(self.nameLabel.snp.right).offset(10)
            }
            self.contentLabel.snp.makeConstraints { (make) in
                make.top.equalTo(self.avatarImageView.snp.bottom)
                make.left.equalTo(self.contentView).offset(50)
                make.right.equalTo(self.contentView).offset(-10)
                make.bottom.equalTo(self.contentView)
            }
        } else {
            self.avatarImageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.contentView).offset(20)
                make.left.equalTo(self.contentView).offset(10)
                make.width.height.equalTo(30)
            }
            self.nameLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.avatarImageView.snp.centerY)
                make.left.equalTo(self.avatarImageView.snp.right).offset(10)
            }
            self.timeLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.avatarImageView.snp.centerY)
                make.left.equalTo(self.nameLabel.snp.right).offset(10)
            }
            self.refCommentContentLabel.snp.makeConstraints({ (make) in
                make.top.equalTo(self.avatarImageView.snp.bottom)
                make.left.equalTo(self.contentView).offset(50)
                make.bottom.equalTo(self.contentLabel.snp.top).offset(-5)
                make.right.equalTo(self.contentView).offset(-10)
            })
            self.contentLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.contentView).offset(50)
                make.right.equalTo(self.contentView).offset(-10)
                make.bottom.equalTo(self.contentView)
            }
        }
    }
    
    //MARK:-----Getter Setter-----
    internal lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        return avatarImageView
    }()
    
    internal lazy var nameLabel: UILabel = {
        let nameLabel: UILabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.backgroundColor = UIColor.yellow
        return nameLabel
    }()
    
    internal lazy var timeLabel: UILabel = {
        let timeLabel: UILabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        timeLabel.backgroundColor = UIColor.red
        return timeLabel
    }()
    
    internal lazy var contentLabel: UILabel = {
        let contentLabel  = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.backgroundColor = UIColor.green
        return contentLabel
    }()
    
    internal lazy var refCommentContentLabel: UILabel = {
        let refCommentContentLabel: UILabel = UILabel()
        refCommentContentLabel.numberOfLines = 0
        refCommentContentLabel.font = UIFont.systemFont(ofSize: 14)
        refCommentContentLabel.backgroundColor = UIColor(red: 250/255.0,
                                                         green: 247/255.0,
                                                         blue: 250/255.0,
                                                         alpha: 1.0)
        
        return refCommentContentLabel
    }()
}
