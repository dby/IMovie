//
//  MainViewController.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    //MARK: --- lift cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initMainUI()
    }
    
    func initMainUI() {
        self.viewControllers = [cinecismController, boxOfficeController, filmController, searchController]
        
        cinecismController.tabBarItem = UITabBarItem(title: "影评", image: nil, selectedImage: nil)
        boxOfficeController.tabBarItem = UITabBarItem(title: "票房", image: nil, selectedImage: nil)
        filmController.tabBarItem = UITabBarItem(title: "电影", image: nil, selectedImage: nil)
        searchController.tabBarItem = UITabBarItem(title: "搜索", image: nil, selectedImage: nil)
    }
    
    //MARK: --- Getter and Setter ---
    private let filmController = FilmController()
    private let cinecismController = CinecismController()
    private let boxOfficeController = BoxOfficeController()
    private let searchController = SearchController()
    
    //MARK: --- Private Methods ---
}
