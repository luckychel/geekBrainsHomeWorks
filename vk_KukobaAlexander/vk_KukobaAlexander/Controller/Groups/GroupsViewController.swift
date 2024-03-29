//
//  GroupsViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 28.06.2022.
//

import UIKit

class GroupsViewController: UIViewController {
    
    
    var groups = [
        Group(name: "Программисты SWIFT", description: "Эта группа создана для ищущих себя в великолепном языке программирования от компании APPLE"),
        Group(name: "Выучи новый язык за пару месяцев", description: "Англиский, Немецкий, Французский, Итальянский за полгода - это реально"),
        Group(name: "Спортные тачки", description: "Самые быстрые машины в мире: Бугатти, Макларен, Пагани, Лотус, Ламборгини. Почувствуй скорость, рев мотора и получу бурю эмоций"),
        Group(name: "Спортивные мотоциклы и не только", description: "От А до Я. От получить права, покупки мотоцикла, общение с мотобатами до ремонта своими руками. Узнай все о своем двухколесном друге"),
        Group(name: "Купить квартиру без посредников", description: "Лучшие предложения по аренде, покупке, сдаче квартир в Москве и Московской области")
    ]
    
    @IBOutlet var allGroups: UITableView! {
        didSet {
            allGroups.dataSource = self
            allGroups.delegate = self

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allGroups.register(UINib(nibName: "GroupXIBTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupXIB")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroups", for: indexPath)
        
        //MARK: перешли на XIB
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupXIB", for: indexPath) as! GroupXIBTableViewCell
        
        //var content = cell.defaultContentConfiguration()
        
        let content = cell
        
        content.groupNameXIB.text = groups[indexPath.row].name
        content.groupDescriptionXIB.text = groups[indexPath.row].description
        
        cell.contentConfiguration = content as? UIContentConfiguration
       
        return cell
    }
    
    
}
extension GroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("нажата строка № \(indexPath.row) в секции \(indexPath.section)")
        performSegue(withIdentifier: "addGroupToAll", sender: nil)

    }
}
