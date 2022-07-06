//
//  LoginUIView.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 04.07.2022.
//

import UIKit

@IBDesignable class LoginUIView: UIView {

    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
//    var startColor: UIColor = .white // Начальный цвет градиента
//    var endColor: UIColor = .black // Конечный цвет градиента
//    var startLocation: CGFloat = 0 // Начало градиента
//    var endLocation: CGFloat = 1 // Конец градиента
//    var startPoint: CGPoint = .zero // Точка начала градиента
//    var endPoint: CGPoint = CGPoint(x: 0, y: 1) // Точка конца градиента
//
    
    func updateLocations() {
        self.gradientLayer.locations = [self.startLocation as NSNumber,
        self.endLocation as NSNumber]
    }
    func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
    
    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
}
