//
//  UIImageView+Extensions.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 08/02/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func showImage(imgUrl: String?) {
        let activityView = UIActivityIndicatorView(style: .whiteLarge)
        addSubview(activityView)
        activityView.centerInSuperview()
        activityView.startAnimating()
        bringSubviewToFront(activityView)
        
        DispatchQueue.main.async {
            let url = URL(string: imgUrl ?? "")
            self.sd_setImage(with: url, placeholderImage: nil) { _, _, _, _ in
                activityView.stopAnimating()
            }
        }
        
    }
}
