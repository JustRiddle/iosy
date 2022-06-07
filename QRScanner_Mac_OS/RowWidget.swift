//
//  RowWidget.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 26/05/2022.
//

import SwiftUI



struct RowWidget: View {
    @EnvironmentObject var qrManager: QRManager
    var content: String
    var date: String
    var isGenerated: Bool
    @State private var showDialog = false

    var body: some View {
        
        HStack( spacing: 8){
            VStack(alignment: .leading){
                
                
                    Text(date)
                        .foregroundColor(.gray)
                        .font(.system(size: 12, weight: .light))
                    Text(content)
                        .lineLimit(2)
                        .font(.system(size: 18))
                        .onTapGesture(perform: {qrManager.detailScreen(qrContent: content)})
                
            }
            
            
            
            Spacer()
            VStack
            {
                
                
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .onTapGesture(perform: {showDialog = true})
                    
                
                .confirmationDialog("test", isPresented: $showDialog)
                {
                    Button("Delete"){
                        if isGenerated
                        {
                            generatedData.remove(at:  generatedData.firstIndex(of: [content,date])!)
                            UserDefaults.standard.set(generatedData, forKey: "generated")
                            qrManager.mainScreen()
                        }
                        else
                        {
                    
                            scannedData.remove(at:  scannedData.firstIndex(of: [content,date])!)
                            UserDefaults.standard.set(scannedData, forKey: "scanned")
                            qrManager.mainScreen()
                        }
                    }
                }
            }
            

        }
            }
}

//struct RowWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        RowWidget(content: "Test", date: "00.00.0000", false)
//    }
//}
