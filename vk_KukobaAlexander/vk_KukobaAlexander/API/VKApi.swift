//
//  VKApi.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 07.08.2022.
//

import Foundation
import Alamofire
import RealmSwift
import PromiseKit
import SwiftyJSON

class VKApi {

    enum AppError: String, Error {
        case noData = "Данные не получены"
        case noParseData = "Данные не распарсены"
    }
    
    static let shared = VKApi()
    
    private init() {}
    
    static let clientId : String = "51396167"
    static let redirectUrl: String = "https://oauth.vk.com/blank.html"
    static let baseUrl : String = "https://api.vk.com"

    let session = Session.shared
    
    //MARK: получение getFriendsList
    func getFriendsList(token: String, userId: Int, completion: @escaping ([Int]) -> ()){

        let path = "/method/friends.get"

        let parameters: Parameters = [
            "access_token" : token,
            "user_id": userId,
            "client_id": VKApi.clientId,
            "order": "name", // сортировка по имени
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            //print("===========friends.get===========")
            
            guard let data = response.value else { return }

            let ids = try? JSONDecoder().decode(VkFriendsGet.self, from: data)
            
            guard let items = ids?.response.items else { return }
            
            self.session.friendsIds = items
            
            completion(items)
        }
    }
    
    //MARK: получение getUsers
    func getUsers(token: String, ids: [Int], completion: @escaping () -> ()) {

        let idsStr = ids.map { String($0) }.joined(separator: ",")
        
        let path = "/method/users.get"
        
        let parameters: Parameters = [
            "access_token" : token,
            "user_ids": idsStr,
            "fields": "bdate, domain, sex, city, country, photo_400_orig, status, counters",
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseData { response in
            //print("===========users.get===========")
 
            guard let data = response.value else { return }

            let users = try? JSONDecoder().decode(VkUsersGet.self, from: data)
            
            guard let items = users?.response else { return }
            
            self.session.friends = items.filter({ user in
                return user.first_name != "DELETED"
            })
            
            RealmHelper.saveUsersToRealm(arr: self.session.friends)
            
            completion()
        }
    }

    //MARK: getUserPhotos
    func getUserPhotos(token: String, id: Int, completion: @escaping ()->()){

        let path = "/method/photos.get"

        let parameters: Parameters = [
            "access_token" : token,
            "owner_id": id,
            "album_id": "profile",
            "extended": "likes",
            "photo_sizes": "0",
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseData { response in
            //print("===========photos.get===========")
            
            guard let data = response.value else { return }

            let photos = try? JSONDecoder().decode(VkPhotosGet.self, from: data)
            
            guard let items = photos?.response.items else { return }
            
            RealmHelper.saveUsersPhotosToRealm(arr: items, user_id: id)
            
            completion()
            
        }
    }

    
    // 1. Создаем URL для запроса
    func getUrl() -> Promise<String> {

        let path = "/method/friends.get"
        let url = VKApi.baseUrl+path
        return Promise { resolver in
            resolver.fulfill(url)
        }
    }

    // 2. Создаем запрос
    func getData(_ url: String) -> Promise<Data> {

        let parameters: Parameters = [
            "access_token" : session.token,
            "user_id": session.userId,
            "client_id": VKApi.clientId,
            "order": "name",// сортировка по имени
            "v": "5.131"
        ]
        return Promise { resolver in
            AF.request(url, method: .get, parameters: parameters).responseData { response in
                guard let data = response.value  else {
                    resolver.reject(AppError.noData)
                    return
                }
                resolver.fulfill(data)
            }
        }
    }

    // 3. Парсим data
    func getParseData(_ data: Data) -> Promise<[Int]> {
        return Promise { resolver in

            let ids = try? JSONDecoder().decode(VkFriendsGet.self, from: data)
            
            guard let items = ids?.response.items else {
                resolver.reject(AppError.noParseData)
                return
            }
            
            self.session.friendsIds = items
            
            resolver.fulfill(items)

        }
    }
    
    func getUserGroups(token: String, id: Int, completion: @escaping ()->()){

        let path = "/method/groups.get"

        let parameters: Parameters = [
            "access_token" : token,
            "user_id": id,
            "extended": "1",
            "fields": "id, name, photo_50, description",  // название, фото, описание
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseData { response in
            //print("===========groups.get===========")
            
            guard let data = response.value  else { return}
            
            let groups = try? JSONDecoder().decode(VkGroupResponse.self, from: data)
            
            guard let groups = groups?.response.items else { return }
            
            RealmHelper.saveGroupsToRealm(arr: groups)
            
            completion()

        }
    }

    func getUserGroupsSearch(token: String, q: String){

        let path = "/method/groups.search"

        let parameters: Parameters = [
            "q": q, //"музыка",
            "type": "group",
            "count": "2",
            "sort": 6,
            "access_token" : token,
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path

        AF.request(url, parameters: parameters).responseJSON { response in
            //print("===========groups.search ===========")
            print(response.value as Any)
        }
    }
    
    func getNews(token: String, id: Int, completion: @escaping (UserItem) -> Void){

            let path = "/method/newsfeed.get"

            let parameters: Parameters = [
                "access_token" : token,
                "user_id": id,
                "client_id": VKApi.clientId,
                "filters": "post",
                "v": "5.131",
                "count": "20"
            ]
        
            let url = VKApi.baseUrl+path
        
            print(token)

            AF.request(url, method: .get, parameters: parameters).validate().responseJSON(queue: DispatchQueue.global(qos: .utility)) {  response in
                switch response.result {
                case .success(let value):
 
                 
                    let profiles = JSON(value)["response"]["profiles"].compactMap({ ProfileItem(json: $0.1, userId: String(id)) })
                    let groups = JSON(value)["response"]["groups"].compactMap({ GroupItem(json: $0.1, userId: String(id)) })
                    let newsFeed = JSON(value)["response"]["items"]
                   
                    print("done posts")

                    var news = newsFeed.compactMap({ NewsItem(json: $0.1, userId: String(id), groups: groups, friends: profiles) })
                    //var d = news.filter({$0.id == "1097344"})
                    
                    let user: UserItem = UserItem(friends: profiles, groups: groups, newsfeed: news)
                    
                    completion(user)
                    
                case .failure(let error):
                    print(error)
                }
            }
        
        
//            AF.request(url, method: .get, parameters: parameters).responseData { response in
//                guard let data = response.value  else { return }
//
//                let news = try? JSONDecoder().decode(VKNewsGet.self, from: data)
//
//                guard let news = news?.response else { return }
//
//              //  self.saveData(news)
//                completion(news)
//            }
        }
    
}
