//
//  AuthManager.swift
//  aMano
//
//  Created by Julian Garcia  on 09/01/23.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    // MARK: - Configuration
    public func configure() {
        auth.useAppLanguage()
    }
    
    // MARK: - User Management
    
    public var currentUser: User? {
        get {
            auth.currentUser
        }
    }
    
    public var userId: String {
        get {auth.currentUser!.uid}
    }
    
    public var userName: String? {
        get {
            auth.currentUser?.displayName
        }
    }
    
    public func setUser(name: String, photoURL: String?,  completion: ((Error?) -> Void)? = nil) {
        guard let changeRequest = auth.currentUser?.createProfileChangeRequest() else {return}
        
        changeRequest.displayName = name
        
        if let photoURL = photoURL {
            changeRequest.photoURL = URL(string: photoURL)
        }
        
        changeRequest.commitChanges() { err in
            completion?(err)
        }
    }
    
    public var userPhoneNumber: String {
        get {auth.currentUser!.phoneNumber!}
    }
    
    public var userImageURL: String? {
        get {
            auth.currentUser?.photoURL?.absoluteString
        }
    }
    
    public var isCurrentUserActive: Bool {
        get {
            auth.currentUser != nil ? true : false
        }
    }
    
    public func logout(completion: (() -> Void)? = nil) {
        do {
            try auth.signOut()
            DispatchQueue.main.async {
                completion?()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
