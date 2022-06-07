//
//  ContentView.swift
//  Weather_App
//
//  Created by RMS on 10/03/2022.
//

import SwiftUI
import SimpleToast




struct ContentView: View {
    @State private var showToast = false
    private let toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 2,
        backdrop: Color.black.opacity(0.1),
        animation: .default,
        modifierType: .skew
    )
    
    @StateObject var locationManager = LocationManager()
    @StateObject var navigationManager = NavigationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?

    @State var chosenCity: String = ""
    
    
    
    var body: some View {
        VStack {
            
            if navigationManager._chooseByName
            {
                SearchView()
                    .environmentObject(navigationManager)
                
            }
            else if navigationManager._chooseByMap
            {
                MapView()
                    .environmentObject(navigationManager)
                    .environmentObject(locationManager)
            }
            else {
                if navigationManager._chosenByName
                {
                    LoadingView()
                    .task {
                        do{
                            weather = try await weatherManager.getWeatherByName(cityName: navigationManager._chosenCity)
                            
                        }catch{
                            showToast.toggle()
                        }
                        navigationManager._chosenByName = false
                        
                    }
                }
                if navigationManager._chosenByMap
                {
                    LoadingView()
                    .task {
                        do{
                            weather = try await weatherManager.getCurrentWeather(
                                latitude: navigationManager._chosenCoords.latitude,
                                lonigtude: navigationManager._chosenCoords.longitude)
    
                        }catch{
                            print("wywalil sie na chosenByMap")
                        }
                        navigationManager._chosenByMap = false
                    }
                }
                if let location = locationManager.location {
                    if let weather = weather {
                        WeatherView(weather: weather)
                            .environmentObject(navigationManager)
                            .environmentObject(locationManager) //
                    }
                    else{
                        LoadingView()
                            .task {
                                do{
                                    weather = try await weatherManager.getCurrentWeather(latitude:  location.latitude, lonigtude: location.longitude)
                
                                }catch{
                                    print("Error getting weather: \(error)")
                                }
                            }
                
                    }
                 } else {
                     if locationManager.isLoading {
                         LoadingView()
                     } else {
                         WelcomeView()
                             .environmentObject(locationManager)
                     }
                }
            }
            
            
            
        }.background(Color(hue: 0.678, saturation: 0.845, brightness: 0.406))
            .preferredColorScheme(.dark)
            .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {
                
            }){
                HStack{
                    Text("Unable to find this city")
                }
                .padding(20)
                .background(Color(hue: 0.678, saturation: 0.845, brightness: 0.406))
                .foregroundColor(Color.white)
                .cornerRadius(15)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
