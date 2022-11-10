//
//  DetailedImageView.swift
//  PhotoApps
//
//  Created by Alexis on 2/11/22.
//

import SwiftUI

struct DetailedImageView: View {
    @StateObject private var viewModel = CustomImageViewModel(image: UIImage())
    @State var imageInfo: PhotosData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.openURL) var openURL
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.bottom)
            }
        // MARK: - Descrition
            description
        }
        .navigationTitle(imageInfo.title ?? "")
        .preferredColorScheme(.light)
        .navigationBarBackButtonHidden()
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolBarButton
            }
        })
        .onAppear {
            viewModel.downloadimage(
                serverId: imageInfo.server ?? viewModel.emptySpace,
                photoId: imageInfo.id ?? viewModel.emptySpace,
                secret: imageInfo.secret ?? viewModel.emptySpace,
                resolution: "b")
        }
    }
}

struct DetailedImageView_Previews: PreviewProvider {
    static var viewModel = CustomImageViewModel(image: UIImage())
    static var previews: some View {
        DetailedImageView(imageInfo: PhotosData(
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
                content: viewModel.emptySpace
            ),
            dateTaken: viewModel.emptySpace)
        )
    }
}

extension DetailedImageView {
    private var description: some View {
        VStack(alignment: .leading) {
            Button {
                openURL((URL(string: "\(viewModel.baseUrl)\(imageInfo.server ?? "")/\(imageInfo.id ?? "")_\(imageInfo.secret ?? "")_\("c").jpg") ?? URL(string: viewModel.defaultURL))!)
            } label: {
                TextCustomPhotoApp(
                    text: viewModel.openBrowser,
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .center,
                    lineLimit: 1)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 20)
                    .background(.ultraThinMaterial.opacity(0.7))
                    .cornerRadius(5)
            }
            .accessibilityIdentifier("goToNavigator")
            .padding(.bottom, 5)
            HStack {
                TextCustomPhotoApp(
                    text: viewModel.owner,
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .center,
                    lineLimit: 1)
                    .accessibilityIdentifier("DetailedImageView")
                TextCustomPhotoApp(
                    text: imageInfo.owner ?? "",
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .center,
                    lineLimit: 1)
            }

            HStack {
                TextCustomPhotoApp(
                    text: viewModel.taken,
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .center,
                    lineLimit: 1)
                TextCustomPhotoApp(
                    text: imageInfo.dateTaken ?? "",
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .center,
                    lineLimit: 1)
            }
               TextCustomPhotoApp(
                text: imageInfo.description?.content ?? viewModel.defaulText,
                    fontName: "Poppins-Medium",
                    fontSize: 12,
                    fontColor: .white,
                    alignment: .leading,
                    lineLimit: 4)
                    .padding(.trailing, 150)

        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .bottomLeading)
        .padding(.leading, 25)
        .padding(.bottom, 40)
    }
    private var toolBarButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            TextCustomPhotoApp(
                text: viewModel.back,
                fontName: "Poppins-Medium",
                fontSize: 16,
                fontColor: .black,
                alignment: .center,
                lineLimit: 1)
        }
        .accessibilityIdentifier("backToSearch")
    }
}
