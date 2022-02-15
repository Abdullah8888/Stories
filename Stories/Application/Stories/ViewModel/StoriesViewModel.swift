//
//  StoriesViewModel.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import Foundation
import RxSwift

class StoriesViewModel {
    let bag = DisposeBag()
    var firebaseService: FirebaseServiceProtocol = FirebaseService.shared
    var storyResponse: PublishSubject<StoryResponse> = PublishSubject<StoryResponse>()
    let loader = Loader.shared
    
    func fetchStories() {
        loader.showLoader()
        firebaseService.fetchData(StoryResponse.self, path: "story")
            .subscribe(onSuccess: { [weak self] response in
                Loader.shared.hideLoader()
                self?.storyResponse.onNext(response)
            }) {  error in
                self.loader.hideLoader()
                if let err = error as? ErrorModel {
                    Toast.shared.showToastWithTItle(err.message ?? .defaultError, type: .error)
                }
        }.disposed(by: bag)
    }

}
