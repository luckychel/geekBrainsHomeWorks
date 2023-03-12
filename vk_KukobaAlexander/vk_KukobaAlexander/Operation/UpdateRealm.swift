//
//  UpdateRealm.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation
import RealmSwift

class UpdateRealm: Operation {
    
    weak var saver: (GroupSavable)?
    var newG: [VkGroup]
    var oldG: [VkGroup]
    var reqGroups: [VkGroup]

    init(saver: GroupSavable, newGroups: [VkGroup], oldGroups: [VkGroup], requestGr: [VkGroup]) {
        self.saver = saver
        self.newG = newGroups
        self.oldG = oldGroups
        self.reqGroups = requestGr
    }

    override func main() {
        
        if newG.count > 0 || oldG.count > 0 {
            
            let realm = try! Realm()
            
            do{
                realm.beginWrite()
                let mainUser = realm.objects(MainUser.self).first
                
                if oldG.count > 0 {
                    mainUser?.groups.realm?.delete(oldG)
                }
                if newG.count > 0 {
                    mainUser?.groups.append(objectsIn:  newG)
                }
                for i in 0 ..< (self.reqGroups.count){
                    self.reqGroups[i].owner = mainUser
                }

                try realm.commitWrite()
            }
            catch{
                print(error)
            }
            
        }
        
        saver?.setGroups(groups: self.reqGroups)

    }
}
