//
//  BaseViewController.swift
//  Stories
//
//  Created by Abdullah on 09/02/2022.
//

import UIKit
import RxSwift

class BaseViewController<SubView: UIView>: UIViewController {
    let _view: SubView
    let disposeBag = DisposeBag()
    
    init(view: SubView = SubView()) {
        self._view = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = _view
        view.clipsToBounds = true
    }
}
