//
//  Group.swift
//  aMano
//
//  Created by Julian Garcia  on 20/01/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Group: Codable {
    @DocumentID var id: String?
    
    let ownerID: String
    
    var name: String
    
    var debt: Float64
    
    var participants: [Participant]
    
    //var record: [Expense]?
    
    var lastUpdated: Timestamp
}

struct Participant: Codable {
    let uuid: String
    var name: String
    var debt: Float64
}

//struct Expense: Codable {
//    var from: [String]
//    var to: [String]
//    var amount: Float64
//    
//    var lastUpdated: Timestamp
//}
