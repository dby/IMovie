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
    
    /// 获得豆瓣电影前250名
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
    /// 获得最受欢迎的影评
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
    /// 获得某一详细影评
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
    /// 获得某一影评的评论
    func getCinCismConments(target: IMovieService, successHandle: ((_ data: CommentsModel) -> Void)?, errorHandle: ((Swift.Error) -> Void)?) {
        iMovieProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        //debugPrint(json)
                        let data: CommentsModel = CommentsModel(dict: json as NSDictionary?)
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
    /// 获得电影首页的信息
    func getMovieModules(target: IMovieService, successHandle: ((_ data: ModulesModel) -> Void)?, errorHandle: ((Swift.Error) -> Void)?)  {
        iMovieProvider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        //debugPrint(json)
                        let data: ModulesModel = ModulesModel(dict: json as NSDictionary?)
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
