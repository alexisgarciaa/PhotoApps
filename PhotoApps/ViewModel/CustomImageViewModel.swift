//
//  CustomImageViewModel.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI
import Combine

class CustomImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    let loader = DownloadImageService()
    var cancelable = Set<AnyCancellable>()
    
    func downloadimage(serverId: String, photoId: String, secret: String,resolution: String) {
       // self.image = UIImage(systemName: "heart.fill")
        loader.downloadimage(serverId: serverId, photoId: photoId, secret: secret,resolution: resolution)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                    self?.image = image
            }
            .store(in: &cancelable)

    }
}
