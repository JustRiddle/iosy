//
//  DetailView.swift
//  QRScanner_Mac_OS
//
//  Created by Bartek Wanot on 26/05/2022.
//
import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins


struct DetailView: View {
    @EnvironmentObject var qrManager: QRManager
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    var body: some View {
        VStack
        {
            HStack{
                Spacer()
                Button(action:{
                    qrManager.mainScreen()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .frame(width: 20, height: 20)
                            .padding()
                            .foregroundColor(.blue)
                    }
                
            }
            Spacer()
            VStack
            {
                Image(uiImage: generateQR(qrManager._qrContent))
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                Text(qrManager._qrContent)
            }
            Spacer()
        }
        
    }
    
    func generateQR(_ content: String) -> UIImage{
        let data = Data(content.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent){
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
