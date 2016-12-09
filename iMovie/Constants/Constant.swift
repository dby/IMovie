//
//  Constant.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import UIKit

struct UIConstant {
    
    static let SCREEN_WIDTH: CGFloat  = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    // 导航栏高度
    static let UI_NAV_HEIGHT : CGFloat = 64
    // tab高度
    static let UI_TAB_HEIGHT : CGFloat = 49
    
    // 间距
    static let UI_MARGIN_5 : CGFloat = 5
    static let UI_MARGIN_10 : CGFloat = 10
    static let UI_MARGIN_12 : CGFloat = 12
    static let UI_MARGIN_15 : CGFloat = 15
    static let UI_MARGIN_20 : CGFloat = 20
    
    // 颜色 首页灰色
    static let UI_COLOR_GrayTheme: UIColor = UIColor(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
    static let UI_COLOR_RedTheme: UIColor  = UIColor(red: 221/255.0, green: 64/255.0, blue: 43/255.0, alpha: 1)
    
}

// 字体常量
struct FontConstant {
    static let SYS_12 : UIFont = UIFont.systemFont(ofSize: 12)
    static let SYS_13 : UIFont = UIFont.systemFont(ofSize: 13)
    static let SYS_14 : UIFont = UIFont.systemFont(ofSize: 14)
    static let SYS_16 : UIFont = UIFont.systemFont(ofSize: 16)
    static let SYS_20 : UIFont = UIFont.systemFont(ofSize: 20)
    static let SYS_22 : UIFont = UIFont.systemFont(ofSize: 22)
}

struct MovieConstant {
    // 海报宽、高
    static let IMAGE_WIDTH = (UIConstant.SCREEN_WIDTH - 75) / 2
    static let IMAGE_HEIGHT = IMAGE_WIDTH * 2993.0 / 2000.0
    // 电影名字
    static let TitleHeight: CGFloat  = 30
    // 电影评分
    static let RatingHeight: CGFloat = 20
    // button---查看更多
    static let BarHeight: CGFloat = 30 + 30
    // MovieView 距离左侧的大小
    static let LeftEdge: CGFloat = 30
    // 底部留白
    static let BottomSpace: CGFloat = 30
}
