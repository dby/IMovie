//
//  DetailCincismController.swift
//  iMovie
//
//  Created by sys on 2016/12/12.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class DetailCincismController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.detailCincismTableView)
        self.view.addSubview(self.headerBackView)
        self.view.addSubview(self.toolBar)
        
        setupLayout()
        
        getCinCismData(uid: self.uid)
        //getCincismComments(uid: self.uid)
    }
    
    //MARK:--- Private Methods ---
    /// 获得影评信息
    func getCinCismData(uid: String) {
        isRefreshing = true
        IMovie.shareInstance.getDetailCineCism(target: IMovieService.movieDetailCincism(uid), successHandle: { [weak self] (data) in
            
            debugPrint("GET Detail Cincism DATA...SUCCESS")
            
            self?.isRefreshing = false
            self?.model = data
            self?.updateUI()
            
            }, errorHandle: { (error) in
                self.isRefreshing = false
                print(error)
        })
    }
    /// 获得影评评论信息
    func getCincismComments(uid: String) {
        
        if self.commentsData.comments.count != 0 && self.commentsData.comments.count >= self.commentsData.total {
            self.endRefreshing()
            return
        }
        self.isRefreshing = true
        IMovie.shareInstance.getCinCismConments(target: IMovieService.cincismComment(uid, self.commentsData.comments.count, 10), successHandle: { [weak self] (data) in
            
            //debugPrint(data)
            //debugPrint("请求成功...")
            
            if (data.total == 0) {
                
                self?.endRefreshing()
                
            } else {
                self?.isRefreshing = false
                self?.commentsData.total = data.total
                self?.commentsData.count = (self?.commentsData.comments.count)! + data.count
                data.comments.forEach({ (item) in
                    self?.commentsData.comments.append(item)
                })
                self?.detailCincismTableView.reloadData()
                
            }
        }) { (error) in
            self.isRefreshing = false
            print(error)
        }
    }
    
    fileprivate func setupLayout() {
        
        self.toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        self.headerBackView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            self.headerTopConstraint = make.top.equalTo(self.view).constraint
            make.height.equalTo(50)
        }
    }

    fileprivate func endRefreshing() {
        for item in self.refreshFootView.subviews {
            if item is ActivityIndicatorView {
                item.alpha = 0
            }
            
            if item is UILabel {
                item.alpha = 1
            }
        }
    }
    
    func updateUI() {
        
        if let model = self.model {
            
            if let _ = model.subject {
                let dic: Dictionary<String, String> = [
                    "title": model.title,
                    "authorID" : model.id,
                    "authorName" : model.subject.title,
                    "timeInterval" : model.create_time,
                    "content" : model.content
                ]
            
                self.wkWebView.loadHTMLString(model.content.HtmlWithData(data: dic as NSDictionary, templateName: "article"), baseURL: Bundle.main.resourceURL)
            
                self.tableHeaderView.model = model
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK:---Getter and Setter---
    public var uid: String = ""
    
    /// ShareViewDelegate中定义的字段
    internal var shadowView: UIView?
    internal var shareView: ShareView?
    
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT - (50) + 20
    var differY: CGFloat = 0
    /// 是否正在刷新
    var isRefreshing: Bool = false
    
    fileprivate var naviTitle: String!
    fileprivate var lastPosition: CGFloat = -50
    fileprivate var headerTopConstraint: Constraint? = nil
    
    fileprivate var model: DetailCincismModel?
    fileprivate lazy var commentsData: CommentsModel = {
        var commentsData: CommentsModel = CommentsModel(dict: nil)
        commentsData.start = 0
        commentsData.count = 0
        commentsData.total = 0
        return commentsData
    }()
    
    /// CincismHeaderView
    fileprivate lazy var tableHeaderView: CincismHeaderView = {
        let tableHeaderView: CincismHeaderView = CincismHeaderView(frame: CGRect.init(x: 0,
                                                                                      y: 0,
                                                                                      width: UIConstant.SCREEN_WIDTH,
                                                                                      height: UIConstant.SCREEN_WIDTH*0.5))
        
        return tableHeaderView
    }()
    /// RefreshFootView
    fileprivate lazy var refreshFootView: UIView = {
        
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25) )
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x: self.view.center.x, y: 25)
        activityView.startAnimation()
        
        let infoLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 20, width: UIConstant.SCREEN_WIDTH, height: 25))
        infoLabel.textAlignment = .center
        infoLabel.text = "没有更多的评论"
        infoLabel.font = UIFont.customFont_DINPro(fontSize: 14)
        infoLabel.alpha = 0
        
        let footView = UIView()
        footView.origin = CGPoint.zero
        footView.size = CGSize(width: UIConstant.SCREEN_WIDTH, height: 50)
        footView.addSubview(infoLabel)
        footView.addSubview(activityView)
        return footView
        
    }()
    /// TableView
    fileprivate lazy var detailCincismTableView: UITableView = {
        let detailCincismTableView: UITableView = UITableView(frame: self.view.frame)
        detailCincismTableView.delegate = self
        detailCincismTableView.dataSource = self
        detailCincismTableView.separatorStyle = .none
        
        detailCincismTableView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0)
        detailCincismTableView.tableHeaderView = self.tableHeaderView
        detailCincismTableView.tableFooterView = self.refreshFootView
        detailCincismTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellIdentifier")
        
        return detailCincismTableView
    }()
    /// WKWebView
    fileprivate lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 1))
        wkWebView.navigationDelegate    = self
        wkWebView.scrollView.delegate   = self
        wkWebView.scrollView.bounces = false
        wkWebView.scrollView.maximumZoomScale = 1.0
        wkWebView.scrollView.minimumZoomScale = 1.0
        wkWebView.scrollView.bouncesZoom = false
        wkWebView.scrollView.isScrollEnabled = false
        wkWebView.scrollView.showsVerticalScrollIndicator = false
        wkWebView.scrollView.showsHorizontalScrollIndicator = false
        
        return wkWebView
    }()
    /// 底部工具栏
    fileprivate lazy var toolBar: BottomToolsBar = {
        let toolBar: BottomToolsBar = BottomToolsBar()
        toolBar.delegate = self
        return toolBar
    }()
    /// 顶部返回栏
    fileprivate lazy var headerBackView: HeaderBackView = {
        let headerBackView: HeaderBackView = HeaderBackView(title: "影评")
        headerBackView.delegate = self
        return headerBackView
    }()
}

//MARK:---HeaderViewDelegate
extension DetailCincismController: HeaderViewDelegate {
    func backButtonDidClick() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

//MARK:---TableViewDelegate TableViewDataSource
extension DetailCincismController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.commentsData.comments.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // 此时为 WKWebview，，
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellIdentifier", for: indexPath)
            cell.selectionStyle = .none
        
            //debugPrint("cell.height: \(cell.height)")
            self.wkWebView.frame = CGRect(x: 0, y: 0, width: cell.width, height: cell.height)
            cell.contentView.addSubview(self.wkWebView)
        
            return cell
        }
        else {
            // 此时加载评论
            var cell: CommentTableViewCell? = nil
            
            if (self.commentsData.comments[indexPath.row].ref_comment == nil) {
                cell = CommentTableViewCell.cellWithTableView(tableView, hasRefComment: false)
            } else {
                cell = CommentTableViewCell.cellWithTableView(tableView, hasRefComment: true)
            }
            
            cell?.model = self.commentsData.comments[indexPath.row]
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //debugPrint("heightForRowAt: \(self.wkWebView.height)")
        if indexPath.section == 0 {
            return self.wkWebView.height
        } else {
            return CommentTableViewCell.estimateCellHeight(self.commentsData.comments[indexPath.row],
                                                           font: UIFont.customFont_DINPro(fontSize: 14),
                                                           size: CGSize(width: UIConstant.SCREEN_WIDTH - 60, height: 2000))
        }
    }
}

//MARK:-----ShareViewDelegate-----
extension DetailCincismController: ShareViewDelegate, ShareResuable {
    
    func weixinShareButtonDidClick() {
        
        let tmp: [String] = (model?.subject.pic.normal.components(separatedBy: "?"))!
        let imageUrl = tmp[0]
        
        shareToFriend((model?.abstract)!,
                      shareImageUrl: imageUrl,
                      shareUrl: (model?.sharing_url)!,
                      shareTitle: (model?.title)!)
    }
    
    func friendsCircleShareButtonDidClick() {
        shareToFriendsCircle((model?.abstract)!,
                             shareTitle: (model?.title)!,
                             shareUrl: (model?.sharing_url)!,
                             shareImageUrl: (model?.subject.pic.normal)!)
    }
    
    func shareMoreButtonDidClick() {
        hiddenShareView()
    }
}

//MARK:-----ToolBarDelegate-----
extension DetailCincismController: ToolBarDelegate {
    
    func editCommentDidClick() {
        debugPrint("editCommon")
    }
    
    func praiseButtonDidClick() {
        if self.toolBar.praiseButton.isSelected {
            self.toolBar.praiseButton.isSelected = false
        } else {
            self.toolBar.praiseButton.isSelected = true
        }
    }
    
    func shareButtonDidClick() {
        self.showShareView()
    }
    
    func commentButtonDidClick() {
        //let ifDetailCommentVC = IFDetailCommentVC(id: model?.ID)
        //self.navigationController?.pushViewController(ifDetailCommentVC, animated: true)
    }
}

//MARK:-----WebViewDelegate UIScrollViewDelegate-----
extension DetailCincismController: WKNavigationDelegate, UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //self.hiddenProgress()
        
        webView.evaluateJavaScript("document.body.scrollWidth") { (result, error) in
            let ratio: CGFloat = webView.frame.width / (result as! CGFloat)
            
            /// 获取html动态高度
            webView.evaluateJavaScript("document.body.offsetHeight") { (result, error) in
                if error == nil {
                    //debugPrint("result: \(result) ratio:\(ratio)")
                    var newFrame = webView.frame
                    newFrame.size.height = (result as! CGFloat) * ratio
                    webView.frame = newFrame
                    
                    self.detailCincismTableView.reloadData()
                    
                    //KVO监听网页内容高度变化
                    self.wkWebView.scrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
                }
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let newHeight = self.wkWebView.scrollView.contentSize.height
        //debugPrint("newHeight: \(newHeight)")
        
        var newFrame = self.wkWebView.frame
        newFrame.size.height = newHeight
        self.wkWebView.frame = newFrame
        
        self.detailCincismTableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition: CGFloat = scrollView.contentOffset.y
        
        // 计算contentsize与offset的差值
        let contentSizeY = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        differY = contentSizeY - contentOffsetY
        if differY < happenY {
            if !isRefreshing {
                // 这里处理上拉加载更多
                if self.model == nil {
                    self.getCinCismData(uid: self.uid)
                } else {
                    self.getCincismComments(uid: self.uid)
                }
            }
        }
        
        if currentPosition - self.lastPosition > 0 && currentPosition > 10 {
            self.headerTopConstraint?.update(offset: -50)
            
            UIView.animate(withDuration: 5, animations: {
                self.headerBackView.layoutIfNeeded()
            })
            
            self.lastPosition = currentPosition
            
        } else if self.lastPosition - currentPosition > 10 {
            self.headerTopConstraint?.update(offset: 0)
            UIView.animate(withDuration: 5, animations: {
                self.headerBackView.layoutIfNeeded()
            })
            self.lastPosition = currentPosition
        }
    }
}
