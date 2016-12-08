//
//  MainViewController.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

/**
 控制器状态， 缩小-放大
 */
enum ControllerStatus {
    case full
    case small
}

class MainViewController: UIViewController {
    
    //MARK: --- lift cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        initRootViewController()
        
        self.view.addSubview(menuController.view)
        self.view.addSubview(scrollView)
        //        self.view.addSubview(fpsLabel)
        // 添加标题和红线
        self.view.addSubview(headerView)
        self.view.addSubview(redLine)
        // 添加两个菜单切换按钮
        self.view.addSubview(menuBtn)
        self.view.addSubview(classifyBtn)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return statusBarStyle
    }
    
    override var prefersStatusBarHidden : Bool {
        return statusBarHidden
    }
    
    override var preferredStatusBarUpdateAnimation : UIStatusBarAnimation {
        return .slide
    }
    
    //MARK: --- Private Methods ---
    
    //MARK: --- Getter and Setter ---
    fileprivate let filmController = FilmController()
    fileprivate let cinecismController = CinecismController()
    fileprivate let boxOfficeController = BoxOfficeController()
    fileprivate let searchController = SearchController()
    fileprivate let menuController = MenuViewController()
    
    fileprivate var viewArray = [UIView]()
    fileprivate var coverBtnArray = [UIButton]()
    
    /// 缩放值
    fileprivate let scale: CGFloat = 0.4
    /// 状态栏相关
    fileprivate var statusBarStyle: UIStatusBarStyle = .lightContent
    fileprivate var statusBarHidden: Bool = true
    /// 默认是填充状态
    fileprivate var vcState = ControllerStatus.full
    
    fileprivate lazy var headerView: MainHeaderView = {
        var headerView: MainHeaderView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: 5*UIConstant.SCREEN_WIDTH, height: 20))
        return headerView
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    /// 菜单按钮
    fileprivate lazy var menuBtn : UIButton = {
        let menuBtn = UIButton()
        menuBtn.setImage(UIImage(named:"ic_hamburg"), for: UIControlState())
        //menuBtn.addTarget(self, action: #selector(MainViewController.menuBtnDidClick(_:)), for: .touchUpInside)
        return menuBtn
    }()
    
    /// 首页分类按钮
    fileprivate lazy var classifyBtn: UIButton = {
        let classifyBtn = UIButton()
        classifyBtn.setImage(UIImage(named: "ic_circle"), for: UIControlState())
        //classifyBtn.addTarget(self, action: #selector(MainViewController.classifyBtnDidClick), for: .touchUpInside)
        return classifyBtn
    }()
    
    /// 顶部红线
    fileprivate lazy var redLine: UIView = {
        let redLine = UIView()
        redLine.frame = CGRect(x: self.view.center.x - 20, y: 0, width: 40, height: 1)
        redLine.backgroundColor = UIConstant.UI_COLOR_RedTheme
        return redLine
    }()
}

// MARK: - 这里处理collectionview左右滑动时的一些动画（头部控件位移差，菜单分类按钮）
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 这里设置hidden是为了处理下拉刷新的判断
        if vcState == .full {
            // 处理分类按钮左右滑动时淡入淡出动画
            let contentoffx = scrollView.contentOffset.x
            let alpha = 1 - fabs((contentoffx-UIConstant.SCREEN_WIDTH) / UIConstant.SCREEN_WIDTH)
            classifyBtn.isHidden = alpha <= 0 ?true: false
            classifyBtn.alpha = alpha
            // 设置头部空间位移差
            let scale = self.view.width/(self.view.width*0.5-headerView.labelArray.last!.width*0.5)
            headerView.x = -scrollView.contentOffset.x/scale
            
        }
    }
    
}

// MARK: - 初始化控件
extension MainViewController {
    fileprivate func initRootViewController() {
        filmController.scrollViewReusableDataSource = self
        cinecismController.scrollViewReusableDataSource = self
        boxOfficeController.scrollViewReusableDataSource = self
        searchController.scrollViewReusableDataSource = self
        
        filmController.scrollViewReusableDelegate = self
        cinecismController.scrollViewReusableDelegate = self
        boxOfficeController.scrollViewReusableDelegate = self
        searchController.scrollViewReusableDelegate = self
        
        menuController.view.frame = self.view.bounds
        self.addChildViewController(menuController)
        self.addChildViewController(cinecismController)
        self.addChildViewController(boxOfficeController)
        self.addChildViewController(filmController)
        self.addChildViewController(searchController)
        
        viewArray.append(cinecismController.view)
        viewArray.append(boxOfficeController.view)
        viewArray.append(filmController.view)
        viewArray.append(searchController.view)
        
        for i in 0..<viewArray.count {
            let view = viewArray[i]
            view.frame = CGRect(x: CGFloat(i)*self.view.width, y: 0, width: scrollView.width, height: scrollView.height)
            scrollView.addSubview(view)
        }
        scrollView.contentSize = CGSize(width: CGFloat(viewArray.count)*scrollView.width, height: 0)
        
        scrollView.setContentOffset(CGPoint(x: scrollView.width, y: 0), animated: false)
    }
}


// MARK: - 这里传headerView给下拉刷新控件做处理
extension MainViewController: ScrollViewControllerReusableDataSource {
    func titleHeaderView() -> MainHeaderView {
        return self.headerView
    }
    
    func redLineView() -> UIView {
        return self.redLine
    }
    
    func menuButton() -> UIButton {
        return self.menuBtn
    }
    
    func classifyButton() -> UIButton {
        return self.classifyBtn
    }
}

//MARK: ------------ ScrollView上下滚动方向改变时调用，用于处理菜单按钮和分类按钮的动画 -----------
extension MainViewController: ScrollViewControllerReusableDelegate {
    func ScrollViewControllerDirectionDidChange(_ direction: ScrollViewDirection) {
        MenuBtnAnimation(direction)
    }
    
    /**
     菜单按钮动画
     */
    fileprivate func MenuBtnAnimation(_ dir: ScrollViewDirection) {
        // 位移
        let positionAnim = CABasicAnimation(keyPath: "position.y")
        positionAnim.fromValue = (dir == ScrollViewDirection.down ?classifyBtn.y:-classifyBtn.height)
        // 这里不知为何要加上状态栏20高度
        positionAnim.toValue = (dir == ScrollViewDirection.down ?(-classifyBtn.height):classifyBtn.y+20)
        
        // alpha
        let alphaAnim = CABasicAnimation(keyPath: "alpha")
        alphaAnim.fromValue = (dir == ScrollViewDirection.down ?1:0)
        alphaAnim.toValue = (dir == ScrollViewDirection.down ?0:1)
        
        let group = CAAnimationGroup()
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        group.animations = [positionAnim, alphaAnim]
        group.duration = 0.2
        
        classifyBtn.layer.add(group, forKey: "circleButtonDownAnimation")
        menuBtn.layer.add(group, forKey: "hamburgButtonAnimation")
    }
}
