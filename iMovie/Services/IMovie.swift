//
//  IMovieService.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import Moya

class IMovie {
    /// 单例对象
    static let shareInstance = IMovie()

    fileprivate init() {}
    
    func getMovieTop250(target: IMovieService, successHandle: ((_ data: Top250Model) -> Void)?, errorHandle: ((Swift.Error) -> Void)?) {
        iMovieProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        let data:Top250Model = Top250Model(dict: json as NSDictionary?)
                        
                        if let success = successHandle {
                            success(data);
                        }
                    }

                } catch {
                    print("出现异常")
                }
                break

            case let .failure(error):
                // 错误回调
                if let handle = errorHandle {
                    handle(error)
                }
                break
            }
        }
    }
    
    func getBestCineCism(target: IMovieService, successHandle: ((_ data: CincismModel) -> Void)?, errorHandle: ((Swift.Error) -> Void)?) {
        iMovieProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        let data: CincismModel = CincismModel(dic: json as NSDictionary?)
                        if let success = successHandle {
                            success(data)
                        }
                    }
                    
                } catch {
                    print("出现异常")
                }
                break
                
            case let .failure(error):
                // 错误回调
                if let handle = errorHandle {
                    handle(error)
                }
                break
            }
        }
    }
    
    func getDetailCineCism(target: IMovieService, successHandle: ((_ data: DetailCincismModel) -> Void)?, errorHandle: ((Swift.Error) -> Void)?) {
        iMovieProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        //debugPrint(json)
                        let data: DetailCincismModel = DetailCincismModel(dic: json as NSDictionary?)
                        if let success = successHandle {
                            success(data)
                        }
                    }
                    
                } catch {
                    print("出现异常")
                }
                break
                
            case let .failure(error):
                // 错误回调
                if let handle = errorHandle {
                    handle(error)
                }
                break
            }
        }
    }
}
