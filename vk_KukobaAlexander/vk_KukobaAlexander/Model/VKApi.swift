//
//  VKApi.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 07.08.2022.
//

import Foundation
import Alamofire


struct DecodableType: Decodable { let url: String }


class VKApi {

    static let shared = VKApi()
    
    private init() {}
    
    static let clientId : String = "51396167"
    static let redirectUrl: String = "https://oauth.vk.com/blank.html"
    static let baseUrl : String = "https://api.vk.com"
    
    let session = Session.shared
    
    func getFriendsList(token: String, id: Int){

        let path = "/method/friends.get"

        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": VKApi.clientId,
            "order": "name", // сортировка по имени
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            print("===========friends.get===========")
            
            guard let data = response.data else { return }

            let friendsIds = try? JSONDecoder().decode(VkFriendsGet.self, from: data)
            
            guard let items = friendsIds?.response.items else { return }
            
            self.session.friendsIds = items
            
            self.getUsers(token: self.session.token, ids: self.session.friendsIds)
        }
    }
    
    func getUsers(token: String, ids: [Int]) {

        let idsStr = ids.map { String($0) }.joined(separator: ",")
        
        let path = "/method/users.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_ids": idsStr,
            "fields": "bdate, domain, sex, city, country, photo_400_orig, status, counters",
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { [weak self] response in
            print("===========users.get===========")
            guard let self = self else { return }
 
            guard let data = response.data else { return }

            let friendsIds = try? JSONDecoder().decode(VkUsersGet.self, from: data)
            
            guard let items = friendsIds?.response else { return }
            
            self.session.friends = items
            
            //self.getUsers(token: self.session.token, ids: self.session.friendsIdsList)
        }
    }

    func getUserPhotos(token: String, id: Int){

        let path = "/method/photos.get"

        let parameters: Parameters = [
            "access_token" : token,
            "owner_id": id,
            "album_id": "profile",
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            print("===========photos.get===========")
            print(response.value as Any)
        }
    }
    

    func getUserGroups(token: String, id: Int){

        let path = "/method/groups.get"

        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": VKApi.clientId,
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            print("===========groups.get===========")
            print(response.value as Any)
        }
    }
    

    func getUserGroupsSearch(token: String){

        let path = "/method/groups.search"

        let parameters: Parameters = [
            "q": "музыка",
            "type": "group",
            "count": "2",
            "sort": 6,
            "access_token" : token,
            "client_id": VKApi.clientId,
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            print("===========groups.search ===========")
            print(response.value as Any)
        }
    }
    
}
