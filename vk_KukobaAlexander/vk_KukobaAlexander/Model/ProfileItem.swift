//
//  ProfileItem.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 19.03.2023.
//

import SwiftyJSON
import RealmSwift
import CloudKit

class ProfileItem: Object {
    
    @objc dynamic var idFriend: String = ""
    @objc dynamic var online: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var photoUrl: String?
    @objc dynamic var userId: String = ""
    @objc dynamic var compoundKey: String = ""
    
    var name: String {
        get {
            let last = lastName == "" ? firstName : lastName
            return last + " " + firstName
        }
    }
    
    var photos = List<Photos>()
    //var user = LinkingObjects(fromType: UserItem.self, property: "friends")
    
    @objc override open class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(json: JSON, userId: String = "") {
        self.init()
        self.idFriend = json["id"].stringValue
        self.online = json["online"].intValue
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.photoUrl = json["photo_100"].stringValue
        self.userId = userId
        self.compoundKey = "\(idFriend)\(userId)"
    }
    
    convenience  init(record: CKRecord) {
        self.init()
        self.idFriend = record.value(forKey: "idFriend") as! String
        self.online = record.value(forKey: "online") as! Int
        self.firstName = record.value(forKey: "firstName") as! String
        self.lastName = record.value(forKey: "lastName") as! String
        self.photoUrl = record.value(forKey: "photoUrl") as? String
        self.userId = record.value(forKey: "userId") as! String
        self.compoundKey = record.recordID.recordName
    }
}

class Photos: Object {
    
    @objc dynamic var idPhoto: Int = 0
    @objc dynamic var idFriend: String = ""
    @objc dynamic var photo75Url: String?
    @objc dynamic var photo604Url: String?
    @objc dynamic var compoundKey: String = ""

    var friend = LinkingObjects(fromType: ProfileItem.self, property: "photos")
    
    @objc override open class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.idPhoto = json["id"].intValue
        self.idFriend = json["owner_id"].stringValue
        self.photo75Url = json["photo_75"].stringValue
        self.photo604Url = json["photo_604"].stringValue
        self.compoundKey = "\(idPhoto)\(idFriend)"
    }
}
