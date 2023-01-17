//
//  Constants.swift
//  aMano
//
//  Created by Julian Garcia  on 01/12/22.
//

import Foundation


struct K {
    
    // MARK: - storyboard
    struct storyboardID {
        static let name = "Main"
        static let loginViewController = "LoginViewController"
        static let MenuViewController = "MenuViewController"
    }
    
    // MARK: - segues
    struct segues {
        static let toEditProfileSegue = "toEditProfileInfo"
        static let toMenuSegue = "toMenu"
        static let toCreateUserSegue = "toCreateUser"
    }
    
    // MARK: - cellIds
    struct cellIdentifiers {
        static let headerUserView = "UserHeaderView"
        static let friendCellIdentifier = "FriendCell"
        static let groupCellIdentifier = "GroupCell"
        static let activityCellIdentifier = "ActivityCell"
    }
    
    // MARK: - Database
    struct db {
        static let userCollection = "Users"
    }
}
