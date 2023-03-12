//
//  GroupsTableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit
import RealmSwift
import Alamofire

protocol GroupSavable: NSObject {
    func setGroups(groups: [VkGroup])
    
    func getOldRealmGroups(groups: [VkGroup])
    func getNewToRealm(groups: [VkGroup])
}

class GroupsTableViewController: BaseUITableViewController, GroupSavable {

    let session = Session.shared
    let vkApi = VKApi.shared
    
    var groups = [VkGroup]()
    var filteredGroups = [VkGroup]()
    
    var oldRealmGroups = [VkGroup]()
    var newToRealmGroups = [VkGroup]()
    
    let refresh = UIRefreshControl()
    
    @IBOutlet var searchBarGroups: UISearchBar! {
        didSet {
            searchBarGroups.delegate = self
        }
    }
    
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.name = "serialQueue"
        queue.qualityOfService = .utility
        return queue
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Группы"
        
        tableView.register(UINib(nibName: "GroupXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupXIB")
        
        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.addSubview(refresh)

        guard let realm = RealmHelper.getRealm() else { return }
        print(realm.configuration.fileURL as Any)
        
        //MARK: Проверка на существование объекта VkGroup в Realm
        let groups = realm.objects(VkGroup.self)
        
        if groups.isEmpty {
            self.refreshData(self)
        }
        else {
            self.setGroups(groups: Array(groups))
        }
        
        
    }
    
    @objc private func refreshData (_ sender: AnyObject) {
        
//        print("=====START LOADING=====")
//        self.startLoading()
//
//        vkApi.getUserGroups(token: session.token, id: session.userId) { [weak self] in
//
//            guard let self = self else { return }
//
//            guard let realm = RealmHelper.getRealm() else { return }
//
//            let groups = realm.objects(VkGroup.self)
//
//            self.setGroups(Array(groups))
//
//            print("=====END LOADING======")
//            self.endLoading()
//
//            if self.refresh.isRefreshing {
//                self.refresh.endRefreshing()
//            }
//
//        }
        
        let path = "/method/groups.get"

        let parameters: Parameters = [
            "access_token" : session.token,
            "user_id": session.userId,
            "extended": "1",
            "fields": "id, name, photo_50, description",  // название, фото, описание
            "v": "5.131"
        ]

        let url = VKApi.baseUrl+path
  
        let request = AF.request(url, method: .get, parameters: parameters)
        
        let getData = GetDataOperation(request: request)
        let parseData = DataParseOperation()
        let saveOperation = SaveOperation()
        let reloadOperation = ReloadTableController(controller: self)
        
        parseData.addDependency(getData)
        saveOperation.addDependency(parseData)
        reloadOperation.addDependency(saveOperation)
        
        queue.addOperation(getData)
        queue.addOperation(parseData)
        queue.addOperation(saveOperation)
        OperationQueue.main.addOperation(reloadOperation)
        OperationQueue.main.addOperation {
            if self.refresh.isRefreshing {
                self.refresh.endRefreshing()
            }
        }
        
    }

    func setGroups(groups: [VkGroup]) {
        self.groups = Array(groups)

        self.filteredGroups = self.groups

        self.tableView.reloadData()
    }
    
    func getOldRealmGroups(groups: [VkGroup]) {
        self.oldRealmGroups = groups
    }
    
    func getNewToRealm(groups: [VkGroup]){
        self.newToRealmGroups = groups
    }
    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? GroupCell else {
//            preconditionFailure("Error")
//        }

        //MARK: перешли на XIB
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupXIB", for: indexPath) as? GroupXIBTableViewCell else {
            preconditionFailure("Error")
        }
        
        cell.groupNameXIB.text = filteredGroups[indexPath.row].name
        cell.groupDescriptionXIB.text = filteredGroups[indexPath.row].Description
        let url = URL(string: filteredGroups[indexPath.row].photoGroup)
        
        if let url = url, let data = try? Data(contentsOf: url) {
            cell.groupImage.image = UIImage(data: data)
        }

        return cell
    }
    
    
    //возврат по клику на группу при добавлении на следующем экране
    @IBAction func addSelectGroup(segue: UIStoryboardSegue) {
        //print("unwined")
        
        
//        if (segue.identifier == "addGroupToAll") {
//            guard let allGroupsController = segue.source as? GroupsViewController else { return }
//            
//            if let indexPath = allGroupsController.allGroups.indexPathForSelectedRow {
//                let group = allGroupsController.groups[indexPath.row]
//                
//                if (!self.filteredGroups.contains(where: {$0.name == group.name})) {
//                    self.filteredGroups.append(group)
//                    self.groups.append(group)
//                    
//                    self.tableView.reloadData()
//                }
//            }
//        }

        //print(sourceVC)
        //print(segue.destination)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

}

extension GroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredGroups = groups.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
        else
        {
            filteredGroups = groups
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.searchBar(searchBar, textDidChange: "")
    }
}
