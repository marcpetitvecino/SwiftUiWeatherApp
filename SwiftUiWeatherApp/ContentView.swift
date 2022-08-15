//
//  ContentView.swift
//  SwiftUiWeatherApp
//
//  Created by Marc Petit Vecino on 10/8/22.
//

import SwiftUI
import CoreLocation
import LocationPicker

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()
    @StateObject var locationManager = LocationManager()
    
    @State private var coordinates = CLLocationCoordinate2D(latitude: 41.390205, longitude: 2.154007)
    @State private var showSheet = false
    @State private var firstTime = true
    
    var body: some View {
        self.getCurrentCoords()
        return NavigationView {
            VStack {
                Text("location status: \(locationManager.statusString)")
                Spacer()
                Text("\(viewModel.title), \(viewModel.country)")
                    .font(.system(size: 24))
                AsyncImage(url: URL(string: viewModel.icon))
                    .frame(width: 130, height: 70)
                    .padding(.top)
                Text(viewModel.description)
                    .font(.system(size: 30))
                Text(viewModel.temp)
                    .font(.system(size: 44))
                    .padding(.top)
                Spacer()
                Button("Select location") {
                    self.showSheet.toggle()
                }
                .padding(.top)
                .navigationTitle("Weather")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showSheet, onDismiss: {
                    viewModel.fetchWeather(lat: coordinates.latitude, lon: coordinates.longitude)
                }) {
                    NavigationView {
                        // Just put the view into a sheet or navigation link
                        LocationPicker(instructions: "Tap somewhere to select your coordinates", coordinates: $coordinates)
                        
                        // You can assign it some NavigationView modifiers
                            .navigationTitle("Location Picker")
                            .navigationBarTitleDisplayMode(.inline)
                            .navigationBarItems(leading: Button(action: {
                                self.showSheet.toggle()
                            }, label: {
                                Text("Close").foregroundColor(.red)
                            }))
                    }
                }
            }
        }
    }
    
    private func getCurrentCoords() {
        if let coords = locationManager.lastLocation?.coordinate {
            coordinates = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
