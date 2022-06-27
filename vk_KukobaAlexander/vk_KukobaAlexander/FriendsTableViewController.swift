//
//  FriendsTableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    var friends = [
        Friend(name: "Кирилл", avatar: UIImage(named:  "kirill")),
        Friend(name: "Валерия", avatar: UIImage(named:  "valeria")),
        Friend(name: "Ирина", avatar: UIImage(named:  "irina")),
        Friend(name: "Всеволод", avatar: UIImage(named:  "seva")),
        Friend(name: "Александр", avatar: UIImage(named:  "alexander")),
        Friend(name: "Жанна", avatar: UIImage(named:  "ganna")),
        Friend(name: "Сергей", avatar: UIImage(named:  "sergey")),
        Friend(name: "Георгий", avatar: UIImage(named:  "gosha")),
        Friend(name: "Роман", avatar: UIImage(named:  "roma")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Друзья"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            preconditionFailure("Error casting FriendCell")
        }
        
        cell.nameFriend.text = friends[indexPath.row].name
        cell.imageFriend.image = friends[indexPath.row].avatar
        //print(indexPath.row)
        //print(indexPath.section)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
