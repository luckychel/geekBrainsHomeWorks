//
//  NewsThread.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 16.11.2022.
//

import Foundation

class NewsV2 {
    var author: String
    var avatarAuthor: String
    var timePublication: String
    var text: String?
    var photos: [String]?
    var likeCount: Int
    var userLikes: Int
    var commentCount: Int
    
    init(author: String, avatarAuthor: String, timePublication: String, text: String? = nil, photos: [String]? = nil, likeCount: Int, userLikes: Int, commentCount: Int) {
        self.author = author
        self.avatarAuthor = avatarAuthor
        self.timePublication = timePublication
        self.text = text
        self.photos = photos
        self.likeCount = likeCount
        self.userLikes = userLikes
        self.commentCount = commentCount
    }
}
