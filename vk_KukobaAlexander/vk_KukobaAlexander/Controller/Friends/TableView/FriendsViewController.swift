//
//  FriendsTableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 26.06.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: BaseUIViewController {

    let session = Session.shared
    let vkApi = VKApi.shared
    
    var friends: [VkUsers]?
    var sortedFriends = [Character: [VkUsers]]()
    
    let refresh = UIRefreshControl()
    
    private var photoService: PhotoService?
    
    @IBOutlet var myFriends: UITableView! {
        didSet {
            myFriends.dataSource = self
            myFriends.delegate = self
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Друзья"
        
        photoService = PhotoService(container: myFriends)
        
        myFriends.register(UINib(nibName: "FriendXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendXIB")
        
        let logoutBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.leftBarButtonItem  = logoutBarButtonItem
        
        refresh.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        myFriends.addSubview(refresh)
        
        guard let realm = RealmHelper.getRealm() else { return }
        //print(realm.configuration.fileURL)
        
        //MARK: Проверка на существование объекта Users в Realm
        let users = realm.objects(VkUsers.self)
        
        if users.isEmpty {
            self.refreshData(self)
        }
        else {
            self.setUsers(Array(users))
        }
        
    }
    
    @objc private func refreshData (_ sender: AnyObject) {
        
        //MARK: новая версия с Promise
        vkApi.getUrl()
            .then(on: .global(), vkApi.getData(_:))
            .then(vkApi.getParseData(_:))
            .done(on: .main) { res in
                
                self.vkApi.getUsers(token: self.session.token, ids: res) {[weak self] in
                    
                    guard let self = self else { return }
                    
                    guard let realm = RealmHelper.getRealm() else { return }
                    let users = realm.objects(VkUsers.self)
                    
                    self.setUsers(Array(users))
                    
                    if self.refresh.isRefreshing {
                        self.refresh.endRefreshing()
                    }
                }
                
            }.catch { error in
                print(error)
            }
        
        //MARK: старая версия
//        vkApi.getFriendsList(token: session.token, id: session.userId) {[weak self] res in
//
//            guard let self = self else { return }
//
//            self.vkApi.getUsers(token: self.session.token, ids: res) {[weak self] in
//
//                guard let self = self else { return }
//
//                guard let realm = RealmHelper.getRealm() else { return }
//                let users = realm.objects(VkUsers.self)
//
//                self.setUsers(Array(users))
//
//                if self.refresh.isRefreshing {
//                    self.refresh.endRefreshing()
//                }
//            }
//        }
    }
    
    private func setUsers(_ users: [VkUsers]) {
        self.friends = users
        
        self.sortedFriends = self.sort(friends: self.friends ?? nil)

        self.myFriends.reloadData()
    }
    
    private func sort(friends: [VkUsers]?) -> [Character: [VkUsers]] {
        
        var friendsDict = [Character: [VkUsers]]()
        
        guard let friends = friends else { return friendsDict }
        
        friends.forEach() { friend in
            guard let firstChar = friend.first_name?.first else {return}
            
            if var thisFriend = friendsDict[firstChar] {
                thisFriend.append(friend)
                friendsDict[firstChar] = thisFriend
            } else {
                friendsDict[firstChar] = [friend]
            }
                    
        }
        
        return friendsDict
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = sender as? IndexPath else { return }

        let friend = getFriendByIndexPath(indexPath)

        if segue.identifier == "CollectionFriends",
           let destination = segue.destination as? FriendsCollectionViewController {
            destination.title = friend.fullName
            destination.userId = friend.id
        }
    }
    
    @objc func logoutUser(){
        
        let vcLoging: LoginViewController = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                
        vcLoging.modalTransitionStyle = .flipHorizontal
        vcLoging.modalPresentationStyle = .fullScreen
            
        self.present(vcLoging, animated: true)

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
        
        cell.nameFriendXIB.text = friend.fullName
        
        cell.imageFriendXIB.layer.add(animation, forKey: nil)
        
        //кеширование
        let image = photoService?.photo(atIndexpath: indexPath, byUrl: friend.photo_400_orig ?? "")
        
        cell.imageFriendXIB.image = image
        
//        Utilities().UrlToImage(url: friend.photo_400_orig) { res in
//            cell.imageFriendXIB.image = res
//        }

        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {

        return sortedFriends.keys.sorted().map({String($0)})

    }
    
    
    func getFriendByIndexPath(_ indexPath: IndexPath) -> VkUsers {
        var friend: VkUsers
        
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
