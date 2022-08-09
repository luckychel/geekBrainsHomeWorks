//
//  vk.users.get.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.08.2022.
//

import Foundation

// MARK: - UsersGet
struct VkUsersGet: Codable {
    var response: [VkUsersGetResponse]
}

// MARK: - VkUsersGetResponse
struct VkUsersGetResponse: Codable {
    var id: Int
    var bdate, domain: String?
    var city, country: City?
    var photo_400_orig: String?
    var status: String?
    var counters: [String: Int]?
    var sex: Int?  //self.sex == "1" ? "женский" : (sex == "2" ? "мужской" : "пол не указан")
    var first_name, last_name: String?
    var can_access_closed, is_closed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, bdate, domain, city, country
        case photo_400_orig = "photo_400_orig"
        case status, counters, sex
        case first_name = "first_name"
        case last_name = "last_name"
        case can_access_closed = "can_access_closed"
        case is_closed = "is_closed"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}


