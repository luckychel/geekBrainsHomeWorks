//
//  UiViewConroller+extension.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 22.06.2022.
//

import Foundation
import UIKit

extension LoginViewController {
    func show(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.textLogin.text = ""
            self.textPassword.text = ""
        }
        
        alertVC.addAction(okAction)
        present(alertVC, animated: true)
    }
}
