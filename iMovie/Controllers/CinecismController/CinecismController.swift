//
//  CinecismController.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class CinecismController: BasePageController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.cincismTableView)
        setupLayout()
        getData(num: 0)
    }
    
    
    //MARK:--- Private Methods ---
    func getData(num: NSInteger) {
        
        IMovie.shareInstance.getCineCism(target: IMovieService.movie_cincism(0, 20), successHandle: { [weak self] (data) in
            
            debugPrint("GET Cincism DATA...SUCCESS")
            //debugPrint(data)
            self?.cincismModel = data
            self?.cincismTableView.reloadData()
            
            }, errorHandle: { (error) in
                
        })
    }
    
    func setupLayout() {
        self.cincismTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK:---Getter and Setter---
    fileprivate lazy var cincismTableView: UITableView = {
        let cincismTableView: UITableView = UITableView()
        cincismTableView.delegate = self
        cincismTableView.dataSource = self
        cincismTableView.separatorStyle = .none
        
        return cincismTableView
    }()
    
    fileprivate lazy var cincismModel: CincismModel = {
        let cincismModel: CincismModel = CincismModel(dic: nil)
        return cincismModel
    }()
}

extension CinecismController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstant.SCREEN_WIDTH * 0.5 + 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CinecismTableViewCell.cellWithTableView(tableView)
        cell.model = self.cincismModel.reviews[indexPath.row]
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cincismModel.reviews.count
    }
}
