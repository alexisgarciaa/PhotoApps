//
//  DownloadImageService.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI
import Combine

protocol DownloadImageServiceProtocol{
    func handlerResponse(data: Data?, response: URLResponse?) -> UIImage?
    
    func downloadimage(serverId: String, photoId: String, secret: String, resolution: String) -> AnyPublisher<UIImage?, Error>
}

class DownloadImageService: DownloadImageServiceProtocol{
   let url = URL(string: "https://live.staticflickr.com/.jpg")!
    
    static let shared: DownloadImageServiceProtocol = DownloadImageService()
    private init() { }
    func handlerResponse(data: Data?, response: URLResponse?) -> UIImage?{
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadimage(serverId: String, photoId: String, secret: String, resolution: String) -> AnyPublisher<UIImage?, Error>{
        URLSession.shared.dataTaskPublisher(for: URL(string: "https://live.staticflickr.com/\(serverId)/\(photoId)_\(secret)_\(resolution).jpg")!)
            .map(handlerResponse)
            .mapError({$0})
            .eraseToAnyPublisher()

    }
}
