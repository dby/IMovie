//
//  FilmController.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

class FilmController: UIViewController {

    // MARK: --- life cycle ---
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }
    
    // MARK: --- Private Methods ---
    func getData(num: NSInteger) {
        
        IMovie.shareInstance.getMovieTop250(target: IMovieService.movie_top_250(0), successHandle: { [unowned self](data) in
            
            debugPrint(data);
            
            }, errorHandle: { (error) in
                
        })
    }
    
}
