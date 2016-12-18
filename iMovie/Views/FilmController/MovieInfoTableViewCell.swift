//
//  FilmTableCell.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

class MovieInfoTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 添加控件
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(moreButton)
        self.contentView.addSubview(dataCollectionView)
        
        setupLayout()
    }
    
    class func cellWithTableView(_ tableView : UITableView, type: ImageCollCellType) -> MovieInfoTableViewCell {
        
        var identifier: String = self.reuseIdentifier
        switch type {
        case .Num3:
            identifier = identifier.appending("NUM3")
            break
        case .Num4:
            identifier = identifier.appending("NUM4")
            break
        case .Num6:
            identifier = identifier.appending("NUM6")
            break
        case .Num9:
            identifier = identifier.appending("NUM9")
            break
        case .None:
            break
        }
        
        var cell = tableView.dequeueReusableCell() as MovieInfoTableViewCell?
        if cell == nil {
            cell = MovieInfoTableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
            cell?.imageCellType  = type
        }
        return cell!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Private Method ---
    func setupLayout() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(150)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-1 * MovieConstant.LeftEdge)
            make.height.equalTo(MovieConstant.BarHeight)
            make.width.equalTo(100)
        }
        dataCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight)
        }
    }
    
    //MARK: --- Getter and Setter ---
    fileprivate var imageCellType: ImageCollCellType = ImageCollCellType.None
    
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
        
        dataCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: String(describing: MovieViewCell.self))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self).appending("NUM3"))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self).appending("NUM4"))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self).appending("NUM6"))
        dataCollectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: String(describing: ImageCollectionCell.self).appending("NUM9"))
        dataCollectionView.register(RankListViewCell.self, forCellWithReuseIdentifier: String(describing: RankListViewCell.self))
        
        dataCollectionView.backgroundColor = UIColor.white

        return dataCollectionView
    }()
}
