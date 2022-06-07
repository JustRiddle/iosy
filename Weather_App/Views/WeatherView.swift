//
//  WeatherView.swift
//  Weather_App
//
//  Created by RMS on 24/03/2022.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var locationManager: LocationManager
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather now")
                            .bold()
                            .padding(.bottom)
                        
                        HStack {
                            WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + ("°")))
                            Spacer()
                            WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                        }
                        
                        HStack {
                            WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + " m/s"))
                            Spacer()
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.roundDouble())%")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                }

                
                HStack( spacing: 5) {
                    VStack{
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                    }
                    Spacer()
                    HStack{
                        Button(action:{
                            navigationManager.reloadCurrentLocation(coords: locationManager.curLocation!)
                        }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(50)
                                .foregroundColor(Color(hue: 0.678, saturation: 0.845, brightness: 0.406))
                        }
                        Button(action:{
                            navigationManager.chooseByName()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .frame(width: 20, height: 20)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(50)
                                .foregroundColor(Color(hue: 0.678, saturation: 0.845, brightness: 0.406))
                        }
                        Button(action:{
                            navigationManager.chooseByMap()
                        }) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.888))
                            .cornerRadius(50)
                            .foregroundColor(Color(hue: 0.678, saturation: 0.845, brightness: 0.406))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "cloud")
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 85))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
//                    Spacer()
//                        .frame(height:  80)
//
//                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 350)
//                    } placeholder: {
//                        ProgressView()
//                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
