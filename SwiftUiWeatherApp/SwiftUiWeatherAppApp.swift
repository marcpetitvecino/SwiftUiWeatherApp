//
//  SwiftUiWeatherAppApp.swift
//  SwiftUiWeatherApp
//
//  Created by Marc Petit Vecino on 10/8/22.
//

import SwiftUI

@main
struct SwiftUiWeatherAppApp: App {
    var body: some Scene {
        @ObservedObject var viewModel = WeatherViewModel()
        @ObservedObject var locationManager = LocationManager()
        WindowGroup {
            ContentView(viewModel: viewModel, locationManager: locationManager)
        }
    }
}
