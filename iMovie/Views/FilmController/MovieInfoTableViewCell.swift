//
//  FilmTableCell.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

// DataCollectionView Cell的类型
enum DataCollectionViewCellType {
    case ImageCellNum3
    case ImageCellNum4
    case ImageCellNum6
    case ImageCellNum9
    case MovieViewCell
    case RankListViewCell
}

class MovieInfoTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // 添加控件
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(moreButton)
        self.contentView.addSubview(dataCollectionView)
        
    }
    
    class func cellWithTableView(_ tableView : UITableView, type: DataCollectionViewCellType) -> MovieInfoTableViewCell {
        
        var identifier: String = self.reuseIdentifier
        switch type {
        case .ImageCellNum3:
            identifier = identifier.appending("NUM3")
            break
        case .ImageCellNum4:
            identifier = identifier.appending("NUM4")
            break
        case .ImageCellNum6:
            identifier = identifier.appending("NUM6")
            break
        case .ImageCellNum9:
            identifier = identifier.appending("NUM9")
            break
        case .MovieViewCell:
            identifier = identifier.appending("MovieViewCell")
            break
        case .RankListViewCell:
            identifier = identifier.appending("RankListViewCell")
            break
        }
        
        var cell = tableView.dequeueReusableCell() as MovieInfoTableViewCell?
        if cell == nil {
            cell = MovieInfoTableViewCell(style: .default, reuseIdentifier: identifier)
            cell?.selectionStyle = .none
            cell?.dataCollectionViewCellType  = type
            
            cell?.setupLayout()
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
            make.left.equalTo(self).offset(MovieInfoConstant.LeftEdge)
            make.height.equalTo(MovieInfoConstant.BarHeight)
            make.width.equalTo(150)
        }
        moreButton.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-1 * MovieInfoConstant.LeftEdge)
            make.height.equalTo(MovieInfoConstant.BarHeight)
            make.width.equalTo(100)
        }
        
        switch self.dataCollectionViewCellType {
        case .RankListViewCell:
            dataCollectionView.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.right.equalTo(self)
                make.height.equalTo(RankListConstant.ItemSize)
            })
            break
        default:
            dataCollectionView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.right.equalTo(self)
                make.height.equalTo(MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight)
            }
            break
        }
    }
    
    //MARK: --- Getter and Setter ---
    fileprivate var dataCollectionViewCellType: DataCollectionViewCellType = DataCollectionViewCellType.ImageCellNum3
    
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
        layout.sectionInset = UIEdgeInsetsMake(0, MovieInfoConstant.LeftEdge, 0, MovieInfoConstant.LeftEdge)
        
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
