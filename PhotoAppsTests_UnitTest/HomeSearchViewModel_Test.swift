//
//  HomeSearchViewModel_Test.swift
//  PhotoAppsTests_UnitTest
//
//  Created by Alexis on 2/11/22.
//

import XCTest
import Combine
import Contacts
@testable import PhotoApps


final class HomeSearchViewModel_Test: XCTestCase {
    var viewModel: HomeSearchViewModel?
    var cancelable = Set<AnyCancellable>()
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func test_HomeSearchViewModel_dataArray_shouldBeEmpty() {
        //given
        //when
        let vm = HomeSearchViewModel(searchText: "")
        //then
        XCTAssertTrue(vm.dataArray.isEmpty)
        XCTAssertEqual(vm.dataArray.count, 0)
    }
    
    func test_HomeSearchViewModel_dataArray_shouldAddItem() {
        //given
        let vm = HomeSearchViewModel(searchText: "value")
        //when
        let loopCount : Int = Int.random(in: 1..<15)
        
        for _ in 0..<loopCount {
            vm.dataArray.append(PhotosData(id: "", owner: "", secret: "", server: "", farm: 4, title: "", isPublic: 4, isFriend: 1, isFamily: 1, description: Content(content: ""), dateTaken: ""))
        }
        
        //then
        XCTAssertTrue(!vm.dataArray.isEmpty)        
    }
    
    func test_HomeSearchViewModel_loadingState_Status_ShouldBeFalse() {
        //given
        let vm = HomeSearchViewModel(searchText: "v")
        
        vm.fetchDataInfinity(perPage: 1, newSearch: false)
        //when

        //then
        XCTAssertTrue(vm.loadingState)
    }
    func test_HomeSearchViewModel_loadingState_Status_ShouldBetrue() {
        //given
        let vm = HomeSearchViewModel(searchText: "value")
        //when
        vm.fetchDataInfinity(perPage: 1, newSearch: false)
                
        let loopCount : Int = Int.random(in: 1..<15)

        for _ in 0..<loopCount {
            vm.dataArray.append(PhotosData(id: "", owner: "", secret: "", server: "", farm: 4, title: "", isPublic: 4, isFriend: 1, isFamily: 1, description: Content(content: ""), dateTaken: ""))
        }
        
        //then
        XCTAssertFalse(!vm.loadingState)
    }
    
    func test_HomeSearchViewModel_fetchDataInfinity_shouldReturnItems() {
        //given
        let vm = HomeSearchViewModel(searchText: "val")
        //when
        let expectation = XCTestExpectation(description: "Should return items after a second")
        vm.$dataArray
            .dropFirst()
            .sink { returnItems in
                if !vm.newSearch{
                    expectation.fulfill()
                }
            }
            .store(in: &cancelable)
        vm.fetchDataInfinity(perPage: 1, newSearch: false)

        
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    
    func test_HomeSearchViewModel_fetchDataInfinity_shouldReturnItemswithTrueParameter() {
        //given
        let vm = HomeSearchViewModel(searchText: "val")
        //when
        let expectation = XCTestExpectation(description: "Should return items after a second")
        
        vm.$dataArray
            .dropFirst()
            .sink { returnItems in
                if !vm.newSearch{
                    expectation.fulfill()
                }
            }
            .store(in: &cancelable)
        vm.fetchDataInfinity(perPage: 1, newSearch: true)
        //then
        wait(for: [expectation], timeout: 5)
        XCTAssertGreaterThan(vm.dataArray.count, 0)
    }
    //MARK: In order to complete this test the contact permission should be off
    func test_HomeSearchViewModel_checkContactPermission_showAlertShouldBeTrue() {
        //given
        let vm = HomeSearchViewModel(searchText: "")
        
        //when
        let contactStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if contactStatus == .denied || contactStatus == .notDetermined {
            XCTAssertTrue(vm.showAlert)
        }
        //then
        
    }
    
    func test_HomeSearchViewModel_checkContactPermission_showAlertShouldBefalse() {
        //given
        let vm = HomeSearchViewModel(searchText: "")
        
        //when
        let contactStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        if contactStatus == .authorized{
            XCTAssertTrue(!vm.showAlert)
        }
        //then
        
    }
    
}
