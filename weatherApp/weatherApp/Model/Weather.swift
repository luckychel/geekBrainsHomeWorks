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
//    let hourly: [Current]
//    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely//, hourly, daily
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

// MARK: - WeatherElement
struct WeatherElement: Decodable {
    let id: Int
    let main: Main
    let weatherDescription: Description
    let icon: Icon

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Icon: String, Decodable {
    case the02N = "02n"
    case the03D = "03d"
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
    case the10D = "10d"
}

enum Main: String, Decodable {
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Daily
struct Daily: Decodable {
    let dt, sunrise, sunset, moonrise: Int
    let moonset: Int
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
    let rain: Double?

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
        case weather, clouds, pop, uvi, rain
    }
}

// MARK: - FeelsLike
struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
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
