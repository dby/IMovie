//
//  ImageCollectionCell.swift
//  iMovie
//
//  Created by sys on 2016/12/9.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

let GapConstant: CGFloat = 5

class ImageCollectionCell: UICollectionViewCell, Reusable {
    
    class func cellWithCollectionView(_ collectionView: UICollectionView, indexPath: IndexPath, type: DataCollectionViewCellType) -> ImageCollectionCell {
        
        var identifier = self.reuseIdentifier
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
        default:
            break
        }
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? ImageCollectionCell
        if cell == nil {
            cell = ImageCollectionCell()
        }
        cell?.type = type
        
        cell?.initData()
        return cell!
    }
    
    func initData() {
        
        self.contentView.addSubview(image1)
        self.contentView.addSubview(image2)
        self.contentView.addSubview(image3)
        
        images.append(image1)
        images.append(image2)
        images.append(image3)
        
        switch type {
        case .ImageCellNum4:
            self.contentView.addSubview(image4)
            images.append(image4)
            break
        case .ImageCellNum6:
            self.contentView.addSubview(image4)
            self.contentView.addSubview(image5)
            self.contentView.addSubview(image6)
            images.append(image4)
            images.append(image5)
            images.append(image6)
            break
        case .ImageCellNum9:
            self.contentView.addSubview(image4)
            self.contentView.addSubview(image5)
            self.contentView.addSubview(image6)
            self.contentView.addSubview(image7)
            self.contentView.addSubview(image8)
            self.contentView.addSubview(image9)
            images.append(image4)
            images.append(image5)
            images.append(image6)
            images.append(image7)
            images.append(image8)
            images.append(image9)
            break
        default:
            break
        }
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- Private Methods ---
    fileprivate func setupLayout() {
        switch type {
        case .ImageCellNum3:
            let smallWidth: CGFloat = self.width / 3.0
            let bigWidth: CGFloat   = self.width - smallWidth
            
            image1.snp.makeConstraints({ (make) in
                make.left.top.equalTo(self.contentView)
                make.width.height.equalTo(bigWidth)
            })
            
            image2.snp.makeConstraints({ (make) in
                make.left.equalTo(image1.snp.right)
                make.top.equalTo(self.contentView)
                make.height.width.equalTo(smallWidth)
            })
            
            image3.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView)
                make.top.equalTo(image2.snp.bottom)
                make.width.height.equalTo(smallWidth)
            })
            break
            
        case .ImageCellNum4:
            let smallWidth: CGFloat = (self.width - GapConstant * 2) / 5
            let bigWidth: CGFloat = (self.width - smallWidth - GapConstant * 2)/2

            image1.snp.makeConstraints({ (make) in
                make.top.left.equalTo(self.contentView)
                make.width.height.equalTo(bigWidth)
            })
            image2.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView)
                make.left.equalTo(image1.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image3.snp.makeConstraints({ (make) in
                make.left.equalTo(image1.snp.right).offset(GapConstant)
                make.top.equalTo(image2.snp.bottom).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image4.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView)
                make.left.equalTo(image3.snp.right).offset(GapConstant)
                make.width.height.equalTo(bigWidth)
            })
            
            break
            
        case .ImageCellNum6:
            let smallWidth: CGFloat = (self.width - GapConstant * 2) / 3
            let bigWidth: CGFloat = self.width - GapConstant - smallWidth
            image1.snp.makeConstraints({ (make) in
                make.left.top.equalTo(self.contentView)
                make.width.equalTo(bigWidth)
                make.height.equalTo(bigWidth)
            })
            image2.snp.makeConstraints({ (make) in
                make.top.right.equalTo(self.contentView)
                make.width.height.equalTo(smallWidth)
            })
            image3.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView)
                make.top.equalTo(image2.snp.bottom).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image4.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView)
                make.top.equalTo(image1.snp.bottom).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image5.snp.makeConstraints({ (make) in
                make.top.equalTo(image1.snp.bottom).offset(GapConstant)
                make.left.equalTo(image4.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image6.snp.makeConstraints({ (make) in
                make.top.equalTo(image3.snp.bottom).offset(GapConstant)
                make.right.equalTo(self.contentView)
                make.width.height.equalTo(smallWidth)
            })
            
            break
            
        case .ImageCellNum9:
            let smallWidth: CGFloat = (self.width - 4 * GapConstant) / 5
            let bigWidth: CGFloat = (self.width - 2 * GapConstant - smallWidth) / 2
            
            image1.snp.makeConstraints({ (make) in
                make.left.top.equalTo(self.contentView)
                make.width.height.equalTo(bigWidth)
            })
            image2.snp.makeConstraints({ (make) in
                make.top.equalTo(self.contentView)
                make.left.equalTo(image1.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image3.snp.makeConstraints({ (make) in
                make.top.equalTo(image2.snp.bottom).offset(GapConstant)
                make.left.equalTo(image1.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image4.snp.makeConstraints({ (make) in
                make.top.right.equalTo(self.contentView)
                make.width.height.equalTo(bigWidth)
            })
            image5.snp.makeConstraints({ (make) in
                make.left.equalTo(self.contentView)
                make.top.equalTo(image1.snp.bottom).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image6.snp.makeConstraints({ (make) in
                make.top.equalTo(image1.snp.bottom).offset(GapConstant)
                make.left.equalTo(image5.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image7.snp.makeConstraints({ (make) in
                make.top.equalTo(image3.snp.bottom).offset(GapConstant)
                make.left.equalTo(image6.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image8.snp.makeConstraints({ (make) in
                make.top.equalTo(image4.snp.bottom).offset(GapConstant)
                make.left.equalTo(image7.snp.right).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            image9.snp.makeConstraints({ (make) in
                make.right.equalTo(self.contentView)
                make.top.equalTo(image4.snp.bottom).offset(GapConstant)
                make.width.height.equalTo(smallWidth)
            })
            
            break
        default:
            break

        }
    }
    
    //MARK: --- Getter and Setter ---
    fileprivate lazy var type: DataCollectionViewCellType = DataCollectionViewCellType.ImageCellNum3
    fileprivate var images: [UIImageView] = [UIImageView]()
    
    //MARK:--- Getter or Setter ---
    var models: [MovieModel]! {
        didSet {
            
            for i in 0..<min(images.count, models.count) {
                let curModel = models[i]
                let curImage = images[i]
                
                let strs:[String] = curModel.cover.url.components(separatedBy: "?")
                curImage.if_setImage(URL(string: strs[0]))
            }
        }
    }
    
    fileprivate lazy var image1: UIImageView = {
        let image1: UIImageView = UIImageView()
        image1.backgroundColor = UIColor.red
        image1.contentMode = .scaleAspectFill
        image1.clipsToBounds = true
        return image1
    }()
    
    fileprivate lazy var image2: UIImageView = {
        let image2: UIImageView = UIImageView()
        image2.backgroundColor = UIColor.orange
        image2.contentMode = .scaleAspectFill
        image2.clipsToBounds = true
        return image2
    }()
    
    fileprivate lazy var image3: UIImageView = {
        let image3: UIImageView = UIImageView()
        image3.backgroundColor = UIColor.yellow
        image3.contentMode = .scaleAspectFill
        image3.clipsToBounds = true
        return image3
    }()
    
    fileprivate lazy var image4: UIImageView = {
        let image4: UIImageView = UIImageView()
        image4.backgroundColor = UIColor.blue
        image4.contentMode = .scaleAspectFill
        image4.clipsToBounds = true
        return image4
    }()
    
    fileprivate lazy var image5: UIImageView = {
        let image5: UIImageView = UIImageView()
        image5.backgroundColor = UIColor.cyan
        image5.contentMode = .scaleAspectFill
        image5.clipsToBounds = true
        return image5
    }()
    
    fileprivate lazy var image6: UIImageView = {
        let image6: UIImageView = UIImageView()
        image6.backgroundColor = UIColor.purple
        image6.contentMode = .scaleAspectFill
        image6.clipsToBounds = true
        return image6
    }()
    
    fileprivate lazy var image7: UIImageView = {
        let image7: UIImageView = UIImageView()
        image7.contentMode = .scaleAspectFill
        image7.backgroundColor = UIColor.black
        image7.clipsToBounds = true
        return image7
    }()
    
    fileprivate lazy var image8: UIImageView = {
        let image8: UIImageView = UIImageView()
        image8.contentMode = .scaleAspectFill
        image8.backgroundColor = UIColor.darkGray
        image8.clipsToBounds = true
        return image8
    }()
    
    fileprivate lazy var image9: UIImageView = {
        let image9: UIImageView = UIImageView()
        image9.contentMode = .scaleAspectFill
        image9.backgroundColor = UIColor.blue
        image9.clipsToBounds = true
        return image9
    }()
}
