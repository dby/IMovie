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
    // 字体
    static let UI_FONT_12 : UIFont = UIFont.systemFont(ofSize: 12)
    static let UI_FONT_13 : UIFont = UIFont.systemFont(ofSize: 13)
    static let UI_FONT_14 : UIFont = UIFont.systemFont(ofSize: 14)
    static let UI_FONT_16 : UIFont = UIFont.systemFont(ofSize: 16)
    static let UI_FONT_20 : UIFont = UIFont.systemFont(ofSize: 20)
    static let UI_FONT_22 : UIFont = UIFont.systemFont(ofSize: 22)
    // 间距
    static let UI_MARGIN_5 : CGFloat = 5
    static let UI_MARGIN_10 : CGFloat = 10
    static let UI_MARGIN_12 : CGFloat = 12
    static let UI_MARGIN_15 : CGFloat = 15
    static let UI_MARGIN_20 : CGFloat = 20
    
    // 颜色 首页灰色
    static let UI_COLOR_GrayTheme: UIColor = UIColor(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: 1)
    static let UI_COLOR_RedTheme: UIColor = UIColor(red: 221/255.0, green: 64/255.0, blue: 43/255.0, alpha: 1)
    
}

struct MovieConstant {
    // 海报宽、高
    static let IMAGE_WIDTH = (UIConstant.SCREEN_WIDTH - 75) / 2
    static let IMAGE_HEIGHT = IMAGE_WIDTH * 2993.0 / 2000.0
    // 电影名字
    static let MovieTitleHeight: CGFloat  = 30
    // 电影评分
    static let MovieRatingHeight: CGFloat = 20
    // button---查看更多
    static let MovieBarHeight: CGFloat = 30
}
