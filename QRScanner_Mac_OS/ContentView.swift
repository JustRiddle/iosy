//
//  ContentView.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 11/05/2022.
//

import SwiftUI
import CodeScanner   // https://github.com/twostraws/CodeScanner f

//let dummyData = [["first", "25.05.2022"], ["second very long qr code content that must be cut because it won't fit in two lines", "13.05.2022"], ["third", "10.04.2022"]]

var generatedData = UserDefaults.standard.object(forKey: "generated") as? [[String]] ?? [[String]]()
var scannedData = UserDefaults.standard.object(forKey: "scanned") as? [[String]] ?? [[String]]()
struct ContentView: View {
    @StateObject var qrManager = QRManager()
    
    
    var body: some View {
        
        if qrManager._mainScreen
        {
            TabView{
                ScannerView()
                    .environmentObject(qrManager)
                    .tabItem{
                        Image(systemName: "qrcode.viewfinder")
                        Text("Scanner")
                    }
                GeneratorView()
                    .environmentObject(qrManager)
                    .tabItem{
                        Image(systemName: "qrcode")
                        Text("Generator")
                    }
            }
            
        }
        else
        {
            DetailView()
                .environmentObject(qrManager)
        }
        
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
