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

    init(name: String, avatar: UIImage? = nil) {
        self.name = name
        self.avatar = avatar
    }

}
