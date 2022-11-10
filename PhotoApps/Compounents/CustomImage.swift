//
//  CustomImage.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI

struct CustomImage: View {
    @StateObject private var viewModel = CustomImageViewModel(image: UIImage())
    @State var imageInfo: PhotosData
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Rectangle()
                    .frame(height: 130)
                    .overlay {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            }
        }
        .onAppear {
            viewModel.downloadimage(serverId: imageInfo.server ?? viewModel.emptySpace,
                                    photoId: imageInfo.id ?? viewModel.emptySpace,
                                    secret: imageInfo.secret ?? viewModel.emptySpace,
                                    resolution: "q")
        }

    }
}

struct CustomImage_Previews: PreviewProvider {
    static var viewModel = CustomImageViewModel(image: UIImage())
    static var previews: some View {
        DetailedImageView(imageInfo:
                            PhotosData(
                                id: viewModel.emptySpace,
                                owner: viewModel.emptySpace,
                                secret: viewModel.emptySpace,
                                server: viewModel.emptySpace,
                                farm: 0,
                                title: viewModel.emptySpace,
                                isPublic: 0,
                                isFriend: 0,
                                isFamily: 0,
                                description: Content(
                                    content: viewModel.emptySpace),
                                dateTaken: viewModel.emptySpace)
        )
    }
}
