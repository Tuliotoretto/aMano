//
//  GroupDetailsViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 31/01/23.
//

import UIKit

class GroupDetailsViewController: UIViewController {

    var selectedGroup: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = selectedGroup?.name
    }
}

// MARK: - Table view methods
extension GroupDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Participantes"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGroup?.participants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.ParticipantDetailsCell, for: indexPath) as! ParticipantCell
        
        // name
        cell.participantNameLabel.text = selectedGroup?.participants[indexPath.row].name ?? "No name"
        
        // debt
        let debt = selectedGroup?.participants[indexPath.row].debt ?? 0.0
        let color: UIColor = debt == 0.0 ? .label :
        debt > 0.0 ? UIColor(named: "Primary")! : UIColor(named: "Accent Error")!
        
        cell.debtLabel.text = String(debt)
        cell.debtLabel.textColor = color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
