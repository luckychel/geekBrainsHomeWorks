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
    
    func getFriendsList(token: String, id: Int){

        
//        AF.request("https://httpbin.org/get").responseDecodable(of: DecodableType.self) { response in
//            print("Response: \(response)")
//            print("Response String: \(response.value)")
//        }
//        
        let path = "/method/friends.get"

        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "client_id": VKApi.clientId,
            "order": "name", // сортировка по имени
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            print("===========friends.get===========")
            print(response.value as Any)
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
