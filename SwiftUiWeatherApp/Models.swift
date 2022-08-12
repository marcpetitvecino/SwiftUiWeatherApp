//
//  Models.swift
//  SwiftUiWeatherApp
//
//  Created by Marc Petit Vecino on 10/8/22.
//

import Foundation

struct WeatherModels: Codable {
    let weather: [WeatherInfo]
    let main: CurrentWeather
    let name: String
    let sys: MoreData
}

struct WeatherInfo: Codable {
    let description: String
    let icon: String
}

struct CurrentWeather: Codable {
    let temp: Float
}

struct MoreData: Codable {
    let country: String
}
