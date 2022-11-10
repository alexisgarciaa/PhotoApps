//
//  CustomImageViewModel.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI
import Combine

class CustomImageViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var defaulText = String(localized: "DefaultText")
    @Published var baseUrl = String(localized: "BaseUrl")
    @Published var emptySpace = String(localized: "EmptySpace")
    @Published var defaultURL = String(localized: "DefaulUrl")
    let loader: DownloadImageServiceProtocol
    var cancelable = Set<AnyCancellable>()
    init(image: UIImage? = nil,
         dataService: DownloadImageServiceProtocol = DownloadImageService.shared) {
            self.loader = dataService
            self.image = image
        }

    func downloadimage(
        serverId: String,
        photoId: String,
        secret: String,
        resolution: String) {
        loader.downloadimage(
            serverId: serverId,
            photoId: photoId,
            secret: secret,
            resolution: resolution)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] image in
                    self?.image = image
            }
            .store(in: &cancelable)
    }
}
