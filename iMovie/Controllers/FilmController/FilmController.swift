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
        filmTableView.separatorStyle = .none
        
        return filmTableView
    }()
}

extension FilmController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView.tag == CollectionViewType.NowHotShow.rawValue) {
            return newMovieListMovieModelArray.count > 6 ? 6 : newMovieListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.SoonShow.rawValue) {
            return soonShowMovieModelArray.count > 6 ? 6 : soonShowMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.Top250.rawValue) {
            return top250MovieModelArray.count > 6 ? 6 : top250MovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.praiseList.rawValue) {
            return praiseListMovieModelArray.count > 6 ? 6 : praiseListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.newMovieList.rawValue) {
            return newMovieListMovieModelArray.count > 6 ? 6 : newMovieListMovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.boxOfficeList.rawValue) {
            return boxOfficeListMovieModelArray.count > 6 ? 6 : boxOfficeListMovieModelArray.count
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
        cell.model = top250MovieModelArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.MovieTitleHeight + MovieConstant.MovieRatingHeight
        return CGSize(width: MovieConstant.IMAGE_WIDTH, height: height)
    }
}

extension FilmController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 6 {
            return 0
        } else {
            let height = MovieConstant.IMAGE_HEIGHT + MovieConstant.MovieTitleHeight + MovieConstant.MovieRatingHeight + MovieConstant.MovieTitleHeight

            return height
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FilmTableViewCell = FilmTableViewCell.cellWithTableView(tableView)
        cell.dataCollectionView.delegate = self
        cell.dataCollectionView.dataSource = self
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "正在热映的电影"
            break
        case 1:
            cell.titleLabel.text = "即将上映的电影"
            break
        case 2:
            cell.titleLabel.text = "TOP250电影"
            break
        case 3:
            cell.titleLabel.text = "本周口碑榜"
            break
        case 4:
            cell.titleLabel.text = "新片榜"
            break
        case 5:
            cell.titleLabel.text = "本周票房榜"
            break
        case 6:
            break
        default:
            break
        }
        
        cell.tag = indexPath.row
        cell.dataCollectionView.reloadData()
        
        return cell
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
