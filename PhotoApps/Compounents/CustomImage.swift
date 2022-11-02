//
//  CustomImage.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI

struct CustomImage: View {
    @StateObject private var viewModel = CustomImageViewModel()
    @State var imageInfo: PhotosData
    var body: some View{
        ZStack{
            if let image = viewModel.image{
                Rectangle()
                    .frame(height: 130)
                    .overlay {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
            }
        }
        .onAppear{
            viewModel.downloadimage(serverId: imageInfo.server ?? "", photoId: imageInfo.id ?? "", secret: imageInfo.secret ?? "",resolution: "q")
        }

    }
}


struct CustomImage_Previews: PreviewProvider {
    static var previews: some View {
        DetailedImageView(imageInfo: PhotosData(id: "", owner: "holasas", secret: "", server: "", farm: 0, title: "", isPublic: 0, isFriend: 0, isFamily: 0, description: Content(content: "holas a todos espero esten bien"),dateTaken: "holas mundo"))
    }
}
