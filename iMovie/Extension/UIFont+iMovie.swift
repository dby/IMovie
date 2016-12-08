//
//  UIFont+iMovie.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

extension UIFont {
    /**
     自定义字体
     */
    class func customFont_DINPro(fontSize size : CGFloat) -> UIFont {
        return UIFont(name: "DINPro", size: size)!
    }
    
    /**
     自定义字体 -- 粗体
     */
    class func customFont_FZLTZCHJW(fontSize size : CGFloat) -> UIFont {
        return UIFont(name: "FZLanTingHeiS-DB1-GB", size: size)!
    }
    
    /**
     自定义字体 - 细体
     */
    class func customFont_FZLTXIHJW(fontSize size : CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size) //UIFont(name: "FZLanTingHeiS-L-GB", size: size)!
    }
}
