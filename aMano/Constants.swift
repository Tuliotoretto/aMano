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
        static let toGroupDetailsSegue = "toGroupDetails"
    }
    
    // MARK: - cellIds
    struct cellIdentifiers {
        static let headerUserView = "UserHeaderView"
        static let groupCellIdentifier = "GroupCell"
        static let textFieldCell = "TextFieldCell"
        static let participantsCell = "ParticipantsCell"
        static let activityCellIdentifier = "ActivityCell"
        static let ParticipantDetailsCell = "ParticipantDetailsCell"
    }
    
    // MARK: - Database
    struct db {
        static let groupCollection = "groups"
    }
    
    // MARK: - Colors
    struct color {
        
    }
}
