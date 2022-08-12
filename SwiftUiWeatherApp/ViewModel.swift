//
//  ViewModel.swift
//  SwiftUiWeatherApp
//
//  Created by Marc Petit Vecino on 10/8/22.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var title = "N/A"
    @Published var temp = "N/A"
    @Published var description = "-"
    @Published var icon = ""
    @Published var country = ""
    
    init() {
        fetchWeather(lat: 41.390205, lon: 2.154007)
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=02fb550982a985bc4ce24704ca47921a&units=metric") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                if (lon != 0.0 && lat != 0.0) {
                    let model = try JSONDecoder().decode(WeatherModels.self, from: data)
                    DispatchQueue.main.async {
                        self.title = model.name
                        self.temp = "\(model.main.temp)º"
                        self.description = model.weather.first?.description ?? "No data"
                        self.icon = "https://openweathermap.org/img/wn/\(model.weather.first?.icon ?? "" )@2x.png"
                        self.country = model.sys.country
                    }
                }
            } catch {
                print(error)
            }
        }
    
        task.resume()
    }
    
}

