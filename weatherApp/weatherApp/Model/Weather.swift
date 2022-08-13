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
    let dt: Int
    let dtDate: Date
    let sunrise, sunset: Int?
    let sunriseDate, sunsetDate: Date?
    let temp, feelsLike: Double
    let tempCelciy, feelsLikeCelciy: Double
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

        self.dt = try container.decode(Int.self, forKey: .dt)
        self.dtDate = Utility.TimestampToDate(ts: self.dt)

        self.sunrise = try container.decode(Int?.self, forKey: .sunrise)
        self.sunset = try container.decode(Int?.self, forKey: .sunset)

        self.sunriseDate = Utility.TimestampToDate(ts: self.sunrise)
        self.sunsetDate = Utility.TimestampToDate(ts: self.sunset)

        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempCelciy = Utility.KelvinToCelciy(temp: self.temp)

        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.feelsLikeCelciy = Utility.KelvinToCelciy(temp: self.feelsLike)

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
    let dt, sunrise, sunset, moonrise, moonset: Int
    let dtDate, sunriseDate, sunsetDate, moonriseDate, moonsetDate: Date
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

        self.dt = try container.decode(Int.self, forKey: .dt)
        self.dtDate = Utility.TimestampToDate(ts: self.dt)

        self.sunrise = try container.decode(Int.self, forKey: .sunrise)
        self.sunset = try container.decode(Int.self, forKey: .sunset)
        self.moonrise = try container.decode(Int.self, forKey: .moonrise)
        self.moonset = try container.decode(Int.self, forKey: .moonset)
        
        self.sunriseDate = Utility.TimestampToDate(ts: self.sunrise)
        self.sunsetDate = Utility.TimestampToDate(ts: self.sunset)
        self.moonriseDate = Utility.TimestampToDate(ts: self.moonrise)
        self.moonsetDate = Utility.TimestampToDate(ts: self.moonset)

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
    let dt: Int
    let dtDate: Date
    let temp, feelsLike: Double
    let tempCelciy, feelsLikeCelciy: Double
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

        self.dt = try container.decode(Int.self, forKey: .dt)
        self.dtDate = Utility.TimestampToDate(ts: self.dt)

        self.temp = try container.decode(Double.self, forKey: .temp)
        self.tempCelciy = Utility.KelvinToCelciy(temp: self.temp)

        self.feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        self.feelsLikeCelciy = Utility.KelvinToCelciy(temp: self.feelsLike)

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
    let dt, precipitation: Int
    let dtDate: Date
    
    enum CodingKeys: String, CodingKey {
       case dt, precipitation
    }
    
    init(from decoder: Decoder) throws {
        let contaiter = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dt = try contaiter.decode(Int.self, forKey: .dt)
        self.dtDate = Utility.TimestampToDate(ts: self.dt)
        
        self.precipitation = try contaiter.decode(Int.self, forKey: .precipitation)
        
    }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
    let dayCelciy, nightCelciy, eveCelciy, mornCelciy: Double
    
    enum CodingKeys: String, CodingKey {
        case day, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.day = try container.decode(Double.self, forKey: .day)
        self.night = try container.decode(Double.self, forKey: .night)
        self.eve = try container.decode(Double.self, forKey: .eve)
        self.morn = try container.decode(Double.self, forKey: .morn)
 
        self.dayCelciy = Utility.KelvinToCelciy(temp: self.day)
        self.nightCelciy = Utility.KelvinToCelciy(temp: self.night)
        self.eveCelciy = Utility.KelvinToCelciy(temp: self.morn)
        self.mornCelciy = Utility.KelvinToCelciy(temp: self.morn)
    }
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night, eve, morn: Double
    let dayCelciy, minCelciy, maxCelciy, nightCelciy, eveCelciy, mornCelciy: Double
    
    enum CodingKeys: String, CodingKey {
        case day, min, max, night, eve, morn
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.day = try container.decode(Double.self, forKey: .day)
        self.min = try container.decode(Double.self, forKey: .min)
        self.max = try container.decode(Double.self, forKey: .max)
        self.night = try container.decode(Double.self, forKey: .night)
        self.eve = try container.decode(Double.self, forKey: .eve)
        self.morn = try container.decode(Double.self, forKey: .morn)
 
        self.dayCelciy = Utility.KelvinToCelciy(temp: self.day)
        self.minCelciy = Utility.KelvinToCelciy(temp: self.min)
        self.maxCelciy = Utility.KelvinToCelciy(temp: self.max)
        self.nightCelciy = Utility.KelvinToCelciy(temp: self.night)
        self.eveCelciy = Utility.KelvinToCelciy(temp: self.morn)
        self.mornCelciy = Utility.KelvinToCelciy(temp: self.morn)
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

