//
//  StorageManager.swift
//  aMano
//
//  Created by Julian Garcia  on 17/01/23.
//

import Foundation
import FirebaseStorage

typealias StoreURL = String

class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage()
    private let storageRef = Storage.storage().reference()
    
    // Images
    
    func uploadImage(name: String, data: Data, completion: ((StoreURL?) -> Void)? = nil) {
        let imagesRef = storageRef.child("images/\(name)")
        
        imagesRef.putData(data) { _, err in
            if err != nil {
                completion?(nil)
                return
            }
            
            imagesRef.downloadURL { url, err in
                guard let url = url, err == nil else {return}
                completion?(url.absoluteString)
            }
        }
    }
    
    func downloadImage(url: String?, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = url else {return}
        
        let httpRef = storage.reference(forURL: url)
        
        httpRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            guard let data = data, error == nil else {
                completion?(nil)
                return
            }
            completion?(UIImage(data: data))
        }
    }
    
    func deleteImage(url: String, completion: ((Error?) -> Void)? = nil) {
        let httpRef = storage.reference(forURL: url)
        
        httpRef.delete { err in
            completion?(err)
        }
    }
}
