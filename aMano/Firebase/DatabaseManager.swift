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
    
    var groups = [Group]()
    
    // MARK: - Manage Groups DB
    // TODO CREATE GROUP
    func createGroup(_ group: Group, completion: ((DocumentReference?) -> Void)? = nil) {
        var docRef: DocumentReference? = nil
        
        docRef = try? db.collection(K.db.groupCollection).addDocument(from: group) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(docRef!.documentID)")
            }
            completion?(docRef)
        }
    }
    
    // TODO GET ALL GROUPS OF USER
    func getAllGroups(of userId: String, completion: (([Group]?) -> Void)? = nil) {
        db.collection(K.db.groupCollection)
            .whereField("ownerID", isEqualTo: AuthManager.shared.userId)
            .getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var groups = [Group]()
                for document in querySnapshot!.documents {
                    if let group = try? document.data(as: Group.self) {
                        groups.append(group)
                    }
                }
                groups.sort { a, b in
                    a.lastUpdated.seconds > b.lastUpdated.seconds
                }
                self.groups = groups
                completion?(self.groups)
            }
            completion?(nil)
        }
    }
    
    // TODO UPDATE GROUP
    // TODO DELETE GROUP
    
    // TODO ADD GROUP EXPENCE
    func addExpence(groupId: String, participantId: String, amount: Double, completion: ((Error?) -> Void)? = nil) {
        
        // update participants locally
        guard var selectedGroup = (groups.first { group in
            group.id == groupId
        }) else {
            print("Could not find selected group!")
            return
        }
        
        guard let index = (selectedGroup.participants.firstIndex { participant in
            participant.uuid == participantId
        }) else {
            print("Could not find user id in the selected group!")
            return
        }
        
        selectedGroup.debt += amount
        selectedGroup.participants[index].debt += amount
        
        selectedGroup.lastUpdated = Timestamp(date: Date())
        
        // update database
        let docRef = db.collection(K.db.groupCollection).document(groupId)
        try? docRef.setData(from: selectedGroup, merge: false) { err in
            if let _ = err {
                print("Error actualizado la base de datos")
                completion?(err)
            }
            print("Se actualizó la base de datos")
            completion?(err)
        }
    }
    
    // TODO SETTLE UP
    // PAY DEBT
    
    // MARK: - Local group methods
    
    var totalDebt: Double {
        var total: Double = 0.0
        for group in groups {
            total += group.debt
        }
        return total
    }
    
    func getGroupsNames() -> [String] {
        var names = [String]()
        for group in groups {
            names.append(group.name)
        }
        return names
    }
    
    func getParticipantsNames(for groupID: String) -> [String] {
        var names = [String]()
        for group in groups {
            if group.id == groupID {
                for participant in group.participants {
                    names.append(participant.name)
                }
            }
        }
        return names
    }
    
    
    func getParticipantId(for groupID: String, name: String) -> String? {
        for group in groups {
            if group.id == groupID {
                for participant in group.participants {
                    if participant.name == name {
                        return participant.uuid
                    }
                }
            }
        }
        return nil
    }
    
    func getgroupIdBy(name: String) -> String? {
        for group in groups {
            if group.name == name {
                return group.id!
            }
        }
        return nil
    }
}
