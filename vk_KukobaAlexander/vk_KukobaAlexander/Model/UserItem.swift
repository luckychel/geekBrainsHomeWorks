//
//  UserItem.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 19.03.2023.
//

import SwiftyJSON

class UserItem {
    
    var idUser: String = ""
    var lastName: String = ""
    var firstName: String = ""
    var photoUrl: String = ""
    var name: String {
        get {
            let last = lastName == "" ? firstName : lastName
            return last + " " + firstName
        }
    }
    
    var friends: [ProfileItem]?
    var groups: [GroupItem]?
    var newsfeed: [NewsItem]?
    //var dialogs = List<DialogItem>()
    //var requests = List<FriendRequest>()
    
    var makeAny: Any {
        return [
            "id": idUser,
            "last_name": lastName,
            "first_name": firstName,
            "photo_100": photoUrl
        ]
    }
    
    init(friends: [ProfileItem]?, groups: [GroupItem]?, newsfeed: [NewsItem]?) {
        self.friends = friends
        self.groups = groups
        self.newsfeed = newsfeed
    }
}
