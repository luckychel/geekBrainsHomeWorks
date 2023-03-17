//
//  PostViewController.swift
//  authSwiftKukobaProject
//
//  Created by Александр Кукоба on 30.10.2022.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    let service = FireBaseService.shared
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var descriptionField: UITextField!
  
    @IBAction func savePost(_ sender: Any) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if let title = titleField.text, let description = descriptionField.text {
            service.addUserPost(uid: uid, title: title, description: description) { res in
                print("ок")
            }
        }
       
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
