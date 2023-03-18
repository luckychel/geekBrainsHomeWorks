//
//  DataParseOperation.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation

class DataParseOperation : Operation {
    
    private(set) var outputData: [VkGroup] = []
    private let decoder = JSONDecoder()
    
    override func main() {
        guard let getDataOperation = dependencies.first(where: { $0 is GetDataOperation}) as? GetDataOperation,
                let data = getDataOperation.data
        else {
            print("Data not loaded")
            return
        }

        print("Data begin parsed")
        
        let groups = try? JSONDecoder().decode(VkGroupResponse.self, from: data)
        
        guard let groups = groups?.response.items else { return }
        
        print("Data end parsed")
        
        outputData = groups

    }
}
