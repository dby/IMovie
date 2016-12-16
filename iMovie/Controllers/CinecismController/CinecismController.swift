//
//  CinecismController.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class CinecismController: BasePageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        pullToRefresh.delegate = self
        
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    //MARK:--- Private Methods ---
    func getData(num: NSInteger = 0) {
        isRefreshing = true
        
        IMovie.shareInstance.getBestCineCism(target: IMovieService.movieBestCincism(self.page*pageCount, pageCount), successHandle: { [weak self] (data) in
            
            debugPrint("GET Cincism DATA...SUCCESS")
            
            if self?.page == 0 {
                self?.page = 0
                self?.reviewModelArray.removeAll()
            }
            // 添加数据
            data.reviews.forEach {
                self?.reviewModelArray.append($0)
            }
            
            self?.page = (self?.page)! + 1
            self?.isRefreshing = false
            self?.tableView.reloadData()
            self?.pullToRefresh.endRefresh()
            
            }, errorHandle: { (error) in
                
        })
    }
    
    // 存放影评数组
    var reviewModelArray = Array<ReviewModel>()
    let pageCount: Int = 20
}

extension CinecismController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController: DetailCincismController = DetailCincismController()
        detailController.uid = self.reviewModelArray[indexPath.row].id
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CinecismTableViewCell.estimateCellHeight(self.reviewModelArray[indexPath.row].abstract,
                                                        font: UIFont.customFont_FZLTXIHJW(fontSize: 14))
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CinecismTableViewCell.cellWithTableView(tableView)
        cell.model = self.reviewModelArray[indexPath.row]
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewModelArray.count
    }
}

//MARK:---下拉刷新更多---
extension CinecismController : PullToRefreshDelegate {
    func pullToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        getData()
    }
}

// MARK: - 上拉加载更多
extension CinecismController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        super.scrollViewDidScroll(scrollView)
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                getData(num: page)
            }
        }
    }
}
