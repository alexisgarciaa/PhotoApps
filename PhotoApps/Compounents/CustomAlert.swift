//
//  CustomAlert.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI

struct CustomAlert: View {
    @Binding var title: String?
    @Binding var subtitle: String?
    @Binding var imageName: String?
    var action : () -> ()
    var body: some View{
        GeometryReader { reader in
            VStack{
                VStack{
                    if let title = title {
                        TextCustomPhotoApp(text: title,fontName: "Poppins-ExtraBold", fontSize: 17, fontColor: .red, alignment: .center, lineLimit: 1)
                            .padding(.bottom, 10)
                    }
                    if let subtitle = subtitle {
                        TextCustomPhotoApp(text: subtitle, fontName: "Poppins", fontSize: 12, fontColor: .black, alignment: .center, lineLimit: 6)
                    }
                    
                    if let image = imageName {
                        Image(image)
                            .resizable()
                            .frame(width: 200, height: 75)
                    }
                        TextCustomPhotoApp(text: "UNDERSTAND", fontName: "Poppins-Medium", fontSize: 12, fontColor: .white, alignment: .center, lineLimit: 1)
                    .frame(maxWidth: .infinity, maxHeight: 47)
                    .background {
                        Color.blue.cornerRadius(10)
                    }
                    .padding(.top, 15)
                    .onTapGesture {
                        action()
                    }
                    
                }
                .frame(width: reader.size.width * 0.7)
                .padding(EdgeInsets(top: 25, leading: 40, bottom: 35, trailing: 40))
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.6))
            //.animation(.easeInOut, value: showAlert)
        }
    }
}


struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(title: .constant("hola"), subtitle: .constant("hola"), imageName: .constant(nil), action: {})
    }
}

