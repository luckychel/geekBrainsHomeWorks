//
//  FriendsTableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit

class FriendsViewController: UIViewController {

    var friends = [
        Friend(name: "Кирилл", avatar: UIImage(named:  "kirill"), allFriends: [Friend(name: "Валерия", avatar: UIImage(named:  "valeria")), Friend(name: "Ирина", avatar: UIImage(named:  "irina"))]),
        
        Friend(name: "Валерия", avatar: UIImage(named:  "valeria"), allFriends: [Friend(name: "Георгий", avatar: UIImage(named:  "gosha")), Friend(name: "Роман", avatar: UIImage(named:  "roma")), Friend(name: "Всеволод", avatar: UIImage(named:  "seva"))]),
        
        Friend(name: "Ирина", avatar: UIImage(named:  "irina"), allFriends: [Friend(name: "Сергей", avatar: UIImage(named:  "sergey")), Friend(name: "Кирилл", avatar: UIImage(named:  "kirill"))]),
                                                                             
        Friend(name: "Всеволод", avatar: UIImage(named:  "seva"), allFriends: [Friend(name: "Александр", avatar: UIImage(named:  "alexander"))]),
        
        Friend(name: "Александр", avatar: UIImage(named:  "alexander"), allFriends: [Friend(name: "Всеволод", avatar: UIImage(named:  "seva"))]),
        
        Friend(name: "Жанна", avatar: UIImage(named:  "ganna"), allFriends: [Friend(name: "Валерия", avatar: UIImage(named:  "valeria")), Friend(name: "Ирина", avatar: UIImage(named:  "irina"))]),
        
        Friend(name: "Сергей", avatar: UIImage(named:  "sergey"), allFriends: [Friend(name: "Кирилл", avatar: UIImage(named:  "kirill")), Friend(name: "Александр", avatar: UIImage(named:  "alexander")), Friend(name: "Жанна", avatar: UIImage(named:  "ganna"))]),
        
        Friend(name: "Георгий", avatar: UIImage(named:  "gosha"), allFriends: [Friend(name: "Всеволод", avatar: UIImage(named:  "seva")), Friend(name: "Сергей", avatar: UIImage(named:  "sergey"))]),
        
        Friend(name: "Роман", avatar: UIImage(named:  "roma")),
    ]
    
    
    
    @IBOutlet var myFriends: UITableView! {
        didSet {
            myFriends.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Друзья"

    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "CollectionFriends",
        let destination = segue.destination as? FriendsCollectionViewController,
        let indexPath = myFriends.indexPathForSelectedRow {
         destination.title = friends[indexPath.row].name
         destination.arrayFriends = friends[indexPath.row].allFriends
     }
    }
}



extension FriendsViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
            preconditionFailure("Error")
        }
        
        cell.imageFriend.image = friends[indexPath.row].avatar
        cell.nameFriend.text = friends[indexPath.row].name
        
       
        return cell
    }
    
    
}