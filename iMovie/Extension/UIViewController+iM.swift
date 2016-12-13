//
//  UIViewController+iM.swift
//  iMovie
//
//  Created by sys on 2016/12/12.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func showProgress () {
        let progressView = UIActivityIndicatorView()
        progressView.activityIndicatorViewStyle = .gray
        progressView.hidesWhenStopped = true
        progressView.tag = 500
        self.view.addSubview(progressView)
        
        progressView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.width.equalTo(20)
        }
        
        progressView.startAnimating()
    }
    
    func hiddenProgress() {
        for view in self.view.subviews {
            if view.tag == 500 {
                let indicatorView : UIActivityIndicatorView = view as! UIActivityIndicatorView
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }
    }
}
