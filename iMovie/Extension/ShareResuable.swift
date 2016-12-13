//
//  ShareResuable.swift
//  iMovie
//
//  Created by sys on 2016/12/12.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import MonkeyKing

public protocol ShareResuable: ShareViewDelegate {
    var shareView: ShareView? {get set}
    var shadowView: UIView? {get set}
}
extension ShareResuable where Self: UIViewController {
    // 隐藏分享的View
    func hiddenShareView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.shadowView!.alpha = 0
            self.shareView!.center.y += 170
        }, completion: { (true) in
            self.shadowView!.removeFromSuperview()
            self.shareView!.removeFromSuperview()
        })
    }
    
    // 展现分享的View
    func showShareView() {
        
        let window: UIWindow = UIApplication.shared.keyWindow!
        
        self.shareView = ShareView(frame: CGRect(x: 0, y: UIConstant.SCREEN_HEIGHT, width: UIConstant.SCREEN_WIDTH, height: UIConstant.SCREEN_HEIGHT))
        self.shareView!.delegate = self
        
        self.shadowView = UIView(frame: self.view.frame)
        self.shadowView!.alpha = 0
        self.shadowView!.backgroundColor = UIColor.black
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hiddenShareView))
        //self.shadowView!.addGestureRecognizer(tapGesture)
        
        window.addSubview(self.shadowView!)
        window.addSubview(self.shareView!)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.shadowView!.alpha = 0.5
            self.shareView!.center.y -= 170
        })
    }
    
    func shareToFriend(_ shareContent: String, shareImageUrl: String, shareUrl: String, shareTitle: String)  {
        do {
            let message = try MonkeyKing.Message.weChat(.session(info: (
                title: shareTitle,
                description: shareContent,
                thumbnail: UIImage.init(data:Data(contentsOf:URL(string:shareImageUrl)!)),
                media: .url(URL(string: shareUrl)!))))
            
            MonkeyKing.deliver(message) { success in
                print("shareURLToWeChatSession success: \(success)")
            }
        } catch _ {
            
        }
    }
    
    func shareToFriendsCircle(_ shareContent: String, shareTitle: String, shareUrl: String, shareImageUrl: String) {
        
        do {
            
            let message = try MonkeyKing.Message.weChat(.timeline(info: (
                title: shareTitle,
                description: shareContent,
                thumbnail: UIImage.init(data:Data.init(contentsOf:URL.init(string:shareImageUrl)!)),
                media: .url(URL(string: shareUrl)!))))
            
            MonkeyKing.deliver(message) { (result) in
                print("share to TimeLine Success:\(result)...")
            }
        } catch _ {
            
        }
    }
}
