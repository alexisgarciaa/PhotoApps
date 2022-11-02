
//
//  SplashView.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI

struct SplashView: View {
    @State var showHomeView: Bool = false
    var body: some View {
        NavigationView {
            VStack{
                TextCustomPhotoApp(text: "Photos Challenge", fontName: "Poppins-Black", fontSize: 22)
                NavigationLink(isActive: $showHomeView) {
                    HomeSearchView()
                        .navigationBarBackButtonHidden()
                } label: {
                    EmptyView()
                }

            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                        showHomeView = true
                })
            }
        }
        .preferredColorScheme(.light)
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

