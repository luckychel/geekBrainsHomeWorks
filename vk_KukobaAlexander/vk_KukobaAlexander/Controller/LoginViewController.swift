//
//  LoginViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 15.06.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var LoadingUIView: UIView!
    
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
              passwordTxt == ""
        else {
            self.show(message: "Поля должны быть пустыми")
            return
        }
        
        LoginBtn.isEnabled = false
        
//        let pointLayer = CAShapeLayer()
//        pointLayer.backgroundColor = UIColor.green.cgColor
//        pointLayer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
//        LoadingUIView.layer.addSublayer(pointLayer)
        
        var loadingPoints = [UIView]()

        for _ in 0...2{
           let loadingPoint = UIView()
           loadingPoints.append(loadingPoint)
        }

        for i in 0..<loadingPoints.count{
           LoadingUIView.addSubview(loadingPoints[i])
        }
        LoadingUIView.backgroundColor = .clear
        LoadingUIView.layer.opacity = 1

        for i in 0..<loadingPoints.count{
           loadingPoints[i].frame = CGRect(x: 54 + (i * 30),
                                    y: 10,
                                    width: 20,
                                    height: 20)
           loadingPoints[i].backgroundColor = .systemBlue
           loadingPoints[i].backgroundColor?.withAlphaComponent(1)
           loadingPoints[i].layer.cornerRadius = loadingPoints[i].frame.width / 2
           loadingPoints[i].layer.masksToBounds = true
           loadingPoints[i].layer.opacity = 0
        }

        for i in 0..<loadingPoints.count{
           UIView.animate(withDuration: 1,
                          delay: (Double(i) * 0.3),
                          options: [.repeat, .autoreverse],
           animations: {
               loadingPoints[i].layer.opacity = 1
           })
        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
               //self.performSegue(withIdentifier: "LoginSega", sender: nil)  //MARK: srart timer

                let TabBarView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TabBarView")
                TabBarView.transitioningDelegate = TabBarView as! TabBarViewController

                self.present(TabBarView, animated: true, completion: {
                    for i in 0..<loadingPoints.count {
                        loadingPoints[i].layer.opacity = 0
                        loadingPoints[i].layer.removeAllAnimations()
                    }
                    self.LoginBtn.isEnabled = true
                    
                })
        
            
            //self.navigationController?.pushViewController(TabBarView, animated: true)

       
        }  //MARK: end timer
       
    }
}

