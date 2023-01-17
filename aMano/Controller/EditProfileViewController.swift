//
//  EditProfileViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 16/01/23.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = DatabaseManager.shared.user {
            nameTextField.text = user.data.name
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        guard !nameTextField.text!.isEmpty else {return}
        
        if var user = DatabaseManager.shared.user {
            user.data.name = nameTextField.text!
            DatabaseManager.shared.updateUser(user: user) { [weak self] res in
                if (res) {
                    DatabaseManager.shared.user = user
                    self!.performSegue(withIdentifier: K.segues.toMenuSegue, sender: self)
                }
            }
        } else {
            let newUserData = UserData(name: nameTextField.text!, phoneNumber: AuthManager.shared.userPhoneNumber)
            let newUser = UserModel(id: AuthManager.shared.userId, data: newUserData)
            DatabaseManager.shared.createUser(user: newUser) { [weak self] res in
                if (res) {
                    DatabaseManager.shared.user = newUser
                    self!.performSegue(withIdentifier: K.segues.toMenuSegue, sender: self)
                }
            }
        }
    }
}
