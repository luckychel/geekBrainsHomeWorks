//
//  NewsItem.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 19.03.2023.
//

import RealmSwift
import SwiftyJSON

class NewsItem: Object {
    
    @objc dynamic var compoundKey: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var authorId: Int = 0
    @objc dynamic var author: String?
    @objc dynamic var authorImageUrl: String?
    @objc dynamic var date: Double = 0.0
    @objc dynamic var type: String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var likesCount: Int = 0
    @objc dynamic var commentsCount: Int = 0
    @objc dynamic var repostsCount: Int = 0
    @objc dynamic var viewsCount: Int = 0
    
    var attachments: [NewsAttachments] = []
    //var user = LinkingObjects(fromType: UserItem.self, property: "newsfeed")
    
    @objc override open class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(json: JSON, userId: String, groups: [GroupItem], friends: [ProfileItem]) {
        self.init()
        self.id = json["post_id"].stringValue
        self.authorId = json["source_id"].intValue
        self.date = json["date"].doubleValue
        self.type = json["type"].stringValue
        self.text = json["text"].stringValue
        self.likesCount = json["likes"]["count"].intValue
        self.commentsCount = json["comments"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.viewsCount = json["views"]["count"].intValue
        self.compoundKey = "\(id)\(authorId)"
        
        if json["attachments"].exists() {
            let attachments = json["attachments"].compactMap({ NewsAttachments(json: $0.1, postId: "\(id)\(authorId)") })
            self.attachments = attachments
        }
        
        if authorId > 0 {
            let friend = friends.filter({ $0.idFriend == "\(authorId)"}).first
            self.author = "\(friend?.firstName ?? "") \(friend?.lastName ?? "")"
            self.authorImageUrl = friend?.photoUrl ?? "https://vk.com/images/camera_100.png"
        } else {
            let group = groups.filter({$0.idGroup == "\(authorId.magnitude)"}).first
            self.author = group?.nameGroup
            self.authorImageUrl = group?.photoGroupUrl ?? "https://vk.com/images/camera_100.png"
        }
    }
}

class NewsAttachments: Object {
    
    @objc dynamic var type: String = ""
    @objc dynamic var url: String?
    @objc dynamic var postId: String = ""
    
    var sizes: [NewsAttachmentSizes] = []
    //var post = LinkingObjects(fromType: NewsItem.self, property: "attachments")
    
    convenience init(json: JSON, postId: String) {
        self.init()
        self.type = json["type"].stringValue
        self.postId = postId
        
        switch type {
        case "photo":
            if json["\(type)"]["sizes"].exists()
            {
                let sizes = json["\(type)"]["sizes"].compactMap({ NewsAttachmentSizes(json: $0.1) })
                print("sizes done")
                self.sizes = sizes
                self.url = sizes.isEmpty ? "" : sizes.max{ $0.height < $1.height}?.url
            }
        case "link":
            self.url = json["\(type)"]["url"].stringValue
        case "video":
            let images = json["\(type)"]["image"].compactMap({ NewsAttachmentSizes(json: $0.1) })
            print("first_frame done")
            self.sizes = images
            self.url = images.isEmpty ? "" : images.max{ $0.height < $1.height}?.url
        default:
            let images = json["\(type)"]["image"].compactMap({ NewsAttachmentSizes(json: $0.1) })
            print("first_frame done")
            self.sizes = images
            self.url = images.isEmpty ? "" : images.max{ $0.height < $1.height}?.url
        }
    }
}

class NewsAttachmentSizes: Object {
    
    @objc dynamic var height: Int = 0
    @objc dynamic var url: String?
    @objc dynamic var type: String?
    @objc dynamic var width: Int = 0

    //var attachments = LinkingObjects(fromType: NewsAttachments.self, property: "sizes")
    
    convenience init(json: JSON) {
        self.init()
        self.height = json["height"].intValue
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
        self.width = json["width"].intValue

    }
}
