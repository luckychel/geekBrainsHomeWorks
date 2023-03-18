//
//  PrintOperation.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation
import RealmSwift

class SaveOperation: Operation {
        
//    weak var saver: (GroupSavable)?
//
//    init(saver: GroupSavable) {
//        self.saver = saver
//    }

    private(set) var outputData: [VkGroup] = []
    
    override func main() {
        guard let parseData = dependencies.first as? DataParseOperation,
              parseData.outputData.count > 0 else {
            print("Data not parsed")
            return
        }
        
        print("Data begin saved")
        
        DispatchQueue.main.async {
            RealmHelper.saveGroupsToRealm(arr: parseData.outputData)
        }
        
        print("Data end saved")
        
        outputData = parseData.outputData
        
    }
}


