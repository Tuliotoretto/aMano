//
//  User.swift
//  aMano
//
//  Created by Julian Garcia  on 13/01/23.
//

import Foundation
import FirebaseFirestoreSwift

public struct UserModel: Codable {
    var id: String
    var data: UserData
}

public struct UserData: Codable {
    var name: String
    let phoneNumber: String
}
