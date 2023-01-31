//
//  PhoneViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 09/01/23.
//

import UIKit
import FirebasePhoneAuthUI

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if NetworkMonitor.shared.isConnected {
            showAuthUI()
        } else {
            NetworkMonitor.shared.showNetworkAlert(self)
        }
    }
    
    private func setup() {
        // custom login button
        loginButton.layer.cornerRadius = 5
        loginButton.layer.backgroundColor = UIColor(named: "Icon")?.cgColor
    }
    
    private func showAuthUI() {
        guard let authUI = FUIAuth.defaultAuthUI() else {return}
        
        authUI.delegate = self
        
        let provider = FUIPhoneAuth(authUI: FUIAuth.defaultAuthUI()!)
        authUI.providers = [provider]
        
        let phoneProvider = authUI.providers.first as! FUIPhoneAuth
        phoneProvider.signIn(withPresenting: self, phoneNumber: "+16505551111")
    }
}

// MARK: - FirebaseUI Auth Delegate
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            return
        }
        
        if let editProfileVC = storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") {
            self.navigationController?.pushViewController(editProfileVC, animated: true)
        }
        //self.navigationController?.performSegue(withIdentifier: K.segues.toEditProfileSegue, sender: self)
        
        //self.performSegue(withIdentifier: K.segues.toEditProfileSegue, sender: self)
    }
}
