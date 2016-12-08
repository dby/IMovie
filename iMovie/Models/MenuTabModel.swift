//
//  MenuTabModel.swift
//  iMovie
//
//  Created by sys on 2016/12/8.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

struct MenuTabModel {
    let image: UIImage
    let title: String
}

let MenuTabItems = [
    MenuTabModel(image: UIImage(named: "ic_login")!, title: "马上登录"),
    MenuTabModel(image: UIImage(named: "ic_report")!, title: "寻求报道"),
    MenuTabModel(image: UIImage(named: "ic_about")!, title: "关于爱范儿")
]
