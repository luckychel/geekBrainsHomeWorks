//
//  BaseUICollectionViewController.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 16.10.2022.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var timer: Timer?

    // MARK: IBOutlet
    @IBOutlet weak var bgSquareView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.alpha = 0
        
        bgSquareView.layer.cornerRadius = 15
        bgSquareView.backgroundColor = .white

        loadingLabel.text = "Загрузка..."
        
        imageView.image = UIImage(named: "loadingIcon")
        
        DispatchQueue.main.async {
            if self.timer == nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.view.alpha = 1
        }
    }
    
    @objc
    private func animateView() {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: { [weak self] in
            guard let self = self else { return }
            self.infinityRotate(self.imageView, 1)
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })

    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            guard let self = self else { return }
            self.view.alpha = 0
        } completion: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func infinityRotate(_ imageView: UIImageView, _ aCircleTime: Double) {

        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.duration = aCircleTime
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.repeatCount = .infinity
        animation.values = [0, Double.pi/2, Double.pi, Double.pi*3/2, Double.pi*2]
        //Percentage of each key frame
        animation.keyTimes = [NSNumber(value: 0.0), NSNumber(value: 0.1),
                              NSNumber(value: 0.3), NSNumber(value: 0.8), NSNumber(value: 1.0)]
        
        imageView.layer.add(animation, forKey: "rotate")

    }
}
