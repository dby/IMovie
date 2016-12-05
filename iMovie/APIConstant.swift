//
//  APIConstant.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import Moya

public enum APIConstant {
    
    /// 获得榜豆瓣榜单前250的电影
    case movie_top_250(Int)
    
    case hot_
    
}

extension APIConstant: TargetType {
    public var task: Task {
        return .request;
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
        default:
            return URL.init(string: "https://frodo.douban.com/api/")!
        }
    }
    
    public var path: String {
        switch self {
        case .movie_top_250(_):
            return "movie_top250/items?"
        default:
            return ""
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
        default:
            return [:]
        }
    }

    public var method: Moya.Method {
        return .GET
    }
}
