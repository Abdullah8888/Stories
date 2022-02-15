//
//  Double+Extension.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import Foundation

extension Double {
    
    var formatDate: String {
        let datteString = "\(Date(timeIntervalSince1970: self/1000))".split(separator: " ")
        return datteString.isEmpty ? "" : String(datteString[0])
    }
}
