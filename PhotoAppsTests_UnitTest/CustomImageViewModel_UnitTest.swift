//
//  CustomImageViewModel_UnitTest.swift
//  PhotoAppsTests_UnitTest
//
//  Created by Alexis on 2/11/22.
//

import XCTest
import Combine
@testable import PhotoApps

final class CustomImageViewModel_UnitTest: XCTestCase {
    var viewModel: CustomImageViewModel?
    var cancelable = Set<AnyCancellable>()
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_CustomImageViewModel_downloadimage_shouldStartNil() {
        //given
        let vm = CustomImageViewModel(image: UIImage())
        //when
        vm.image = nil
       
        //then
        XCTAssertNil(vm.image)
    }
    
    func test_CustomImageViewModel_downloadimage_shouldReturnImage() {
        //given
        let vm = CustomImageViewModel(image: UIImage())
        //when
        let expectation = XCTestExpectation(description: "Should return items after a second")
        vm.$image
            .dropFirst()
            .sink { returnItems in
                expectation.fulfill()
            }
            .store(in: &cancelable)
        
        vm.downloadimage(serverId: "test", photoId: "test", secret: "test", resolution: "b")
        vm.image = UIImage(named: "alertImage")
        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(vm.image)
    }

}
