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
            cell?.selectionStyle = .none
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
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(150)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-1 * MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(100)
        }
        dataCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight)
        }
    }
    
    //MARK: --- Getter and Setter ---
    public var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        //titleLabel.backgroundColor = UIColor.green
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 20)
        return titleLabel
    }()
    
    public var moreButton: UIButton = {
        let moreButton: UIButton = UIButton()
        moreButton.setTitle("查看全部>", for: .normal)
        moreButton.setTitleColor(UIColor.darkGray, for: .normal)
        moreButton.contentHorizontalAlignment = .right
        //moreButton.backgroundColor = UIColor.brown
        moreButton.titleLabel?.font = FontConstant.SYS_14
        return moreButton
    }()
    
    public var dataCollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, MovieConstant.LeftEdge, 0, MovieConstant.LeftEdge)
        
        let dataCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        dataCollectionView.bounces = false
        dataCollectionView.isPagingEnabled = false
        dataCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: String(describing: MovieViewCell.self))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self))
        dataCollectionView.backgroundColor = UIColor.white

        return dataCollectionView
    }()
}
