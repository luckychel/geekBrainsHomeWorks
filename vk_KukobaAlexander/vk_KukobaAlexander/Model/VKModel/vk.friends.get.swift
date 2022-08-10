//
//  vk.friends.get.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.08.2022.
//

import Foundation

// MARK: - VkFriendsGet
struct VkFriendsGet: Codable {
    var response: VkFriendsGetResponse
}

// MARK: - VkFriendsGetResponse
struct VkFriendsGetResponse: Codable {
    var count: Int
    var items: [Int]
}
