//
//  WeahterViewController.swift
//  weatherApp
//
//  Created by Александр Кукоба on 13.08.2022.
//

import UIKit

class WeahterViewController: UIViewController {

    let weatherApi = WeatherAPI.shared
    
    @IBOutlet var weatherTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //погода по городу Кимры
        weatherApi.getWeather(lat: 56.873268, lon: 37.355782, exclude: "") { data in
            print(data)
        }
    }


}

