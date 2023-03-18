//
//  User.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 20.11.2022.
//

import Foundation
import RealmSwift

class UserResponse: Decodable {
    let response: [MainUser]
}

class MainUser: Object, Decodable {
    @Persisted var id: Int = 0
    @Persisted var lastName: String = ""
    @Persisted var firstName: String = ""

    @Persisted var groups = List<VkGroup>()
    @Persisted var friends = List<VkUsers>()
    //@Persisted var news = List<NewsV2>()

    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case id = "id"
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
