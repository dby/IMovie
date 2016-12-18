//
//  FilmController.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit
import SnapKit

let BUBBLE_DIAMETER: CGFloat = UIConstant.SCREEN_WIDTH - 70
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
    // 推荐列表
    case recommandList = 6
}

class FilmController: BasePageController, Reusable {

    //MARK: --- life cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        pullToRefresh.delegate = self
        
        getData()
    }
    
    //MARK: --- Private Methods ---
    func getData() {
        isRefreshing = true
        IMovie.shareInstance.getMovieModules(target: IMovieService.movieModules(), successHandle: { [weak self] (data) in
            
            debugPrint("GETDATA...SUCCESS")
            //debugPrint(data.nowHotShowData)
            //debugPrint("=================")
            //debugPrint(data.soonShowData)
            //debugPrint("=================")
            //debugPrint(data.rankListData)
            //debugPrint("=================")
            //debugPrint(data.bestReviewsData)
            //debugPrint("=================")
            //debugPrint(data.douListData)
            self?.data = data
            self?.tableView.reloadData()

            self?.isRefreshing = false
            self?.pullToRefresh.endRefresh()
            
            }, errorHandle: { (error) in
                print(error)
        })
    }
    
    //MARK:---Getter and Setter---
    var data: ModulesModel? = nil

}

//MARK:---下拉刷新更多---
extension FilmController : PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}
//MARK:---UICollectionViewDelegate UICollectionViewDataSource---
extension FilmController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView.tag == CollectionViewType.NowHotShow.rawValue) {
            return 6
        } else if (collectionView.tag == CollectionViewType.SoonShow.rawValue) {
            return 6
        } else if (collectionView.tag == CollectionViewType.Top250.rawValue) {
            return 4
        } else if (collectionView.tag == CollectionViewType.praiseList.rawValue) {
            return 6
        } else if (collectionView.tag == CollectionViewType.newMovieList.rawValue) {
            return 6
        } else if (collectionView.tag == CollectionViewType.boxOfficeList.rawValue) {
            return 6
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
            
            // 正在热映
            let cell = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
            if self.data != nil && self.data?.nowHotShowData != nil {
                cell.model = self.data?.nowHotShowData.data.subject_collection_boards[0].items[indexPath.row]
            }
            return cell
            
        } else if (CollectionViewType.SoonShow.rawValue == collectionView.tag) {
            
            // 即将上映
            let cell = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
            if self.data != nil && self.data?.soonShowData != nil {
                cell.model = self.data?.soonShowData.data.subject_collection_boards[0].items[indexPath.row]
            }
            return cell
            
        } else if (CollectionViewType.Top250.rawValue == collectionView.tag) {
            
            // 榜单
            let cell = RankListViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
            if self.data != nil && self.data?.rankListData != nil {
                cell.model = self.data?.rankListData.data.selected_collections[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.titleLabel.text = "Top250电影"
                    break
                case 1:
                    cell.titleLabel.text = "本周口碑榜"
                    break
                case 2:
                    cell.titleLabel.text = "新片榜"
                    break
                case 3:
                    cell.titleLabel.text = "票房榜"
                    break
                default:
                    break
                }
                
            }
            return cell
            
        } else if (CollectionViewType.praiseList.rawValue == collectionView.tag) {
            
            // 本周口碑榜
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: ImageCollCellType.Num9)
            if self.data != nil && self.data?.soonShowData != nil {
                cell.models = self.data?.soonShowData.data.subject_collection_boards[0].items
            }
            return cell
            
        } else {
            
            let cell   = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
            if self.data != nil && self.data?.nowHotShowData != nil {
                cell.model = self.data?.nowHotShowData.data.subject_collection_boards[0].items[indexPath.row]
            }
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (CollectionViewType.NowHotShow.rawValue == collectionView.tag) {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight
            return CGSize(width: MovieConstant.IMAGE_WIDTH, height: height)
        } else if (CollectionViewType.SoonShow.rawValue == collectionView.tag) {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight
            return CGSize(width: MovieConstant.IMAGE_WIDTH, height: height)
        } else if (CollectionViewType.Top250.rawValue == collectionView.tag) {
            let height = (UIConstant.SCREEN_WIDTH - 70) * 2.0 / 3.0
            return CGSize(width: (UIConstant.SCREEN_WIDTH - 70), height: height)
        //} else if (CollectionViewType.praiseList.rawValue == collectionView.tag) {
        //    let height = UIConstant.SCREEN_WIDTH * 3 / 6
        //    return CGSize (width: height, height: height)
        } else {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.TitleHeight + MovieConstant.RatingHeight
            return CGSize(width: MovieConstant.IMAGE_WIDTH, height: height)
        }
    }
}
//MARK:---UITableViewDelegate UITableViewDataSource---
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
        
        var cell: MovieInfoTableViewCell? = nil
        
        switch indexPath.row {
        
        case CollectionViewType.NowHotShow.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .None)
            cell?.titleLabel.text = "正在热映的电影"
            break
        case CollectionViewType.SoonShow.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .None)
            cell?.titleLabel.text = "即将上映的电影"
            break
        case CollectionViewType.Top250.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .Num3)
            cell?.titleLabel.text = "TOP250电影"
            break
        case CollectionViewType.praiseList.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .Num9)
            cell?.titleLabel.text = "本周口碑榜"
            break
        case CollectionViewType.newMovieList.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .None)
            cell?.titleLabel.text = "新片榜"
            break
        case CollectionViewType.boxOfficeList.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .None)
            cell?.titleLabel.text = "本周票房榜"
            break
        case CollectionViewType.recommandList.rawValue:
            cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .None)
            cell?.titleLabel.text = "推荐"
            break
        default:
            break
        }
        
        cell?.selectionStyle = .none
        cell?.dataCollectionView.tag = indexPath.row
        cell?.dataCollectionView.delegate = self
        cell?.dataCollectionView.dataSource = self
        cell?.dataCollectionView.reloadData()

        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}

extension FilmController {
    
    func nearestTargetOffsetForOffset(offset: CGPoint) -> CGPoint {
        let pageSize: CGFloat = BUBBLE_DIAMETER + BUBBLE_PADDING
        let page: Int = Int(roundf(Float(offset.x) / Float(pageSize)))
        let targetX: CGFloat = CGFloat(Float(pageSize) * Float(page))
        return CGPoint(x: targetX, y: offset.y)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        debugPrint("scrollViewWillEndDragging")
        let targetOffset: CGPoint = self.nearestTargetOffsetForOffset(offset: targetContentOffset.pointee)
        targetContentOffset.pointee.x = targetOffset.x
        targetContentOffset.pointee.y = targetOffset.y
    }
}
