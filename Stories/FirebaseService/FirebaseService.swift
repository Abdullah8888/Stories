//
//  FirebaseService.swift
//  Stories
//
//  Created by Abdullah on 10/02/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import RxSwift
import RxCocoa

struct ErrorModel: Codable, Error {
    let message: String?
}

protocol FirebaseServiceProtocol: AnyObject {
    func fetchData<T:Codable>(_ type: T.Type, path: String) -> Single<T>
}

class FirebaseService: FirebaseServiceProtocol {
    
    static let shared: FirebaseService = FirebaseService()
    private var firestoreDb: Firestore { Firestore.firestore() }
    
    func configure() {
        FirebaseApp.configure()
    }
 
    func fetchData<T:Codable>(_ type: T.Type, path: String) -> Single<T> {
        
        return Single<T>.create { (observer) -> Disposable in
            
            Firestore.firestore().collection(path).addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents, error == nil else {
                    let error = ErrorModel(message: error?.localizedDescription ?? .defaultError)
                    observer(.error(error))
                    return
                }
                
                let data = documents.compactMap({ (queryDocumentSnapshot) in
                    return try? queryDocumentSnapshot.data(as: T.self)
                })
            
                if data.isEmpty {
                    let error = ErrorModel(message: .noDataAvailable)
                    observer(.error(error))
                }
                else {
                    observer(.success(data[0]))
                }
            }
            return Disposables.create()
        }
    }
    
}
