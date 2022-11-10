//
//  DataService.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI
import Combine

protocol DataServiceProtocol {
    func getData(perPage: Int, page: Int, searchText: String) -> AnyPublisher<ResponsePhotos, Error>
}

class DataService: DataServiceProtocol {
    static let shared: DataServiceProtocol = DataService()
    let baseUrl = String(localized: "baseUrlDataService")
    let apikey = String(localized: "apiKey")
    let format = String(localized: "format")
    private init() { }

    func getData(
        perPage: Int,
        page: Int,
        searchText: String) -> AnyPublisher<ResponsePhotos, Error> {
        let method = "flickr.photos.search"
        let extras = "date_taken"

        let url: URL = URL(
            string: "\(baseUrl)method=\(method)&api_key=\(apikey)&text=\(searchText)&extras=\(extras)&per_page=\(perPage)&page=\(page)&format=\(format)")!

       return  URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: ResponsePhotos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
