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
