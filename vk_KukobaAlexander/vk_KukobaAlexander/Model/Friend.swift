//
//  Friend.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//
import UIKit

class Friend {
    
    let name: String
    let avatar: UIImage?
    let allFriends: [Friend]?
    let allGroups: [Group]?

    init(name: String, avatar: UIImage? = nil, allFriends: [Friend]? = nil, allGroups: [Group]? = nil) {
        self.name = name
        self.avatar = avatar
        self.allFriends = allFriends
        self.allGroups = allGroups
    }

}
