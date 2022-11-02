//
//  PhotosDataModelResponse.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import Foundation

struct ResponsePhotos: Codable {
    let photos: PhotosDataModel
    enum CodingKeys: String, CodingKey{
        case photos = "photos"
    }
}

struct PhotosDataModel: Codable {
    let page: Int
    let pages: Int
    let perPage: Int
    let total: Int?
    let photo: [PhotosData]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perPage = "perpage"
        case total = "total"
        case photo = "photo"
    }
}

struct PhotosData: Codable, Hashable {
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let isPublic: Int?
    let isFriend: Int?
    let isFamily: Int?
    let description: Content?
    let dateTaken: String?
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
        case description = "description"
        case dateTaken = "datetaken"
    }
}

struct Content: Codable, Hashable {
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}
