//
//  GeneratorView.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 26/05/2022.
//

import SwiftUI



struct GeneratorView: View {
    @EnvironmentObject var qrManager: QRManager
    @State private var toGenerate: String = ""
    
    func saveGenerated(content: String){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY"
        
        generatedData.append([content, dateFormatter.string(from: date)])
        UserDefaults.standard.set(generatedData, forKey: "generated")
        
    }
    
    var body: some View {
        VStack{
            if(generatedData.count == 0) // TODO: Docelowo: jeśli nie ma zapisanych wygenerowanych kodów
            {
                Spacer()
                Image(systemName: "hare.fill")
                    .resizable()
                    .frame(width: 150.0, height: 115.0)
                    .foregroundColor(Color(UIColor.lightGray))
                    
                Text("Nothing generated yet")
                    .foregroundColor(Color(UIColor.lightGray))
                    .padding(.top)
                Spacer()
            }
            else{
                List{
                    ForEach(generatedData, id: \.self){ item in
                        RowWidget(content: item[0], date: item[1],isGenerated: true)
                            .environmentObject(qrManager)
                        
                        
                    }
                }
            }
            TextField("Type qr code content", text: $toGenerate)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 14.0)
                .cornerRadius(50)
                .symbolVariant(.fill)
            Button("Generate"){
                saveGenerated(content: toGenerate)
                qrManager.detailScreen(qrContent: toGenerate)
            }
        }.background(Color.black)
        
        
    }
        
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
    }
}
