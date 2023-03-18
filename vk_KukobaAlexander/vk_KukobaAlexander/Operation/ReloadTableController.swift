//
//  ReloadTableController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 05.03.2023.
//

import Foundation

class ReloadTableController: Operation {
    weak var controller: GroupsTableViewController?
    
    init(controller: GroupsTableViewController) {
        self.controller = controller
    }
    
    override func main() {
        
        guard let saveData = dependencies.first as? SaveOperation else {
            
            print("Data not saved")
            
            return
            
        }
        
        print("Data begin reload")
        
        guard let controller = controller else { return }
        
        controller.filteredGroups = saveData.outputData
        
        controller.tableView.reloadData()
        
        print("Data end reload")
    }
}
