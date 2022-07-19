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
    
    var sortedFriends = [Character: [Friend]]()
    
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        var friendsDict = [Character: [Friend]]()
        
        friends.forEach() { friend in
            guard let firstChar = friend.name.first else {return}
            
            if var thisFriend = friendsDict[firstChar] {
                thisFriend.append(friend)
                friendsDict[firstChar] = thisFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
                    
        }
        
        return friendsDict
    }
    
    @IBOutlet var myFriends: UITableView! {
        didSet {
            myFriends.dataSource = self
            myFriends.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Друзья"
        
        myFriends.register(UINib(nibName: "FriendXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXIB")
        
        self.sortedFriends = sort(friends: friends)

        
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
            self.navigationItem.leftBarButtonItem  = logoutBarButtonItem
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = sender as? IndexPath else { return }

        let friend = getFriendByIndexPath(indexPath)

        if segue.identifier == "CollectionFriends",
           let destination = segue.destination as? FriendsCollectionViewController {
            destination.title = friend.name
            destination.arrayFriends = friend.allFriends
        }
    }
    
    @objc func logoutUser(sender: UITapGestureRecognizer){


//        let FriendsView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginView")
//        FriendsView.modalTransitionStyle = .flipHorizontal
//        FriendsView.modalPresentationStyle = .overFullScreen
//        self.present(FriendsView, animated: true)
        
        
        self.dismiss(animated: true, completion: nil)

    }
}

extension FriendsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedFriends.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let keysSorted = sortedFriends.keys.sorted()
        
        let friends = sortedFriends[keysSorted[section]]?.count ?? 0
        
        return friends
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedFriends.keys.sorted()[section])
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendCell else {
//            preconditionFailure("Error")
//        }
        
        //MARK: перешел на XIB
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendXIB", for: indexPath) as? FriendXIBTableViewCell else {
            preconditionFailure("Error")
        }
        
        let friend = getFriendByIndexPath(indexPath)
        
//        cell.imageFriend.image = friend.avatar
//        cell.nameFriend.text = friend.name
        
        let animation = CASpringAnimation(keyPath: "position.x")
        animation.fromValue = cell.imageFriendXIB.layer.position.x + 50
        animation.toValue = cell.imageFriendXIB.layer.position.x
        animation.stiffness = 200
        animation.mass = 1
        //animation.duration = 1
        animation.autoreverses = false
        animation.repeatCount = 1
        animation.beginTime = CACurrentMediaTime()
        //animation.fillMode = CAMediaTimingFillMode.backwards
        cell.imageFriendXIB.layer.add(animation, forKey: nil)
   
        //MARK: перешел на XIB
        cell.imageFriendXIB.image = friend.avatar
        cell.nameFriendXIB.text = friend.name

        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        return sortedFriends.keys.sorted().map({String($0)})

    }
    
    
    func getFriendByIndexPath(_ indexPath: IndexPath) -> Friend {
        var friend: Friend
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        
        let friends = sortedFriends[firstChar]!
        
        friend = friends[indexPath.row]
        
        return friend
    }
    
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Friends нажата строка № \(indexPath.row) в секции \(indexPath.section)")
        performSegue(withIdentifier: "CollectionFriends", sender: indexPath)

    }
}

