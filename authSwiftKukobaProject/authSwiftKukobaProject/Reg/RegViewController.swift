//
//  RegViewController.swift
//  authSwiftKukobaProject
//
//  Created by Александр Кукоба on 16.10.2022.
//

import UIKit

class RegViewController: UIViewController {

    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    let service = FireBaseService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func regBtn(_ sender: Any) {
        guard let login = loginField.text, !login.isEmpty else {
            self.show(message: "Не заполнено поле Логин!")
            return
        }
        guard let password = passwordField.text, !password.isEmpty else {
            self.show(message: "Не заполнено поле Пароль!")
            return
        }
        service.regNewUser(email: login, password: password) { res in
            if res.isSuccess {
                self.performSegue(withIdentifier: "showPostsFromReg", sender: nil)
            }
            else {
                if let result = res.result {
                    self.show(message: result)
                }
            }
        }
    }
    
    func show(message: String) {
        let alertVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            //self.loginField.text = ""
            //self.passwordField.text = ""
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }

}
