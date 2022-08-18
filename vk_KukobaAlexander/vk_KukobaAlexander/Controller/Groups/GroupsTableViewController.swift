//
//  GroupsTableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {

    let session = Session.shared
    let vkApi = VKApi.shared
    
    var groups = [VkGroup]()
    var filteredGroups = [VkGroup]()
    
    @IBOutlet var searchBarGroups: UISearchBar! {
        didSet {
            searchBarGroups.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Группы"
        
        tableView.register(UINib(nibName: "GroupXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupXIB")
        
        vkApi.getUserGroups(token: session.token, id: session.userId) { [weak self] in
            
            guard let self = self else { return }
            
            do {
                let realm = try Realm()
                let groups = realm.objects(VkGroup.self)
                self.groups = Array(groups)
            } catch {
                print(error)
            }

            self.filteredGroups = self.groups
            
            self.tableView.reloadData()
            
        }
        
        
       
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
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
