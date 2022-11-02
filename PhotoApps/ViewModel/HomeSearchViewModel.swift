//
//  HomeSearchViewModel.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import Foundation
import Combine
import Contacts
import SwiftUI


class HomeSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var dataArray: [PhotosData] = []
    @Published var count = 1
    @Published var newSearch: Bool = false
    @Published var names : [CNContact] = []
    @Published var loadingState: Bool = false
    @Published var showAlert: Bool = false
    var cancelable = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    
    init( dataService: DataServiceProtocol = DataService.shared) {
            self.dataService = dataService
        }
    
    func fetchDataInfinity(perPage: Int,newSearch: Bool) {
        loadingState = true
        dataService.getData(perPage: perPage, page: count,searchText: searchText.replacingOccurrences(of: " ", with: "").forSorting)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] returnData in
                if newSearch {
                        self?.count += 1
                        self?.dataArray.append(contentsOf: returnData.photos.photo)
                        self?.loadingState = false
                }else{
                    self?.dataArray =  returnData.photos.photo
                    self?.loadingState = false
                }
            }
            .store(in: &cancelable)
    }
    
     func fetchAllContacts() async {
         //Run in the backgroaund
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey] as [CNKeyDescriptor ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: {[weak self] contact, Result in
                    print(contact.givenName )
                    self?.names.append(contact)
                })
                
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    func checkContactPermission() {
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts){
        case .authorized:
            print("acces")
            showAlert = false
        case.denied, .notDetermined:
            print("denied")
            DispatchQueue.main.async {
                self.showAlert = true
            }
        default:
            break
        }
    }
    
       func settingsOpener(){
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
}
