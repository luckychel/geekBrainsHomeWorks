//
//  NewsViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 09.07.2022.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet var newsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsXIB")
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
