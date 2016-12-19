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
    // 精选榜单
    case RankList = 2
    // 推荐列表
    case RecommandList = 3
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
        } else if (collectionView.tag == CollectionViewType.RankList.rawValue) {
            return 4
        } else if (collectionView.tag == CollectionViewType.RecommandList.rawValue) {
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
            
        } else if (CollectionViewType.RankList.rawValue == collectionView.tag) {
            
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
            
        } else if (CollectionViewType.RecommandList.rawValue == collectionView.tag) {
            
            // 本周口碑榜
            let cell = ImageCollectionCell.cellWithCollectionView(collectionView, indexPath: indexPath, type: DataCollectionViewCellType.ImageCellNum3)
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
            let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight
            return CGSize(width: MovieViewConstant.IMAGE_WIDTH, height: height)
        } else if (CollectionViewType.SoonShow.rawValue == collectionView.tag) {
            let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight
            return CGSize(width: MovieViewConstant.IMAGE_WIDTH, height: height)
        } else if (CollectionViewType.RankList.rawValue == collectionView.tag) {
            let height = (UIConstant.SCREEN_WIDTH - 70)/1.5
            return CGSize(width: height-10, height: height-10)
        //} else if (CollectionViewType.praiseList.rawValue == collectionView.tag) {
        //    let height = UIConstant.SCREEN_WIDTH * 3 / 6
        //    return CGSize (width: height, height: height)
        } else {
            let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight
            return CGSize(width: MovieViewConstant.IMAGE_WIDTH, height: height)
        }
    }
}
//MARK:---UITableViewDelegate UITableViewDataSource---
extension FilmController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if indexPath.row == CollectionViewType.NowHotShow.rawValue {
                
                // 正在热映Cell
                let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight + MovieInfoConstant.BarHeight + MovieInfoConstant.BottomSpace
                return height
            
            } else if indexPath.row == CollectionViewType.SoonShow.rawValue {
                
                // 即将上映Cell
                let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight + MovieInfoConstant.BarHeight + MovieInfoConstant.BottomSpace
                return height
                
            } else if indexPath.row == CollectionViewType.RankList.rawValue {
                
                // 榜单
                let height = RankListConstant.ItemSize + MovieInfoConstant.BarHeight + MovieInfoConstant.BottomSpace
                return height
                
            } else if indexPath.row == CollectionViewType.RecommandList.rawValue {
                
                // 推荐列表
                let height = MovieViewConstant.IMAGE_HEIGHT + MovieInfoConstant.TitleHeight + MovieInfoConstant.RatingHeight + MovieInfoConstant.BarHeight + MovieInfoConstant.BottomSpace
                return height
                
            } else {
                return 0
            }
        } else {
            
            return DouListViewConstant.ImageSize * 1.5
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var cell: MovieInfoTableViewCell? = nil
            
            switch indexPath.row {
        
            case CollectionViewType.NowHotShow.rawValue:
                cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .MovieViewCell)
                cell?.titleLabel.text = "正在热映的电影"
                break
            case CollectionViewType.SoonShow.rawValue:
                cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .MovieViewCell)
                cell?.titleLabel.text = "即将上映的电影"
                break
            case CollectionViewType.RankList.rawValue:
                cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .RankListViewCell)
                cell?.titleLabel.text = "精选榜单"
                break
            case CollectionViewType.RecommandList.rawValue:
                cell = MovieInfoTableViewCell.cellWithTableView(tableView, type: .ImageCellNum3)
                cell?.titleLabel.text = "推荐列表"
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
            
        } else {
            
            var cell: DouListTableViewCell? = nil

            cell = DouListTableViewCell.cellWithTableView(tableView)
            cell?.model = (self.data?.douListData.data.doulists[indexPath.row])!

            return cell!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) {
            return nil
        } else {
            
            let titleLabel: UILabel = UILabel()
            //titleLabel.backgroundColor = UIColor.green
            titleLabel.text = "发现好电影"
            titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 20)
            
            let moreButton: UIButton = UIButton()
            moreButton.setTitle("查看全部>", for: .normal)
            moreButton.setTitleColor(UIColor.darkGray, for: .normal)
            moreButton.contentHorizontalAlignment = .right
            //moreButton.backgroundColor = UIColor.brown
            moreButton.titleLabel?.font = FontConstant.SYS_14
            
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 35))
            view.addSubview(titleLabel)
            view.addSubview(moreButton)
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(view)
                make.left.equalTo(view).offset(MovieInfoConstant.LeftEdge)
                make.height.equalTo(MovieInfoConstant.BarHeight)
                make.width.equalTo(150)
            }
            moreButton.snp.makeConstraints { (make) in
                make.top.equalTo(view)
                make.right.equalTo(view).offset(-1 * MovieInfoConstant.LeftEdge)
                make.height.equalTo(MovieInfoConstant.BarHeight)
                make.width.equalTo(100)
            }

            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        } else {
            return 35
        }
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
