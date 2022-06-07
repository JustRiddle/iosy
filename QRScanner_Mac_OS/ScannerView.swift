//
//  ScannerView.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 26/05/2022.
//

import SwiftUI
import CodeScanner

struct ScannerView: View {
    @EnvironmentObject var qrManager: QRManager
    @State var isScanner = false
    @State var scannedCode: String = "Click \"Scan\" to start"
    
    var scannerSheet : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    self.scannedCode = code.string
                    saveScanned(content: scannedCode)
                    self.isScanner = false
                    qrManager.detailScreen(qrContent: scannedCode)
                    
                }
            })
    }
    
    func saveScanned(content: String){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        
        scannedData.append([content, dateFormatter.string(from: date)])
        UserDefaults.standard.set(scannedData, forKey: "scanned")
        
    }
    
    var body: some View {
        HStack{
            Spacer()
        VStack{
            if(scannedData.count == 0) // TODO: docelowo: Docelowo: jeśli nie ma zapisanych zeskanowanych kodów
            {
                Spacer()
                Image(systemName: "hare.fill")
                    .resizable()
                    .frame(width: 150.0, height: 115.0)
                    .foregroundColor(Color(UIColor.lightGray))
                    
                Text("Nothing scanned yet")
                    .foregroundColor(Color(UIColor.lightGray))
                    .padding(.top)
                Spacer()
            }
            else
            {
                List{
                    ForEach(scannedData, id: \.self){ item in
                        RowWidget(content: item[0], date: item[1], isGenerated: false)
                            .environmentObject(qrManager)
                        
                    }
                }
            }
            
            VStack(spacing: 10) {
                
                Button("Scan QR"){
                    self.isScanner = true
                }
                .sheet(isPresented: $isScanner){
                    self.scannerSheet
                }
            }
        }
            Spacer()
        }.background(Color.black)
        
        
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
