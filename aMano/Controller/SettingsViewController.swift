//
//  SettingsViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 05/01/23.
//

import UIKit

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellTag = tableView.cellForRow(at: indexPath)?.tag else {return}
        
        switch (cellTag) {
        case 0:
            logoutCellPressed()
        default:
            print("Error")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func logoutCellPressed() {
        // TODO FIX THIS
        AuthManager.shared.logout() { [weak self] in
            let loginVc = self?.storyboard?.instantiateViewController(withIdentifier: K.storyboardID.loginViewController)
            loginVc?.modalPresentationStyle = .fullScreen
            
            self!.tabBarController!.dismiss(animated: true)
            self!.present(loginVc!, animated: true)
        }
    }
}
