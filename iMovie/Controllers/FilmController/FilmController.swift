//
//  FilmController.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit
import SnapKit

let BUBBLE_DIAMETER: CGFloat = 60.0
let BUBBLE_PADDING: CGFloat = 10.0

enum CollectionViewType: Int {
    // 正在热映
    case NowHotShow = 0
    // 即将上映
    case SoonShow = 1
    // 豆瓣口碑榜前250
    case Top250  = 2
    // 本周口碑榜
    case praiseList = 3
    // 新片榜
    case newMovieList = 4
    // 票房榜
    case boxOfficeList = 5
}

class FilmController: BasePageController, Reusable {

    //MARK: --- life cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(filmTableView)
        
        setupLayout()
        
        getData(num: 0)
    }
    
    //MARK: --- Private Methods ---
    func getData(num: NSInteger) {
        
        IMovie.shareInstance.getMovieTop250(target: IMovieService.movie_top_250(num), successHandle: { [weak self] (data) in
            
            for item in data.subject_collection_items {
                self?.newMovieListMovieModelArray.append(item)
                self?.soonShowMovieModelArray.append(item)
                self?.top250MovieModelArray.append(item)
                self?.praiseListMovieModelArray.append(item)
                self?.newMovieListMovieModelArray.append(item)
                self?.boxOfficeListMovieModelArray.append(item)
            }
            
            debugPrint("GETDATA...SUCCESS")
            self?.filmTableView.reloadData()
            
            }, errorHandle: { (error) in
                
        })
    }
    
    func setupLayout() {
        filmTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: --- Getter and Setter ---
    var nowHotShowMovieModelArray = Array<MovieModel>()
    var soonShowMovieModelArray = Array<MovieModel>()
    var top250MovieModelArray   = Array<MovieModel>()
    var praiseListMovieModelArray = Array<MovieModel>()
    var newMovieListMovieModelArray  = Array<MovieModel>()
    var boxOfficeListMovieModelArray = Array<MovieModel>()
    
    fileprivate lazy var filmTableView: UITableView = {
        let filmTableView: UITableView = UITableView()
        filmTableView.delegate = self
        filmTableView.dataSource = self
        //filmTableView.separatorStyle = .none
        
        return filmTableView
    }()
    
    // 正在热映
    fileprivate lazy var nowHotShowMovieInfoView: MovieInfoView = {
        let nowHotShowMovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        nowHotShowMovieInfoView.dataCollectionView.tag = CollectionViewType.NowHotShow.rawValue
        nowHotShowMovieInfoView.dataCollectionView.delegate   = self
        nowHotShowMovieInfoView.dataCollectionView.dataSource = self
        nowHotShowMovieInfoView.backgroundColor = UIColor.red
        
        return nowHotShowMovieInfoView
    }()
    // 即将上映
    fileprivate lazy var soonShowMovieInfoView: MovieInfoView = {
        let soonShowMovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        soonShowMovieInfoView.dataCollectionView.tag = CollectionViewType.SoonShow.rawValue
        soonShowMovieInfoView.dataCollectionView.delegate   = self
        soonShowMovieInfoView.dataCollectionView.dataSource = self
        
        return soonShowMovieInfoView
    }()
    // 豆瓣口碑前250名
    fileprivate lazy var top250MovieInfoView: MovieInfoView = {
        let top250MovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        top250MovieInfoView.dataCollectionView.tag = CollectionViewType.Top250.rawValue
        top250MovieInfoView.dataCollectionView.delegate   = self
        top250MovieInfoView.dataCollectionView.dataSource = self
        
        return top250MovieInfoView
    }()
    // 本周口碑榜
    fileprivate lazy var praiseListMovieInfoView: MovieInfoView = {
        let praiseListMovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        praiseListMovieInfoView.dataCollectionView.tag = CollectionViewType.praiseList.rawValue
        praiseListMovieInfoView.dataCollectionView.delegate   = self
        praiseListMovieInfoView.dataCollectionView.dataSource = self
        
        return praiseListMovieInfoView
    }()
    // 新片榜
    fileprivate lazy var newMovieInfoView: MovieInfoView = {
        let newMovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        newMovieInfoView.dataCollectionView.tag = CollectionViewType.newMovieList.rawValue
        newMovieInfoView.dataCollectionView.delegate   = self
        newMovieInfoView.dataCollectionView.dataSource = self
        
        return newMovieInfoView
    }()
    // 本周票房榜
    fileprivate lazy var boxOfficeListMovieInfoView: MovieInfoView = {
        let boxOfficeListMovieInfoView: MovieInfoView = MovieInfoView(frame: CGRect.zero)
        boxOfficeListMovieInfoView.dataCollectionView.tag = CollectionViewType.boxOfficeList.rawValue
        boxOfficeListMovieInfoView.dataCollectionView.delegate   = self
        boxOfficeListMovieInfoView.dataCollectionView.dataSource = self
        
        return boxOfficeListMovieInfoView
    }()
}

extension FilmController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView.tag == CollectionViewType.NowHotShow.rawValue) {
            return newMovieListMovieModelArray.count > 6 ? 6 : newMovieListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.SoonShow.rawValue) {
            return soonShowMovieModelArray.count / 3
        } else if (collectionView.tag == CollectionViewType.Top250.rawValue) {
            return top250MovieModelArray.count > 6 ? 6 : top250MovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.praiseList.rawValue) {
            return praiseListMovieModelArray.count > 6 ? 6 : praiseListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.newMovieList.rawValue) {
            return newMovieListMovieModelArray.count > 6 ? 6 : newMovieListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.boxOfficeList.rawValue) {
            return boxOfficeListMovieModelArray.count > 6 ? 6 : boxOfficeListMovieModelArray.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (CollectionViewType.NowHotShow.rawValue == collectionView.tag) {
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: ImageCollCellType.Num3)
            cell.models = top250MovieModelArray
            return cell
        } else if (CollectionViewType.SoonShow.rawValue == collectionView.tag) {
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: ImageCollCellType.Num4)
            cell.models = top250MovieModelArray
            return cell
        } else if (CollectionViewType.Top250.rawValue == collectionView.tag) {
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: ImageCollCellType.Num6)
            cell.models = top250MovieModelArray
            return cell
        } else if (CollectionViewType.praiseList.rawValue == collectionView.tag) {
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: ImageCollCellType.Num9)
            cell.models = top250MovieModelArray
            return cell
        } else {
            let cell   = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
            cell.model = top250MovieModelArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //if (CollectionViewType.NowHotShow.rawValue == collectionView.tag) {
          //  let height = UIConstant.SCREEN_WIDTH * 2 / 3
            //return CGSize(width: UIConstant.SCREEN_WIDTH, height: height)
        //} else if (CollectionViewType.SoonShow.rawValue == collectionView.tag) {
         //   let height = UIConstant.SCREEN_WIDTH * 2 / 5
           // return CGSize(width: UIConstant.SCREEN_WIDTH, height: height)
        //} else if (CollectionViewType.Top250.rawValue == collectionView.tag) {
        //    let height = UIConstant.SCREEN_WIDTH * 2 / 3
        //    return CGSize(width: height, height: height)
        //} else if (CollectionViewType.praiseList.rawValue == collectionView.tag) {
        //    let height = UIConstant.SCREEN_WIDTH * 3 / 6
        //    return CGSize (width: height, height: height)
        //} else {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight
            return CGSize(width: MovieConstant.IMAGE_WIDTH, height: height)
        //}
    }
}

extension FilmController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 6 {
            return 0
        } else {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight + MovieConstant.BarHeight + MovieConstant.BottomSpace
            return height
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "FilmControllerIdentifier")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FilmControllerIdentifier")
        }
        
        for item: UIView in (cell?.contentView.subviews)! {
            if item is MovieInfoView {
                item.removeFromSuperview()
            }
        }
        
        //switch indexPath.row {
        switch 0 {
        case CollectionViewType.NowHotShow.rawValue:
            self.nowHotShowMovieInfoView.titleLabel.text = "正在热映的电影"
            cell?.contentView.addSubview(self.nowHotShowMovieInfoView)
            self.nowHotShowMovieInfoView.frame = (cell?.frame)!
            self.nowHotShowMovieInfoView.dataCollectionView.reloadData()
            break
        case CollectionViewType.SoonShow.rawValue:
            self.soonShowMovieInfoView.titleLabel.text = "即将上映的电影"
            cell?.contentView.addSubview(self.soonShowMovieInfoView)
            self.soonShowMovieInfoView.frame = (cell?.frame)!
            self.soonShowMovieInfoView.dataCollectionView.reloadData()
            break
        case CollectionViewType.Top250.rawValue:
            self.top250MovieInfoView.titleLabel.text = "TOP250电影"
            cell?.contentView.addSubview(self.top250MovieInfoView)
            self.top250MovieInfoView.frame = (cell?.frame)!
            self.top250MovieInfoView.dataCollectionView.reloadData()
            break
        case CollectionViewType.praiseList.rawValue:
            self.praiseListMovieInfoView.titleLabel.text = "本周口碑榜"
            cell?.contentView.addSubview(self.praiseListMovieInfoView)
            self.praiseListMovieInfoView.frame = (cell?.frame)!
            self.praiseListMovieInfoView.dataCollectionView.reloadData()
            break
        case CollectionViewType.newMovieList.rawValue:
            self.newMovieInfoView.titleLabel.text = "新片榜"
            cell?.contentView.addSubview(self.newMovieInfoView)
            self.newMovieInfoView.frame = (cell?.frame)!
            self.newMovieInfoView.dataCollectionView.reloadData()
            break
        case CollectionViewType.boxOfficeList.rawValue:
            self.boxOfficeListMovieInfoView.titleLabel.text = "本周票房榜"
            cell?.contentView.addSubview(self.boxOfficeListMovieInfoView)
            self.boxOfficeListMovieInfoView.frame = (cell?.frame)!
            self.boxOfficeListMovieInfoView.dataCollectionView.reloadData()

            break
        case 6:
            break
        default:
            break
        }
        cell?.selectionStyle = .none
        
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}
/*
extension FilmController: UIScrollViewDelegate {
    
    func nearestTargetOffsetForOffset(offset: CGPoint) -> CGPoint {
        let pageSize: CGFloat = BUBBLE_DIAMETER + BUBBLE_PADDING
        let page: NSInteger   = NSInteger(roundf(Float(offset.x) / Float(pageSize)))
        let targetX: CGFloat  = CGFloat(Float(pageSize) * Float(page))
        
        return CGPoint.init(x: targetX, y: offset.y)
    }
    
    func snapToNearestItem() {
        //let targetOffset: CGPoint = self.nearestTargetOffsetForOffset(offset: self.top250CollectionView.contentOffset)
        //self.top250CollectionView.setContentOffset(targetOffset, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            //self.snapToNearestItem()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //self.snapToNearestItem()
    }
}
*/
