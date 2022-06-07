//
//  QRManager.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 26/05/2022.
//

import Foundation
import CoreLocation

class QRManager: NSObject, ObservableObject {
    
    
    
    @Published var _mainScreen = true
    @Published var _qrContent: String = ""
    
    override init() {
        super.init()
    }
    
    
    func mainScreen(){
        _mainScreen = true
    }
    
    func detailScreen(qrContent: String)
    {
        _qrContent = qrContent
        _mainScreen = false
    }
    
}
