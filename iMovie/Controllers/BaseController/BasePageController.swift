//
//  BasePageController.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

class BasePageController: UIViewController, ScrollViewControllerReusable {
    
    //MARK: --------------------------- life cycle --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        setupTableView()
        setupPullToRefreshView()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var tableView: UITableView!
    /// 下拉刷新
    var pullToRefresh: PullToRefreshView!
    /// 下拉刷新代理
    var scrollViewReusableDataSource: ScrollViewControllerReusableDataSource!
    var scrollViewReusableDelegate: ScrollViewControllerReusableDelegate!
    
    /// 是否正在刷新
    var isRefreshing = false
    /// 记录当前列表页码
    var page = 1
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0
    
    /// scrollView方向
    var direction: ScrollViewDirection! = ScrollViewDirection.none
    var lastContentOffset: CGFloat = 0
}


extension BasePageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 计算contentsize与offset的差值
        let contentSizeY = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        differY = contentSizeY-contentOffsetY
        
        // 判断滚动方向
        if contentOffsetY > 0 {
            ChangeScrollViewDirection(contentOffsetY)
        }
    }
    
    /**
     判断滚动方向
     */
    fileprivate func ChangeScrollViewDirection(_ contentOffsetY: CGFloat) {
        //        print("contentoffsety:\(contentOffsetY)     last: \(lastContentOffset)   dir: \(direction)")
        
        if contentOffsetY > lastContentOffset {
            lastContentOffset = contentOffsetY
            guard direction != .down else {
                return
            }
            scrollViewReusableDelegate.ScrollViewControllerDirectionDidChange(.down)
            
            direction = .down
            
        } else if lastContentOffset > contentOffsetY {
            lastContentOffset = contentOffsetY
            guard direction != .up else {
                return
            }
            scrollViewReusableDelegate.ScrollViewControllerDirectionDidChange(.up)
            
            direction = .up
        }
    }
}
