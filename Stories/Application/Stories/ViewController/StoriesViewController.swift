//
//  StoriesViewController.swift
//  Stories
//
//  Created by Abdullah on 09/02/2022.
//

import Foundation
import UIKit

class StoriesViewController: BaseViewController<StoriesView> {
    
    var viewModel = StoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stories"
        viewModel.storyResponse.asObservable().subscribe { [weak self] response in
            guard let self = self else { return }
            self._view.data = response.element?.stories
        }.disposed(by: disposeBag)
        viewModel.fetchStories()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}
