//
//  NavigationManager.swift
//  Weather_App
//
//  Created by Bartek Wanot on 19/04/2022.
//

import Foundation
import CoreLocation

class NavigationManager: NSObject, ObservableObject {
    
    
    
    @Published var _mainScreen = true
    @Published var _chooseByName = false
    @Published var _chooseByMap = false
    
    @Published var _chosenCity: String = ""
    @Published var _chosenByName = false
    
    @Published var _chosenCoords: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @Published var _chosenByMap = false
    
    override init() {
        super.init()
    }
    
    func chooseByName(){
        _chooseByName = true
        _chooseByMap = false
        _mainScreen = false
    }
    
    func chooseByMap(){
        _chooseByName = false
        _chooseByMap = true
        _mainScreen = false
    }
    
    func mainScreen(){
        _chooseByName = false
        _chooseByMap = false
        _mainScreen = true
    }
    
    func setByName(cityName: String)
    {
        _chosenCity = cityName
        _chosenByName = true
        mainScreen()
    }
    
    func reloadCurrentLocation(coords: CLLocationCoordinate2D)
    {
        _chosenCoords = coords
        _chosenByMap = true
        mainScreen()
    }
    
    func setByMap(coords: CLLocationCoordinate2D)
    {
        _chosenCoords = coords
        _chosenByMap = true
        mainScreen()
    }
    
}
