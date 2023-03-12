//
//  FindNewToRealm.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation

class FindNewToRealm: Operation {
    
    weak var saver: (GroupSavable)?
    var firstArray: [VkGroup]
    var secondArray: [VkGroup]

    init(saver: GroupSavable, firstArr: [VkGroup], secondArr: [VkGroup]) {
        self.saver = saver
        self.firstArray = firstArr
        self.secondArray = secondArr
    }

    override func main() {
      
        var elements = [VkGroup]()
        firstArray.forEach {

            var isFinded = false
            for i in 0 ..< secondArray.count{
                guard !isFinded else {break}
                
                if secondArray[i].id == $0.id {
                    isFinded.toggle()
                    break
                }
            }
            if !isFinded {
                elements.append($0)
            }
        }
        saver?.getNewToRealm(groups: elements)
    }
}
