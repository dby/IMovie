//
//  IMovieService.swift
//  iMovie
//
//  Created by sys on 2016/12/4.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation
import Moya

class IMovieService {
    /// 单例对象
    static let shareInstance = IMovieService()
    
    let endpointClosure = { (target: APIConstant) -> Endpoint<APIConstant> in
        
        var URL = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint = Endpoint<APIConstant>(URL: URL,
                                             sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                             method: target.method,
                                             parameters: target.parameters)
        
        return endpoint.endpointByAddingHTTPHeaderFields(["Host": "frodo.douban.com",
                                                          "If-None-Match": "W/\"42a017ab004ecdfb200a45bd5d61a5c5\"",
                                                          "Cookie": "bid=RN2KdUxJiao",
                                                          "User-Agent": "api-client/0.1.3 com.douban.frodo/4.7.0 iOS/10.1.1 iPhone6,2",
                                                          "Accept-Language": "zh-cn"])
    }

    lazy var iMovieProvider: MoyaProvider<APIConstant> = MoyaProvider<APIConstant>(endpointClosure: endpointClosure)
    fileprivate init() {}
    
    //func getMovieTop250(num: Int, successHandle: ((Array<Object>) -> Void)?, errorHandle: ((Swift.Error) -> Void)?) {
        
    //}

}
