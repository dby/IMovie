//
//  File.swift
//  iMovie
//
//  Created by sys on 2016/12/6.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

// 海报信息
struct CoverModel {
    var height: NSInteger!
    var shape: String!
    var url: String!
    var width: NSInteger!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.height = dict["height"] as? NSInteger ?? 0
            self.shape  = dict["shape"] as? String ?? ""
            self.url    = dict["url"] as? String ?? ""
            self.width  = dict["width"] as? NSInteger ?? 0
        }
    }
}

// Rating 信息
struct RatingModel {
    var count: NSInteger!
    var max: NSInteger!
    var value: Double!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.count = dict["count"] as? NSInteger ?? 0
            self.max = dict["max"] as? NSInteger ?? 0
            self.value = dict["value"] as? Double ?? 0.0
        }
    }
}

// 电影信息
struct MovieModel {
    var actions: Array<String>!
    var actors: Array<String>!
    var cover: CoverModel!
    var date: String!
    var description: String!
    var directors: Array<String>!
    var id: String!
    var info: String!
    var label: String!
    var original_price: String!
    var price: String!
    var rating: RatingModel!
    var release_date: String!
    var reviewer_name: String!
    var subtype: String!
    var title: String!
    var type: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        
        if let dict = dict {
            if let actionArr: Array<String> = dict["actions"] as? Array<String> {
                self.actions = actionArr
            }
            
            if let actorArr: Array<String> = dict["actors"] as? Array<String> {
                self.actors = actorArr
            }
        
            self.cover = CoverModel(dict: dict["cover"] as? NSDictionary)
            self.date = dict["date"] as? String ?? ""
            self.description = dict["description"] as? String ?? ""
        
            if let direArr: Array<String> = dict["directors"] as? Array<String> {
                self.directors = direArr
            }
        
            self.id = dict["id"] as? String ?? ""
            self.info = dict["info"] as? String ?? ""
            self.label = dict["label"] as? String ?? ""
            self.original_price = dict["original_price"] as? String ?? ""
            self.price = dict["price"] as? String ?? ""
        
            if let ratModel = dict["rating"] as? NSDictionary {
                self.rating = RatingModel(dict: ratModel)
            }
        
            self.release_date = dict["release_date"] as? String ?? ""
            self.reviewer_name = dict["reviewer_name"] as? String ?? ""
            self.subtype = dict["subtype"] as? String ?? ""
            self.title = dict["title"] as? String ?? ""
            self.type = dict["type"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

// 豆瓣 Top250Model 
struct Top250Model {
    var count: NSInteger!
    var start: NSInteger!
    var subject_collection_items = Array<MovieModel>()
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.count = dict["count"] as? NSInteger ?? 0
            self.start = dict["start"] as? NSInteger ?? 0
            if let itemArr: Array<NSDictionary> = dict["subject_collection_items"] as? Array<NSDictionary> {
                for item: NSDictionary in itemArr {
                    let itemModel = MovieModel(dict: item)
                    self.subject_collection_items.append(itemModel)
                }
            }
        }
    }
}
