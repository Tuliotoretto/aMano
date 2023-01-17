//
//  DatabaseManager.swift
//  aMano
//
//  Created by Julian Garcia  on 13/01/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let db = Firestore.firestore()
    
    public var user: UserModel?
    
    public func configure() {
        guard AuthManager.shared.isCurrentUserActive else {return}
        
        getUser(id: AuthManager.shared.userId)
    }
    
    // MARK: - User Methods
    public func createUser(user: UserModel, completion: ((Bool) -> Void)? = nil) {
        do {
            try db.collection(K.db.userCollection).document(user.id).setData(from: user.data) { error in
                if error == nil {
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        } catch {
            completion?(false)
        }
    }
    
    public func getUser(id: String, completion: ((UserModel?, Error?) -> Void)? = nil) {
        db.collection(K.db.userCollection).document(id).getDocument(as: UserData.self) {[weak self] result in
            switch (result) {
            case .success(let data):
                self!.user = UserModel(id: id, data: data)
                completion?(self!.user, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        }
    }
    
    public func updateUser(user: UserModel, completion: ((Bool) -> Void)? = nil) {
        do {
            try db.collection(K.db.userCollection).document(user.id).setData(from: user.data, merge: true) { err in
                if err == nil {
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        } catch {
            // TODO SHOW ERROR
            print(error)
            completion?(false)
        }
    }
    
    public func setUserListener(completion: ((Bool) -> Void)? = nil) {
        guard AuthManager.shared.isCurrentUserActive else {return}
        
        db.collection(K.db.userCollection).document(AuthManager.shared.userId)
            .addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {return}
                
                guard let data = try? document.data(as: UserData.self) else {return}
                
                self.user = UserModel(id: AuthManager.shared.userId, data: data)
                print("Usuario actualizado")
            }
    }
}
