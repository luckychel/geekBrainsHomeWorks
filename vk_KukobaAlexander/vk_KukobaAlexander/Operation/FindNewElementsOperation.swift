//
//  FindNewElementsOperation.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation

class FindNewElementsOperation: Operation{
    
    weak var saver: (GroupSavable)?

    init(saver: GroupSavable) {
        self.saver = saver
    }

    override func main() {
        guard let parseData = dependencies.first as? DataParseOperation else {
            print("Data not parsed")
            return
        }
        let groups = parseData.outputData
        saver?.setGroups(groups: groups)
    }
}
