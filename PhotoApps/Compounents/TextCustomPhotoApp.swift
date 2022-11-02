//
//  TextCustomPhotoApp.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI

struct TextCustomPhotoApp: View {
    @State var text: String
    @State var fontName: String
    @State var fontSize: CGFloat
    @State var fontColor: Color
    @State var alignment: TextAlignment
    @State var lineLimint: Int
    
    init(text: String = "", fontName: String = "Poppins-Regular" , fontSize: CGFloat = 18, fontColor: Color = .black, alignment: TextAlignment = .center, lineLimit: Int = 1){
        self.text = text
        self.fontSize = fontSize
        self.fontName = fontName
        self.fontColor = fontColor
        self.alignment = alignment
        self.lineLimint = lineLimit
    }
    
    var body: some View{
        VStack{
            Text(text)
                .font(.custom(fontName, size: fontSize))
                .foregroundColor(fontColor)
                .multilineTextAlignment(alignment)
                .lineLimit(lineLimint)
        }
    }
}

struct TextCustomPhotoApp_Previews: PreviewProvider {
    static var previews: some View {
        TextCustomPhotoApp()
    }
}
