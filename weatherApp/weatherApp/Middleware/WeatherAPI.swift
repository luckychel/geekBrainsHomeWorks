//
//  WeatherAPI.swift
//  weatherApp
//
//  Created by Александр Кукоба on 13.08.2022.
//

import Foundation
import Alamofire

class WeatherAPI {
    static let shared = WeatherAPI()
    
    private init() {}
    
    static let baseUrl : String = "https://api.openweathermap.org/data/2.5/onecall?"
    static var exclude: String = "hourly,minutely" //daily
    static let apiKey: String = "7ff5a20f087fc13a24dd315ccaa6709f"
    
    func getWeather(lat: Double, lon: Double, exclude: String, completion: @escaping (Weather)->()) {
        
        let parameters: Parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "exclude": (exclude.isEmpty ? "" : WeatherAPI.exclude),
            "appid": WeatherAPI.apiKey
        ]
        
        AF.request(WeatherAPI.baseUrl, parameters: parameters).responseData { response in
            
            guard let data = response.value else { return }
            
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
 
            guard let weather = weather else { return }
            
            completion(weather)
        }
        
        
    }
    
}
