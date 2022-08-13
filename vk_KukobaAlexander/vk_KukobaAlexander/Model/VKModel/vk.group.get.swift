//
//  vk.group.get.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 11.08.2022.
//

import Foundation

class VkGroupResponse: Decodable {
    let response: VkGroups
}

class VkGroups: Decodable{
    let items: [VkGroup]
}

class VkGroup: Decodable{
    var name: String = ""
    var photoGroup: String = ""
    var description: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name
        case photoGroup = "photo_50"
        case description
    }
}
