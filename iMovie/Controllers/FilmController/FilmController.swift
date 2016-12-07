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
    case HotShow = 2
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
            self?.top250CollectionView.reloadData()
            
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
    
    /// 豆瓣口碑榜250名 CollectionView
    fileprivate lazy var top250CollectionView: UICollectionView = {
        
        var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3.0
        
        let top250CollectionView: UICollectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        top250CollectionView.delegate = self
        top250CollectionView.dataSource = self
        top250CollectionView.tag = CollectionViewType.Top250.rawValue
        top250CollectionView.isPagingEnabled = true
        top250CollectionView.backgroundColor = UIColor.white
        
        return top250CollectionView
    }()
}

extension FilmController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView.tag == CollectionViewType.Top250.rawValue) {
            return top250MovieModelArray.count
        } else if (collectionView.tag == CollectionViewType.HotShow.rawValue) {
            
        }
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MovieViewCell.cellWithCollectionView(collectionView, indexPath: indexPath)
        cell.model = top250MovieModelArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConstant.IMAGE_WIDTH + 10, height: UIConstant.IMAGE_HEIGHT + 30)
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
            return UIConstant.IMAGE_HEIGHT + 70
            
        } else if indexPath.row == 3 {
            
        } else if indexPath.row == 4 {
            
        } else if indexPath.row == 5 {
            
        } else if indexPath.row == 6 {
            
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewIdentifier") as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "FilmTableViewIdentifier")
        }
        
        if (indexPath.row == 0) {
            // 正在上映
        } else if (indexPath.row == 1) {
            // 即将上映
        } else if (indexPath.row == 2) {
            // 豆瓣Top250
            top250CollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: "MovieViewCell")
            cell?.contentView.addSubview(self.top250CollectionView)
            self.top250CollectionView.frame = (cell?.contentView.frame)!
            
        } else if (indexPath.row == 3) {
            // 本周口碑榜
        } else if (indexPath.row == 4) {
            // 新片榜
        } else if (indexPath.row == 5) {
            // 票房榜
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
