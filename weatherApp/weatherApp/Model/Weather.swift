//
//  Weather.swift
//  weatherApp
//
//  Created by Александр Кукоба on 13.08.2022.
//

import Foundation

struct Utility {
    static func TimestampToDate(ts: Int!) -> Date {
        guard let ts = ts else { return Date.now }
        return NSDate(timeIntervalSince1970: Double(ts)) as Date
    }

    static func KelvinToCelciy(temp: Double) -> Double {
        return temp - 273.15
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily
    }
}

// MARK: - Current
struct Current: Decodable {
    let dt: Date
    let sunrise, sunset: Date?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]

    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise, sunset
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dt = try container.decode(Int.self, forKey: .dt)
        self.dt = Utility.TimestampToDate(ts: dt)

        let sunrise = try container.decode(Int?.self, forKey: .sunrise)
        self.sunrise = Utility.TimestampToDate(ts: sunrise)
        
        let sunset = try container.decode(Int?.self, forKey: .sunset)
        self.sunset = Utility.TimestampToDate(ts: sunset)

        let temp = try container.decode(Double.self, forKey: .temp)
        self.temp = Utility.KelvinToCelciy(temp: temp)

        let feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.feelsLike = Utility.KelvinToCelciy(temp: feelsLike)

        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.uvi = try container.decode(Double.self, forKey: .uvi)

        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.visibility = try container.decode(Int.self, forKey: .visibility)

        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.windGust = try container.decode(Double.self, forKey: .windGust)
        self.weather = try container.decode([WeatherElement].self, forKey: .weather)
    }
}

// MARK: - Daily
struct Daily: Decodable {
    let dt, sunrise, sunset, moonrise, moonset: Date
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let clouds: Int
    let pop, uvi: Double

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, uvi
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dt = try container.decode(Int.self, forKey: .dt)
        self.dt = Utility.TimestampToDate(ts: dt)

        let sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunrise = Utility.TimestampToDate(ts: sunrise)
        
        let sunset = try container.decode(Int.self, forKey: .sunset)
        self.sunset = Utility.TimestampToDate(ts: sunset)
        
        let moonrise = try container.decode(Int.self, forKey: .moonrise)
        self.moonrise = Utility.TimestampToDate(ts: moonrise)
        
        let moonset = try container.decode(Int.self, forKey: .moonset)
        self.moonset = Utility.TimestampToDate(ts: moonset)

        self.moonPhase = try container.decode(Double.self, forKey: .moonPhase)
        
        self.temp = try container.decode(Temp.self, forKey: .temp)
        self.feelsLike = try container.decode(FeelsLike.self, forKey: .feelsLike)

        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.windGust = try container.decode(Double.self, forKey: .windGust)
        self.weather = try container.decode([WeatherElement].self, forKey: .weather)
        
        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.pop = try container.decode(Double.self, forKey: .pop)
        self.uvi = try container.decode(Double.self, forKey: .uvi)
        
    }
}

// MARK: - Current
struct Hourly: Decodable {
    let dt: Date
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [WeatherElement]
    let pop: Int?
    
    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather
        case pop
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dt = try container.decode(Int.self, forKey: .dt)
        self.dt = Utility.TimestampToDate(ts: dt)

        let temp = try container.decode(Double.self, forKey: .temp)
        self.temp = Utility.KelvinToCelciy(temp: temp)

        let feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.feelsLike = Utility.KelvinToCelciy(temp: feelsLike)

        self.pressure = try container.decode(Int.self, forKey: .pressure)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.dewPoint = try container.decode(Double.self, forKey: .dewPoint)
        self.uvi = try container.decode(Double.self, forKey: .uvi)

        self.clouds = try container.decode(Int.self, forKey: .clouds)
        self.visibility = try container.decode(Int.self, forKey: .visibility)

        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.windDeg = try container.decode(Int.self, forKey: .windDeg)
        self.windGust = try container.decode(Double.self, forKey: .windGust)
        self.weather = try container.decode([WeatherElement].self, forKey: .weather)

        self.pop = try container.decode(Int?.self, forKey: .pop)
    }
}

// MARK: - Minutely
struct Minutely: Codable {
    let dt: Date
    let precipitation: Int
    
    enum CodingKeys: String, CodingKey {
       case dt, precipitation
    }
    
    init(from decoder: Decoder) throws {
        let contaiter = try decoder.container(keyedBy: CodingKeys.self)
        
        let dt = try contaiter.decode(Int.self, forKey: .dt)
        self.dt = Utility.TimestampToDate(ts: dt)
        
        self.precipitation = try contaiter.decode(Int.self, forKey: .precipitation)
        
    }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let day = try container.decode(Double.self, forKey: .day)
        self.day = Utility.KelvinToCelciy(temp: day)
        
        let night = try container.decode(Double.self, forKey: .night)
        self.night = Utility.KelvinToCelciy(temp: night)
                                                  
        let eve = try container.decode(Double.self, forKey: .eve)
        self.eve = Utility.KelvinToCelciy(temp: eve)
                                            
        let morn = try container.decode(Double.self, forKey: .morn)
        self.morn = Utility.KelvinToCelciy(temp: morn)
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night, eve, morn: Double
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let day = try container.decode(Double.self, forKey: .day)
        self.day = Utility.KelvinToCelciy(temp: day)
        
        let night = try container.decode(Double.self, forKey: .night)
        self.night = Utility.KelvinToCelciy(temp: night)
                                                  
        let eve = try container.decode(Double.self, forKey: .eve)
        self.eve = Utility.KelvinToCelciy(temp: eve)
                                            
        let morn = try container.decode(Double.self, forKey: .morn)
        self.morn = Utility.KelvinToCelciy(temp: morn)
        
        let min = try container.decode(Double.self, forKey: .min)
        self.min = Utility.KelvinToCelciy(temp: min)
        
        let max = try container.decode(Double.self, forKey: .max)
        self.max = Utility.KelvinToCelciy(temp: max)

    }
}


// MARK: - WeatherElement
struct WeatherElement: Decodable {
    let id: Int
    let main: String?
    let weatherDescription: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

