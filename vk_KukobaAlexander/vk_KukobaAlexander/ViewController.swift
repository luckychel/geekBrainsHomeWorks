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
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
    }


    @IBAction func tapLoginBtn(_ sender: Any) {
        guard let loginTxt = textLogin.text,
              let passwordTxt = textPassword.text,
              loginTxt == "",
              passwordTxt == "" else {
            self.show(message: "Поля должны быть пустыми")
            return
        }
    
        performSegue(withIdentifier: "LoginSega", sender: nil)
    }
}

