//
//  CommentModel.swift
//  iMovie
//
//  Created by sys on 2016/12/16.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

struct AuthorModel {
    var abstract: String!
    var avatar: String!
    var gender: String!
    var id: String!
    var kind: String!
    var large_avatar: String!
    var loc: LocModel!
    var name: String!
    var type: String!
    var uid: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.abstract = dict["abstract"] as? String ?? ""
            self.avatar = dict["avatar"] as? String ?? ""
            self.gender = dict["gender"] as? String ?? ""
            self.id = dict["id"] as? String ?? ""
            self.kind = dict["kind"] as? String ?? ""
            self.large_avatar = dict["large_avatar"] as? String ?? ""
            
            if let locArr: NSDictionary = dict["locArr"] as? NSDictionary {
                self.loc = LocModel(dic: locArr)
            }
            
            self.name = dict["name"] as? String ?? ""
            self.type = dict["type"] as? String ?? ""
            self.uid = dict["uid"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

struct CommentModel {
    var author: AuthorModel!
    var create_time: String!
    var id: String!
    var is_from_creator: Int!
    
    var ref_comment: NSDictionary!
    
    var text: String!
    var uri: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            
            if let authorDic: NSDictionary = dict["author"] as? NSDictionary {
                self.author = AuthorModel(dict: authorDic)
            }
            
            self.create_time = dict["create_time"] as? String ?? ""
            self.id = dict["id"] as? String ?? ""
            self.is_from_creator = dict["is_from_creator"] as? Int ?? 0
            
            if let refCommentDic: NSDictionary = dict["ref_comment"] as? NSDictionary {
                self.ref_comment = refCommentDic
            }
            
            self.text = dict["text"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
        }
    }
}

struct CommentsModel {
    var total: Int!
    var comments: Array<CommentModel>! = Array<CommentModel>()
    var start: Int!
    var count: Int!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            
            self.total = dict["total"] as? Int ?? 0
            
            if let tmp: Array<NSDictionary> = dict["comments"] as? Array<NSDictionary> {
                for item: NSDictionary in tmp {
                    self.comments.append(CommentModel(dict: item))
                }
            }
            
            self.start = dict["start"] as? Int ?? 0
            self.count = dict["count"] as? Int ?? 0
        }
    }
    
}
