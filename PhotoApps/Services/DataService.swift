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
    private init() { }

    func getData(
        perPage: Int,
        page: Int,
        searchText: String) -> AnyPublisher<ResponsePhotos, Error> {
        let baseUrl = "https://www.flickr.com/services/rest/?"
        let apiKey = "70fdb0e0bfd1f2a4e7a13143e2d01322"
        let method = "flickr.photos.search"
        let extras = "date_taken"
        let format = "json&nojsoncallback=1"

        let url: URL = URL(
            string: "\(baseUrl)method=\(method)&api_key=\(apiKey)&text=\(searchText)&extras=\(extras)&per_page=\(perPage)&page=\(page)&format=\(format)")!

       return  URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: ResponsePhotos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
