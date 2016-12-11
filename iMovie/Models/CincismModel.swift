//
//  cincismModel.swift
//  iMovie
//
//  Created by sys on 2016/12/10.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit

struct LocModel {
    var id: String!
    // 地址名---上海
    var name: String!
    // 一般为地址名拼音---shanghai
    var uid: String!
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            self.id = dic["id"] as? String ?? ""
            self.name = dic["name"] as? String ?? ""
            self.uid = dic["uid"] as? String ?? ""
        }
    }
}

struct PicModel {
    var large: String!
    var normal: String!
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            self.large = dic["large"] as? String ?? ""
            self.normal = dic["normal"] as? String ?? ""
        }
    }
}
/// 电影信息
struct SubjectModel {
    // 电影
    var actors: Array<String>! = Array<String>()
    // 演员
    var directors: Array<String>! = Array<String>()
    // 电影类别 喜剧、爱情、奇幻
    var genres: Array<String>!
    var has_linewatch: Int!
    var id: String!
    var null_rating_reason: String!
    // 图片信息
    var pic: PicModel!
    // 上映时间 数组
    var pubdate: Array<String>!
    // 评价信息
    var rating: RatingModel!
    // 上映时间
    var release_date: String!
    // 分享给朋友的 连接
    var sharing_url: String!
    // 电影名字
    var title: String!
    // 类型
    var type: String!
    var uri: String!
    var url: String!
    /// 上映时间
    var year: String!
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            
            if let tmp: Array<NSDictionary> = dic["actors"] as? Array<NSDictionary> {
                for item: NSDictionary in tmp {
                    self.actors.append(item["name"] as? String ?? "")
                }
            }
            
            if let tmp: Array<NSDictionary> = dic["directors"] as? Array<NSDictionary> {
                for item: NSDictionary in tmp {
                    self.directors.append(item["name"] as? String ?? "")
                }
            }
            
            if let genresArr: Array<String> = dic["genres"] as? Array<String> {
                self.genres = genresArr
            }
            
            self.has_linewatch = dic["has_linewatch"] as? Int ?? 0
            self.id = dic["id"] as? String ?? ""
            self.null_rating_reason = dic["null_rating_reason"] as? String ?? ""
            
            if let picDic: NSDictionary = dic["pic"] as? NSDictionary {
                self.pic = PicModel(dic: picDic)
            }
            
            if let pubdateArr: Array<String> = dic["pubdate"] as? Array<String> {
                self.pubdate = pubdateArr
            }
            
            if let ratingDic: NSDictionary = dic["rating"] as? NSDictionary {
                self.rating = RatingModel(dict: ratingDic)
            }
            
            self.release_date = dic["release_date"] as? String ?? ""
            self.sharing_url = dic["sharing_url"] as? String ?? ""
            self.title = dic["title"] as? String ?? ""
            self.type = dic["type"] as? String ?? ""
            self.uri = dic["uri"] as? String ?? ""
            self.url = dic["url"] as? String ?? ""
            self.year = dic["year"] as? String ?? ""
        }
    }
}

/// 用户信息
struct UserModel {
    // 昵称
    var abstract: String!
    // 头像
    var avatar: String!
    // 关注人数
    var followed: Int!
    var gender: String!
    // id
    var id: String!
    var in_blacklist: Int!
    // type 取值为(user/movie/review)
    var kind: String!
    var large_avatar: String!
    // 位置信息
    var loc: LocModel!
    // 昵称
    var name: String!
    var remark: String!
    // 与kind取值一致
    var type: String!
    // uid
    var uid: String!
    var uri: String!
    var url: String!
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            self.abstract = dic["abstract"] as? String ?? ""
            self.avatar = dic["avatar"] as? String ?? ""
            self.followed = dic["followed"] as? Int ?? 0
            self.gender = dic["gender"] as? String ?? ""
            self.id = dic["id"] as? String ?? ""
            self.in_blacklist = dic["in_blacklist"] as? Int ?? 0
            self.kind = dic["kind"] as? String ?? ""
            self.large_avatar = dic["large_avatar"] as? String ?? ""
        
            if let tmp: NSDictionary = dic["loc"] as? NSDictionary {
                self.loc = LocModel(dic: tmp)
            }
        
            self.name = dic["name"] as? String ?? ""
            self.remark = dic["remark"] as? String ?? ""
            self.type = dic["type"] as? String ?? ""
            self.uid = dic["uid"] as? String ?? ""
            self.uri = dic["uri"] as? String ?? ""
            self.url = dic["url"] as? String ?? ""
        }
    }
}

/// 影评的模式
struct ReviewModel {
    // 简要
    var abstract: String!
    // 评价的数目
    var comments_count: Int!
    // 海报url
    var cover_url: String!
    // 发表的时间
    var create_time: String!
    // id
    var id: String!
    // 点赞的数目
    var likers_count: Int!
    //
    var rating: RatingModel!
    // 类型
    var rtype: String!
    // 影评url
    var sharing_url: String!
    var spoiler: Int!
    // 电影信息
    var subject: SubjectModel!
    // 影评标题
    var title: String!
    // 取值 -- review
    var type: String!
    // 取值 -- 影评
    var type_name: String!
    var uri: String!
    var url: String!
    var useful_count: Int!
    var useless_count: Int!
    var user: UserModel!
    var vote_status: Int!
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            self.abstract = dic["abstract"] as? String ?? ""
            self.comments_count = dic["comments_count"] as? Int ?? 0
            self.cover_url = dic["cover_url"] as? String ?? ""
            self.create_time = dic["create_time"] as? String ?? ""
            self.id = dic["id"] as? String ?? ""
            self.likers_count = dic["likers_count"] as? Int ?? 0
            
            if let ratingDic: NSDictionary = dic["rating"] as? NSDictionary {
                self.rating = RatingModel(dict: ratingDic)
            }
            
            self.rtype = dic["rtype"] as? String ?? ""
            self.sharing_url = dic["sharing_url"] as? String ?? ""
            self.spoiler = dic["spoiler"] as? Int ?? 0
            
            if let subjectDic: NSDictionary = dic["subject"] as? NSDictionary {
                self.subject = SubjectModel(dic: subjectDic)
            }
            
            self.title = dic["title"] as? String ?? ""
            self.type = dic["type"] as? String ?? ""
            self.type_name = dic["type_name"] as? String ?? ""
            self.uri = dic["uri"] as? String ?? ""
            self.url = dic["url"] as? String ?? ""
            self.useful_count = dic["useful_count"] as? Int ?? 0
            self.useless_count = dic["useless_count"] as? Int ?? 0
            
            if let useDic: NSDictionary = dic["user"] as? NSDictionary {
                self.user = UserModel(dic: useDic)
            }
            
            self.vote_status = dic["vote_status"] as? Int ?? 0
        }
    }
}

struct CincismModel {
    // 影评数目
    var total: Int!
    // 开始
    var start: Int!
    var reviews: Array<ReviewModel>! = Array<ReviewModel>()
    
    init(dic: NSDictionary?) {
        if let dic = dic {
            self.total = dic["total"] as? Int ?? 0
            self.start = dic["start"] as? Int ?? 0
            
            if let reviewsDic: Array<NSDictionary> = dic["reviews"] as? Array<NSDictionary> {
                for item: NSDictionary in reviewsDic {
                    self.reviews.append(ReviewModel(dic: item))
                }
            }
        }
    }
}
