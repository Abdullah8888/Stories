//
//  StoriesViewModelTest.swift
//  StoriesTests
//
//  Created by Abdullah on 11/02/2022.
//

import XCTest
@testable import Stories
import RxSwift

class StoriesViewModelTest: XCTestCase {
    
    func test_fetchStories_WithSuccessStatus(){
        let sut = makeSut()
        sut.storyResponse.subscribe { [weak self] value in
            guard let _ = self else { return }
            if let response = value.element {
                XCTAssertTrue(response.stories.count > 0)
                XCTAssertEqual(response.stories[0].caption , "caption 1")
            }
        }.disposed(by: sut.bag)
        sut.fetchStories()
    }
    
    func test_fetchStories_WithSuccessFails() {
        let mockNetworkService = makeMockNetworkService(fetchStatus: false)
        let sut = makeSut(mockNetworkService)
        sut.storyResponse.subscribe { [weak self] value in
            guard let _ = self else { return }
            XCTAssertNil(value)
            
        }.disposed(by: sut.bag)
        sut.fetchStories()
    }
    
    func makeSut(_ mockFirebaseService: MockFirebaseService = MockFirebaseService()) -> StoriesViewModel {
        let viewModel = StoriesViewModel()
        viewModel.firebaseService = mockFirebaseService
        return viewModel
    }
    
    func makeMockNetworkService(fetchStatus: Bool = true) -> MockFirebaseService {
        let mockFirebaseService = MockFirebaseService()
        mockFirebaseService.fetchStatus = fetchStatus
        return mockFirebaseService
    }
}
