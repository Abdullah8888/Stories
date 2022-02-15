//
//  FirebaseServiceTest.swift
//  StoriesTests
//
//  Created by Abdullah on 10/02/2022.
//

import XCTest
@testable import Stories
import RxSwift

class FirebaseServiceTest: XCTestCase {

    var dd = UIView()
    func test_FirebaseService_WithSuccessStatus() {
        //dd = UIView()
        print("it is 1 \(dd)")
        let sut = makeSut()
        let res = sut.fetchData(StoryResponse.self, path: "")
        res.subscribe { [weak self] res in
            guard let _ = self else { return }
            XCTAssertNotNil(res)
        }.disposed(by: sut.disposeBag)
    }
    
    func test_FirebaseService_WithFalseStatus() {
        print("it is 2 \(dd)")
        let sut = makeSut(fetchStatus: false)
        let res = sut.fetchData(StoryResponse.self, path: "")
        res.subscribe { [weak self] res in
            guard let _ = self else { return }
            XCTAssertNotNil(res)
        }.disposed(by: sut.disposeBag)
    }
    
    func makeSut(fetchStatus: Bool = true) -> MockFirebaseService {
        let mockFirebaseService = MockFirebaseService()
        mockFirebaseService.fetchStatus = fetchStatus
        return mockFirebaseService
    }
    
    override func tearDown() {
        print("it is \(dd)")
        //super.tearDown()
        
    }

}

class MockFirebaseService: FirebaseServiceProtocol {
    var fetchStatus: Bool = true
    var error: ErrorModel? = nil
    let disposeBag = DisposeBag()
    var sampleStroryResponse: StoryResponse = StoryResponse(stories: [Story(caption: "caption 1", id: "001", url: "", timestamp: 3.9, video: true)])
    
    func fetchData<T:Codable>(_ type: T.Type, path: String) -> Single<T> {
        return Single<T>.create { [weak self] (observer) -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            if self.fetchStatus  {
                switch type {
                case is StoryResponse.Type:
                    observer(.success(self.sampleStroryResponse as! T))
                default:
                    break
                }
            }
            else {
                self.error = ErrorModel(message: .defaultError)
                if let err = self.error {
                    observer(.error(err))
                }
            }
            return Disposables.create()
        }
    }
}
