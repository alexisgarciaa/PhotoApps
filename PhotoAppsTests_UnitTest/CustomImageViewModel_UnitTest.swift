//
//  CustomImageViewModel_UnitTest.swift
//  PhotoAppsTests_UnitTest
//
//  Created by Alexis on 2/11/22.
//

import XCTest
import Combine
@testable import PhotoApps

final class CustomImageViewModelUnitTest: XCTestCase {
    var viewModel: CustomImageViewModel?
    var cancelable = Set<AnyCancellable>()
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_CustomImageViewModel_downloadimage_shouldStartNil() {
        // given
        let viewModel = CustomImageViewModel(image: UIImage())
        // when
        viewModel.image = nil

        // then
        XCTAssertNil(viewModel.image)
    }

    func test_CustomImageViewModel_downloadimage_shouldReturnImage() {
        // given
        let viewModel = CustomImageViewModel(image: UIImage())
        // when
        let expectation = XCTestExpectation(description: "Should return items after a second")
        viewModel.$image
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancelable)

        viewModel.downloadimage(serverId: "test",
                                photoId: "test",
                                secret: "test",
                                resolution: "b")
        viewModel.image = UIImage(named: "alertImage")

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(viewModel.image)
    }

}
