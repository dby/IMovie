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
    // 豆瓣电影前250名
    case Top250  = 1
    case NowHotShow = 2
    case SoonShow = 3
}

class FilmController: UIViewController, Reusable {

    //MARK: --- life cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        setupLayout()
        
        getData(num: 0)
    }
    
    //MARK: --- Private Methods ---
    func getData(num: NSInteger) {
        
        IMovie.shareInstance.getMovieTop250(target: IMovieService.movie_top_250(num), successHandle: { [weak self] (data) in
            
            for item in data.subject_collection_items {
                self?.top250MovieModelArray.append(item)
            }
            
            self?.tableView.reloadData()
            self?.nowHotShowCollectionView.reloadData()
            self?.soonShowCollectionView.reloadData()
            self?.top250CollectionView.reloadData()
            self?.praiseListWeek.reloadData()
            self?.newMovieListCollectionView.reloadData()
            self?.boxOfficeListCollectionView.reloadData()
            
            }, errorHandle: { (error) in
                
        })
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: --- Getter and Setter ---
    
    var top250MovieModelArray = Array<MovieModel>()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    /// 正在热映 CollectionView
    fileprivate lazy var nowHotShowCollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let nowHotShowCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        nowHotShowCollectionView.bounces = false
        nowHotShowCollectionView.delegate = self
        nowHotShowCollectionView.dataSource = self
        nowHotShowCollectionView.tag = CollectionViewType.NowHotShow.rawValue
        nowHotShowCollectionView.isPagingEnabled = false
        nowHotShowCollectionView.backgroundColor = UIColor.white
        
        return nowHotShowCollectionView
    }()
    
    /// 即将上映 CollectionView
    fileprivate lazy var soonShowCollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let soonShowCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        soonShowCollectionView.bounces = false
        soonShowCollectionView.delegate = self
        soonShowCollectionView.dataSource = self
        soonShowCollectionView.tag = CollectionViewType.NowHotShow.rawValue
        soonShowCollectionView.isPagingEnabled = false
        soonShowCollectionView.backgroundColor = UIColor.white
        
        return soonShowCollectionView

    }()
    
    /// 豆瓣口碑榜250名 CollectionView
    fileprivate lazy var top250CollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let top250CollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        top250CollectionView.bounces = false
        top250CollectionView.delegate = self
        top250CollectionView.dataSource = self
        top250CollectionView.tag = CollectionViewType.Top250.rawValue
        top250CollectionView.isPagingEnabled = false
        top250CollectionView.backgroundColor = UIColor.white
        
        return top250CollectionView
    }()
    
    /// 本周口碑榜 CollectionView
    fileprivate lazy var praiseListWeek: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let praiseListWeek: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        praiseListWeek.bounces = false
        praiseListWeek.delegate = self
        praiseListWeek.dataSource = self
        praiseListWeek.tag = CollectionViewType.Top250.rawValue
        praiseListWeek.isPagingEnabled = false
        praiseListWeek.backgroundColor = UIColor.white
        
        return praiseListWeek
    }()
    
    /// 新片榜 CollectionView
    fileprivate lazy var newMovieListCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let newMovieListCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        newMovieListCollectionView.bounces = false
        newMovieListCollectionView.delegate = self
        newMovieListCollectionView.dataSource = self
        newMovieListCollectionView.tag = CollectionViewType.Top250.rawValue
        newMovieListCollectionView.isPagingEnabled = false
        newMovieListCollectionView.backgroundColor = UIColor.white
        
        return newMovieListCollectionView
    }()

    /// 本周票房榜 CollectionView
    fileprivate lazy var boxOfficeListCollectionView: UICollectionView = {
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let boxOfficeListCollectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        boxOfficeListCollectionView.bounces = false
        boxOfficeListCollectionView.delegate = self
        boxOfficeListCollectionView.dataSource = self
        boxOfficeListCollectionView.tag = CollectionViewType.Top250.rawValue
        boxOfficeListCollectionView.isPagingEnabled = false
        boxOfficeListCollectionView.backgroundColor = UIColor.white
        
        return boxOfficeListCollectionView
    }()
    
}

extension FilmController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView.tag == CollectionViewType.Top250.rawValue) {
            // 最多显示6个item
            return top250MovieModelArray.count > 6 ? 6 : top250MovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.NowHotShow.rawValue) {
            
        } else if (collectionView.tag == CollectionViewType.SoonShow.rawValue) {
            
        } else {
            
        }
        
        return top250MovieModelArray.count > 6 ? 6 : top250MovieModelArray.count
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
        return CGSize(width: UIConstant.IMAGE_WIDTH, height: UIConstant.IMAGE_HEIGHT)
    }
}

extension FilmController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
        
        } else if indexPath.row == 2 {
            // 豆瓣Top250
            return UIConstant.IMAGE_HEIGHT + 100
            
        } else if indexPath.row == 3 {
            
        } else if indexPath.row == 4 {
            
        } else if indexPath.row == 5 {
            
        } else if indexPath.row == 6 {
            
        }
        
        return UIConstant.IMAGE_HEIGHT + 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewIdentifier") as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FilmTableViewIdentifier")
        }
        
        if (indexPath.row == 0) {
            // 正在上映
            nowHotShowCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(nowHotShowCollectionView)
            nowHotShowCollectionView.frame = (cell?.contentView.frame)!

        } else if (indexPath.row == 1) {
            // 即将上映
            soonShowCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(soonShowCollectionView)
            soonShowCollectionView.frame = (cell?.contentView.frame)!
        } else if (indexPath.row == 2) {
            // 豆瓣Top250
            top250CollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(self.top250CollectionView)
            self.top250CollectionView.frame = (cell?.contentView.frame)!
        } else if (indexPath.row == 3) {
            // 本周口碑榜
            praiseListWeek.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(self.praiseListWeek)
            self.praiseListWeek.frame = (cell?.contentView.frame)!
        } else if (indexPath.row == 4) {
            // 新片榜
            newMovieListCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(self.newMovieListCollectionView)
            self.newMovieListCollectionView.frame = (cell?.contentView.frame)!

        } else if (indexPath.row == 5) {
            // 票房榜
            boxOfficeListCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(self.boxOfficeListCollectionView)
            self.boxOfficeListCollectionView.frame = (cell?.contentView.frame)!

        } else if (indexPath.row == 6) {
            // 推荐
        }
        
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
}

extension FilmController: UIScrollViewDelegate {
    
    func nearestTargetOffsetForOffset(offset: CGPoint) -> CGPoint {
        let pageSize: CGFloat = BUBBLE_DIAMETER + BUBBLE_PADDING
        let page: NSInteger   = NSInteger(roundf(Float(offset.x) / Float(pageSize)))
        let targetX: CGFloat  = CGFloat(Float(pageSize) * Float(page))
        
        return CGPoint.init(x: targetX, y: offset.y)
    }
    
    func snapToNearestItem() {
        let targetOffset: CGPoint = self.nearestTargetOffsetForOffset(offset: self.top250CollectionView.contentOffset)
        self.top250CollectionView.setContentOffset(targetOffset, animated: true)
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
