//
//  Session.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 03.08.2022.
//

import Foundation


class Session {
    
    static let shared = Session()
    
    private init(){}
    
    var token: String = ""
    var userId: Int = 0
    
    var friendsIds: [Int] = []
    var friends : [VkUsers] = []
    
}
