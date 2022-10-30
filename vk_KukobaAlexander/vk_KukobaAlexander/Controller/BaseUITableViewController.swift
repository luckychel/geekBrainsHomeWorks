//
//  BaseUITableViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 16.10.2022.
//

import Foundation
import UIKit

class BaseUITableViewController: UITableViewController, LoadingProtocol {
    private var loadingViewController: LoadingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            guard self.loadingViewController == nil else { return }
            self.loadingViewController = LoadingViewController()
            self.loadingViewController?.modalPresentationStyle = .overFullScreen
            self.present(self.loadingViewController!, animated: false, completion: nil)
        }
    }
    
    func endLoading() {
        DispatchQueue.main.async
        {
            guard let vc = self.loadingViewController else { return }
            vc.hideLoading()
            self.loadingViewController = nil
        }
    }
}
