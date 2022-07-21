//
//  CustomSegue.swift
//  WeatherApp
//
//  Created by user on 31/07/2019.
//  Copyright © 2019 Morizo Digital. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    private let animationDuration = 1.0
    
    override func perform() {
        guard let containerView = source.view else { return }
        
        containerView.addSubview(destination.view)
        source.view.frame = containerView.frame
        destination.view.frame = containerView.frame
        
        destination.view.transform = CGAffineTransform(translationX: 0,
                                                       y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.destination.view.transform = .identity
        }) { completed in
            self.source.present(self.destination, animated: false)
        }
    }
}
