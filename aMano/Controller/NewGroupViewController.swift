//
//  NewGroupViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 18/01/23.
//

import UIKit
import FirebaseFirestore

class NewGroupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let headers = ["Nombre Del Grupo", "Participantes"]
    
    private var groupName = String()
    private var participants = [String]()
    
    var group: Group? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        participants.insert(AuthManager.shared.userName!, at: 0)
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        
//        var allParticipants = [Participant]()
//        for participant in self.participants {
//            allParticipants.append(
//                Participant(uuid: UUID().uuidString, name: participant, debt: 0.0)
//            )
//        }
//
//        //let p = self.participants.map{ Participant(uuid: UUID().uuidString, name: $0, debt: 0.0)}
        
        // TODO VALIDATE DATA
        
        let group = Group(
            id: nil,
            ownerID: AuthManager.shared.userId,
            name: groupName,
            debt: 0.0,
//            participants: allParticipants,
            participants: self.participants.map{ Participant(uuid: UUID().uuidString, name: $0, debt: 0.0) },
            lastUpdated: Timestamp(date: Date()))
        
        DatabaseManager.shared.createGroup(group) { ref in
            sender.isEnabled = true
            
            if let _ = ref {
                print("Document added")
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    // hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

// MARK: - Table View Methods
extension NewGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    // data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 200.0
        }
        
        return 18.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : participants.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Group name cell
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: K.cellIdentifiers.textFieldCell,
                for: indexPath) as! TextFieldCell
            
            cell.textField.placeholder = "Group Name"
            cell.textField.text = "New Group"
            cell.textField.tag = 0
            
            groupName = cell.textField.text!
            
            return cell
            
        // User cell
        } else if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: K.cellIdentifiers.textFieldCell,
                for: indexPath) as! TextFieldCell
            
            cell.textField.text = AuthManager.shared.userName
            cell.textField.tag = 0
            
            cell.isUserInteractionEnabled = false
            cell.textField.isUserInteractionEnabled = false
        
            return cell
            
        // Participants cells
        } else if indexPath.row < participants.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: K.cellIdentifiers.textFieldCell,
                for: indexPath) as! TextFieldCell
            
            cell.textField.tag = indexPath.row
            cell.textField.text = participants[indexPath.row]
            cell.textField.placeholder = "participant's nickname"
            
            //cell.textField.addTarget(self, action: #selector(updateCell(_:)), for: .editingDidEnd)
            
            return cell
            
        // Add participant cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: K.cellIdentifiers.participantsCell,
                for: indexPath) as! LabelCell
            
            cell.nameLabel.text = "+ Add participant"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row == 0 || indexPath.row == participants.count) ? false : true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // delete row
        if editingStyle == .delete {
            
            // remove from data
            participants.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            updateCellTags(from: indexPath.row)
        }
    }
    
    // delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // add cell
        if indexPath.section != 0 && indexPath.row == self.participants.count {
            
            let newCellIndexPath = IndexPath(row: self.participants.count, section: 1)
            
            self.participants.append("")
            
            self.tableView.insertRows(at: [newCellIndexPath], with: .automatic)
            
            (tableView.cellForRow(at: newCellIndexPath) as! TextFieldCell)
                .textField.becomeFirstResponder()
        }
    }
    
    private func updateCellTags(from index: Int) {
        let cells = tableView.visibleCells
        
        for cell in cells {
            if let inputCell = cell as? TextFieldCell {
                if inputCell.textField.tag > 0 && inputCell.textField.tag > index {
                    inputCell.textField.tag -= 1
                }
            }
        }
    }
}

// MARK: - text field methods
extension NewGroupViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {return}
        
        if text.isEmpty {
            textField.text = textField.tag == 0 ? "New Group" : "New Friend"
        }
        
        if textField.tag == 0 {
            print("New Group: ", textField.text!)
            groupName = textField.text!
        } else {
            participants[textField.tag] = textField.text!
        }
        
        print(participants)
    }
}
