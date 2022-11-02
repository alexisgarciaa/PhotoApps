//
//  HomeSearchView.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI
import Contacts

struct HomeSearchView: View {
    @StateObject private var photosVm = HomeSearchViewModel(searchText: "")
    @StateObject var network = NetworkConnection()
    let columns:[GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 1,alignment: nil),
        GridItem(.flexible(minimum: 100), spacing: 1,alignment: nil),
        GridItem(.adaptive(minimum: 100), spacing: 1,alignment: nil),
        ]
    @FocusState private var hideKeyboard: Bool
    @State var showAlert: Bool = false
    var body: some View {
        NavigationView {
            ZStack() {
            Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.bottom)
                content
                searchBar
                if showAlert{
                    CustomAlert(title: .constant("Permission not provided!!"), subtitle: .constant("In order to use the conctac list to search feature, we need permission\n go to Setting -> Privacy\n contacts"), imageName: .constant("alertImage")) {
                        showAlert = false
                        photosVm.settingsOpener()
                    }
                }
                if !(network.connected ?? true){
                    CustomAlert(title: .constant("Internet Connection"), subtitle: .constant("In order to use the App we need a internet connection"), imageName: .constant(nil)) {}
                }
            }
            .navigationTitle("Photos Challenge")
            .navigationBarTitleDisplayMode(.inline)
            .task(priority: .high) {
                await  photosVm.fetchAllContacts()
            }
            .onAppear{
                photosVm.checkContactPermission()
            }
        }
        .preferredColorScheme(.light)
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
    }
}


extension HomeSearchView{
    private var content: some View {
        VStack{
                if photosVm.dataArray.isEmpty || photosVm.dataArray == nil{
                    TextCustomPhotoApp(text: "Find Flickr photos by \nsearching names in the \nsearch bar below", fontName: "Poppins-Regular", fontSize: 18, fontColor: .black.opacity(0.60), alignment: .center, lineLimit: 3)
                        .padding(.top, 100)
                }else {
                ScrollView(showsIndicators: false){
                    LazyVGrid(columns: columns,spacing: 14){
                    ForEach(photosVm.dataArray, id: \.hashValue) { item in
                    NavigationLink {
                            DetailedImageView(imageInfo: item)
                        } label: {
                                CustomImage(imageInfo: item)
                        }
                        .accessibilityIdentifier("CardView")
                        .onAppear{
                            if item.hashValue == photosVm.dataArray.last?.hashValue{
                                photosVm.fetchDataInfinity(perPage: 40, newSearch: true)
                            }
                        }
                        .simultaneousGesture(
                        TapGesture()
                            .onEnded({ _ in
                                hideKeyboard = false
                            })
                        )
                    }
                        if photosVm.loadingState {
                            ProgressView()
                        }
                }
            }
        }
           
        }

    }
    
    private var searchBar: some View {
        CustomSearchBar(textInput: $photosVm.searchText,names: $photosVm.names,showAlert: $showAlert)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .onChange(of: photosVm.searchText, perform: { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if newValue.isEmpty{
                        photosVm.dataArray = []
                    }else {
                        photosVm.fetchDataInfinity(perPage: 40, newSearch: false)
                    }
                }
            })
            .focused($hideKeyboard)
            .padding(.bottom,5)
    }
}
