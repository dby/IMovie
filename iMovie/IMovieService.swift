//
//  APIConstant.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import Moya

public enum IMovieService {
    
    /// 获得榜豆瓣榜单前250的电影
    case movieTop250(Int)
    /// 最受欢迎 影评
    case movieBestCincism(Int, Int)
    /// 获得某一详细影评
    case movieDetailCincism(String)
    /// 获得某一影评的评价 uid-start-count
    case cincismComment(String, Int, Int)
    /// 电影首页信息
    case movieModules()
    
}

let endpointClosure = { (target: IMovieService) -> Endpoint<IMovieService> in
    
    var URL = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint = Endpoint<IMovieService>(URL: URL,
                                           sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                           method: target.method,
                                           parameters: target.parameters)
    
    return endpoint.endpointByAddingHTTPHeaderFields(["Host": "frodo.douban.com",
                                                      "Accept": "*/*",
                                                      "If-None-Match": "W/\"42a017ab004ecdfb200a45bd5d61a5c5\"",
                                                      "Cookie": "bid=RN2KdUxJiao",
                                                      "User-Agent": "api-client/0.1.3 com.douban.frodo/4.7.0 iOS/10.1.1 iPhone6,2",
                                                      "Accept-Language": "zh-cn"])
}

let iMovieProvider: MoyaProvider<IMovieService> = MoyaProvider<IMovieService>(endpointClosure: endpointClosure)

extension IMovieService: TargetType {
    public var task: Task {
        return .request
    }
    
    fileprivate var loc_id: String {
        return "118371"
    }
    
    fileprivate var count: String {
        return "18"
    }
    
    fileprivate var apikey: String {
        return "0ab215a8b1977939201640fa14c66bab"
    }

    fileprivate var _need_webp: String {
        return "_need_webp"
    }
    
    fileprivate var _sig: String {
        return "kOnS6bgi9nF83VdaO//De1G6shE%3D"
    }
    
    fileprivate var _ts: String {
        return "1481528051"
    }
    
    fileprivate var alt: String {
        return "json"
    }
    
    fileprivate var douban_udid: String {
        return "021392124420da880d7e52af9cbf122d636d5fc5"
    }
    
    fileprivate var event_loc_id: String {
        return "118371"
    }
    
    fileprivate var latitude: String {
        return "0"
    }
    
    fileprivate var longitude: String {
        return "0"
    }
    
    fileprivate var udid: String {
        return "68b1196f23425bbc7ffe4714f9f59f47204dbeed"
    }
    
    fileprivate var version: String {
        return "4.7.0"
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var baseURL: URL {
        
        switch self {
        case .movieTop250(_):
            return URL.init(string: "https://frodo.douban.com/api/v2/subject_collection/")!
        case .movieBestCincism(_, _):
            return URL(string: "https://frodo.douban.com/api/v2/")!
        case .movieDetailCincism(_):
            return URL(string: "https://frodo.douban.com/api/v2/")!
        case .cincismComment(_):
            return URL(string: "https://frodo.douban.com/api/v2/")!
        case .movieModules():
            return URL(string: "https://frodo.douban.com/api/v2/")!
        }
    }
    
    public var path: String {
        switch self {
        case .movieTop250(_):
            return "movie_top250/items"
        case .movieBestCincism(_, _):
            return "movie/best_reviews"
        case let .movieDetailCincism(uid):
            return "review/\(uid)/"
        case let .cincismComment(uid, _, _):
            return "review/\(uid)/comments/"
        case .movieModules():
            return "movie/modules"
        }
    }

    public var parameters: [String : Any]? {
        switch self {
        case let .movieTop250(num):
            return ["loc_id": loc_id as AnyObject,
                    "count": count as AnyObject,
                    "apikey": apikey as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "start": num as AnyObject]
        case let .movieBestCincism(start, count):
            return ["loc_id": loc_id as AnyObject,
                    "count": count as AnyObject,
                    "apikey": apikey as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "start": start as AnyObject]
            
        case .movieDetailCincism(_):
            return ["_need_webp": _need_webp as AnyObject,
                    "_sig": _sig as AnyObject,
                    "_ts": _ts as AnyObject,
                    "alt": alt as AnyObject,
                    "apikey": apikey as AnyObject,
                    "douban_udid": douban_udid as AnyObject,
                    "event_loc_id": event_loc_id as AnyObject,
                    "latitude": latitude as AnyObject,
                    "loc_id": loc_id as AnyObject,
                    "longitude": longitude as AnyObject,
                    "udid": udid as AnyObject,
                    "version": version as AnyObject]
        case let .cincismComment(_, start, count):
            return ["loc_id": loc_id as AnyObject,
                    "count": count as AnyObject,
                    "apikey": apikey as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "start": start as AnyObject]
        case .movieModules():
            return ["loc_id": loc_id as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "apikey": apikey as AnyObject]
        }
    }

    public var method: Moya.Method {
        return .GET
    }
}
