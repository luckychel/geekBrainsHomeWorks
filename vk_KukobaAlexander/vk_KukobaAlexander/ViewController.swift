//
//  ViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 15.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textLogin: UITextField!
    
    @IBOutlet var textPassword: UITextField!
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func tapLoginBtn(_ sender: Any) {
        print(#function)
    }
}

