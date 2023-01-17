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
    
    private var verificationID: String?
    
    // MARK: - Configuration
    public func configure() {
        auth.useAppLanguage()
    }
    
    // MARK: - Auth
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) {
            [weak self] verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(false)
                return
            }
            self?.verificationID = verificationID
            completion(true)
        }
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = verificationID else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
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
    
    public var userPhoneNumber: String {
        get {auth.currentUser!.phoneNumber!}
    }
    
    public var isCurrentUserActive: Bool {
        get {
            auth.currentUser != nil ? true : false
        }
    }
    
    public func logout(completion: (() -> Void)? = nil) {
        do {
            try auth.signOut()
            DatabaseManager.shared.user = nil
            DispatchQueue.main.async {
                completion?()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
