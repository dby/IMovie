//
//  ModulesModel.swift
//  iMovie
//
//  Created by sys on 2016/12/18.
//  Copyright © 2016年 sys. All rights reserved.
//

import Foundation

//MARK:---“正在热映”、“即将上映”的数据模型---

struct SubjectCollectionModel {
    var cover_url: String!
    var description: String!
    var display: NSDictionary!
    var id: String!
    var name: String!
    var sharing_url: String!
    var subject_count: Int!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.cover_url = dict["cover_url"] as? String ?? ""
            self.description = dict["description"] as? String ?? ""
            
            if let displayDic: NSDictionary = dict["display"] as? NSDictionary {
                self.display = displayDic
            }
            
            self.id = dict["id"] as? String ?? ""
            self.name = dict["name"] as? String ?? ""
            self.sharing_url = dict["sharing_url"] as? String ?? ""
            self.subject_count = dict["subject_count"] as? Int ?? 0
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

struct SubjectCollectionBoardsModel {
    var items: Array<MovieModel> = Array<MovieModel>()
    var subject_collection: SubjectCollectionModel!
    var type: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let itemsDic: Array<NSDictionary> = dict["items"] as? Array<NSDictionary> {
                for itemDic in itemsDic {
                    self.items.append(MovieModel(dict: itemDic))
                }
            }
            
            if let sc: NSDictionary = dict["subject_collection"] as? NSDictionary {
                self.subject_collection = SubjectCollectionModel(dict: sc)
            }
            
            self.type = dict["type"] as? String ?? ""
        }
    }
}

struct NowHotShowDataModel {
    var subject_collection_boards: Array<SubjectCollectionBoardsModel>! = Array<SubjectCollectionBoardsModel>()
    var total: Int!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let scbArr: Array<NSDictionary> = dict["subject_collection_boards"] as? Array<NSDictionary> {
                for scbDic: NSDictionary in scbArr {
                    self.subject_collection_boards.append(SubjectCollectionBoardsModel(dict: scbDic))
                }
            }
            self.total = dict["total"] as? Int ?? 0
        }
    }
}

// 正在上映数据模型
struct NowHotShowModel {
    var data: NowHotShowDataModel!
    var key: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let dataDic: NSDictionary = dict["data"] as? NSDictionary {
                self.data = NowHotShowDataModel(dict: dataDic)
            }
            
            self.key = dict["key"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

//MARK:---榜单列表数据模型---
struct SelectedCollectionModel {
    var background_color: String!
    var covers: Array<String>! = Array<String>()
    var description: String!
    var id: String!
    var name: String!
    var rank: Int!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.background_color = dict["background_color"] as? String ?? ""
            
            if let coversArr: Array<String> = dict["covers"] as? Array<String> {
                for item in coversArr {
                    self.covers.append(item)
                }
            }
            
            self.description = dict["description"] as? String ?? ""
            self.id = dict["id"] as? String ?? ""
            self.name = dict["name"] as? String ?? ""
            self.rank = dict["rank"] as? Int ?? 0
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

struct RankListDataModel {
    var selected_collections: Array<SelectedCollectionModel> = Array<SelectedCollectionModel>()
    var title: String!
    var total: Int!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let itemArr: Array<NSDictionary> = dict["selected_collections"] as? Array<NSDictionary> {
                for itemDic in itemArr {
                    self.selected_collections.append(SelectedCollectionModel(dict: itemDic))
                }
            }
            
            self.title = dict["title"] as? String ?? ""
            self.total = dict["total"] as? Int ?? 0
        }
    }
}

struct RankListModel {
    var data: RankListDataModel!
    var key: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let dataDic: NSDictionary = dict["data"] as? NSDictionary {
                self.data = RankListDataModel(dict: dataDic)
            }
            
            self.key = dict["key"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

//MARK:---“最佳影评”数据模型---
struct BestReviewsDataModel {
    var best_reviews: Array<ReviewModel>! = Array<ReviewModel>()
    var title: String!
    var total: Int!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let reviewsArr: Array<NSDictionary> = dict["best_reviews"] as? Array<NSDictionary> {
                for itemDic in reviewsArr {
                    self.best_reviews.append(ReviewModel(dic: itemDic))
                }
            }
            
            self.title = dict["title"] as? String ?? ""
            self.total = dict["total"] as? Int ?? 0
        }
    }
}

struct BestReviewsModel {
    var data: BestReviewsDataModel!
    var key: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let dataDic: NSDictionary = dict["data"] as? NSDictionary {
                self.data = BestReviewsDataModel(dict: dataDic)
            }
            
            self.key = dict["key"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}
//MARK:---豆友榜单数据模型---
struct OwnerModel {
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
            
            if let locDic: NSDictionary = dict["loc"] as? NSDictionary {
                self.loc = LocModel(dic: locDic)
            }
            
            self.name = dict["name"] as? String ?? ""
            self.type = dict["type"] as? String ?? ""
            self.uid = dict["uid"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

struct DouModel {
    var create_time: String!
    var followers_count: Int!
    var id: String!
    var is_follow: Int!
    var item_abstracts: Array<String>!
    var items_count: Int!
    var merged_cover_url: String!
    var owner: OwnerModel!
    var sharing_url: String!
    var title: String!
    var type: String!
    var update_time: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.create_time = dict["create_time"] as? String ?? ""
            self.followers_count = dict["followers_count"] as? Int ?? 0
            self.id = dict["id"] as? String ?? ""
            self.is_follow = dict["is_follow"] as? Int ?? 0
            // 这个字段暂时不需要
            self.item_abstracts = nil
            self.items_count = dict["items_count"] as? Int ?? 0
            self.merged_cover_url = dict["merged_cover_url"] as? String ?? ""
            
            if let ownerDic: NSDictionary = dict["owner"] as? NSDictionary {
                self.owner = OwnerModel(dict: ownerDic)
            }
            
            self.sharing_url = dict["sharing_url"] as? String ?? ""
            self.title = dict["title"] as? String ?? ""
            self.type = dict["type"] as? String ?? ""
            self.update_time = dict["update_time"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

struct DouListDataModel {
    var count: Int!
    var description: String!
    var doulists: Array<DouModel>! = Array<DouModel>()
    var start: Int!
    var title: String!
    var total: Int!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            self.count = dict["count"] as? Int ?? 0
            self.description = dict["description"] as? String ?? ""
            
            if let douArr: Array<NSDictionary> = dict["doulists"] as? Array<NSDictionary> {
                for itemDic: NSDictionary in douArr {
                    self.doulists.append(DouModel(dict: itemDic))
                }
            }
            
            self.start = dict["start"] as? Int ?? 0
            self.title = dict["title"] as? String ?? ""
            self.total = dict["total"] as? Int ?? 0
        }
    }
}

struct DouListModel {
    var data: DouListDataModel!
    var key: String!
    var uri: String!
    var url: String!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let dataDic: NSDictionary = dict["data"] as? NSDictionary {
                self.data = DouListDataModel(dict: dataDic)
            }
            
            self.key = dict["key"] as? String ?? ""
            self.uri = dict["uri"] as? String ?? ""
            self.url = dict["url"] as? String ?? ""
        }
    }
}

//MARK:---最高层数据模型---
struct ModulesModel {
    // 正在热映的电影--1--
    var nowHotShowData: NowHotShowModel!
    // 即将上映的电影--3--
    var soonShowData: NowHotShowModel!
    // 榜单列表--5--
    var rankListData: RankListModel!
    // 最受欢迎的影评--7--
    var bestReviewsData: BestReviewsModel!
    // 豆瓣网友制作的榜单--9--
    var douListData: DouListModel!
    
    init(dict: NSDictionary?) {
        if let dict = dict {
            if let modulesArr: Array<NSDictionary> = dict["modules"] as? Array<NSDictionary> {
                if modulesArr.count > 5 {
                    for itemDic in modulesArr {
                        if let str: String = itemDic["key"] as? String {
                            if str.compare("subject_collection_boards") == .orderedSame {
                                if self.nowHotShowData == nil {
                                    self.nowHotShowData = NowHotShowModel(dict: itemDic)
                                } else {
                                    self.soonShowData = NowHotShowModel(dict: modulesArr[2])
                                }
                            } else if str.compare("selected_collections") == .orderedSame {
                                self.rankListData = RankListModel(dict: itemDic)
                            } else if str.compare("best_reviews") == .orderedSame {
                                self.bestReviewsData = BestReviewsModel(dict: itemDic)
                            } else if str.compare("related_doulists") == .orderedSame {
                                self.douListData = DouListModel(dict: itemDic)
                            }
                        }
                    }
                }
            }
        }
    }
}
