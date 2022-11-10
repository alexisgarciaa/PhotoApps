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
    @Published var searchText: String
    @Published var dataArray: [PhotosData] = []
    @Published var count = 1
    @Published var newSearch: Bool = false
    @Published var names: [CNContact] = []
    @Published var loadingState: Bool = false
    @Published var showAlert: Bool = false

    var cancelable = Set<AnyCancellable>()
    let dataService: DataServiceProtocol

    init( searchText: String,
          dataService: DataServiceProtocol = DataService.shared) {
            self.dataService = dataService
            self.searchText = searchText
        }
    /**
     This method return photos

        Ass long as you scroll down you will fetch more image realted to the search text


     - parameter perPage: amount per page.
     - parameter newSearch: last item on the array to fetch more data.

     # Notes: #
     1. Parameters must be **Int** type

     # Example #
    ```
     ```
    */
    func fetchDataInfinity(
        perPage: Int,
        newSearch: Bool) {
        loadingState = true
        dataService.getData(
            perPage: perPage,
            page: count,
            searchText: searchText.replacingOccurrences(of: " ", with: "").forSorting)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] returnData in
                if newSearch {
                        self?.count += 1
                        self?.dataArray.append(contentsOf: returnData.photos.photo)
                        self?.loadingState = false
                } else {
                    self?.dataArray =  returnData.photos.photo
                    self?.loadingState = false
                }
            }
            .store(in: &cancelable)
    }
    
    /**
     This method return all cantacts into a list if the presmission is given
    ```
     ```
    */
     func fetchAllContacts() async {
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey] as [CNKeyDescriptor ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        do {
                try store.enumerateContacts(
                    with: fetchRequest,
                    usingBlock: {[weak self] contact, _ in
                    self?.names.append(contact)
                })

        } catch {
            print(error.localizedDescription)
        }

    }

    func checkContactPermission() {
        switch CNContactStore.authorizationStatus(for: CNEntityType.contacts) {
        case .authorized:
            showAlert = false
        case.denied, .notDetermined:
            DispatchQueue.main.async {
                self.showAlert = true
            }
        default:
            break
        }
    }
    /**
     This method make you go to settings

        If permission are not given and you tap on contact list button this method will c


     - parameter perPage: amount per page.
     - parameter newSearch: last item on the array to fetch more data.

     # Notes: #
     1. Parameters must be **Int** type

     # Example #
    ```
     ```
    */
    func settingsOpener() {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
}
