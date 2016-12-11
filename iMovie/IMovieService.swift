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
    case movie_top_250(Int)
    /// 影评
    case movie_cincism(Int, Int)
    
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
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var baseURL: URL {
        
        switch self {
        case .movie_top_250(_):
            return URL.init(string: "https://frodo.douban.com/api/v2/subject_collection/")!
        case .movie_cincism(_, _):
            return URL.init(string: "https://frodo.douban.com/api/v2/")!
        }
    }
    
    public var path: String {
        switch self {
        case .movie_top_250(_):
            return "movie_top250/items"
        case .movie_cincism(_, _):
            return "movie/best_reviews"
        }
    }

    public var parameters: [String : Any]? {
        switch self {
        case let .movie_top_250(num):
            return ["loc_id": loc_id as AnyObject,
                    "count": count as AnyObject,
                    "apikey": apikey as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "start": num as AnyObject]
        case let .movie_cincism(start, count):
            return ["loc_id": loc_id as AnyObject,
                    "count": count as AnyObject,
                    "apikey": apikey as AnyObject,
                    "_need_webp": _need_webp as AnyObject,
                    "start": start as AnyObject]
        }
    }

    public var method: Moya.Method {
        return .GET
    }
}
