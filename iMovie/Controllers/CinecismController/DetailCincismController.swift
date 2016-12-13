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
        self.view.addSubview(self.wkWebView)
        self.view.addSubview(self.headerBackView)
        self.view.addSubview(self.toolBar)
        
        setupLayout()
        
        getData(uid: self.uid)
    }
    
    //MARK:--- Private Methods ---
    func getData(uid: String) {
        
        IMovie.shareInstance.getDetailCineCism(target: IMovieService.movieDetailCincism(uid), successHandle: { [weak self] (data) in
            
            debugPrint("GET Detail Cincism DATA...SUCCESS")
            self?.model = data
            self?.wkWebView.loadHTMLString(data.content, baseURL: nil)
            
            }, errorHandle: { (error) in
                
        })
    }
    
    fileprivate func setupLayout() {
        self.wkWebView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.headerBackView.snp.bottom)
            make.bottom.equalTo(self.toolBar.snp.top)
        }
        
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

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    //MARK:---Getter and Setter---
    public var uid: String = ""
    
    internal var shadowView: UIView?
    internal var shareView: ShareView?
    
    fileprivate var lastPosition: CGFloat = 0
    fileprivate var headerTopConstraint: Constraint? = nil
    fileprivate var naviTitle: String!
    
    fileprivate var model: DetailCincismModel?
    
    /// wkWebView
    fileprivate lazy var wkWebView: WKWebView = {
        let wkWebView: WKWebView = WKWebView()
        wkWebView.navigationDelegate    = self
        wkWebView.scrollView.delegate   = self
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

extension DetailCincismController: HeaderViewDelegate {
    func backButtonDidClick() {
        _ = self.navigationController?.popViewController(animated: true)
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
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.showProgress()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hiddenProgress()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPosition: CGFloat = scrollView.contentOffset.y
        if currentPosition - self.lastPosition > 30 && currentPosition > 0 {
            self.headerTopConstraint?.update(offset: -50)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBackView.layoutIfNeeded()
            })
            
            self.lastPosition = currentPosition
            
        } else if self.lastPosition - currentPosition > 10 {
            self.headerTopConstraint?.update(offset: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.headerBackView.layoutIfNeeded()
            })
            self.lastPosition = currentPosition
        }
    }
}
