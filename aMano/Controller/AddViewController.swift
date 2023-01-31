//
//  AddViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 24/01/23.
//

import UIKit
import Eureka

class AddViewController: FormViewController {
    
    var selectedGroupId: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Colors
        setCustomColors()
        
        // show form
        presentForm()
    }
    
    private func presentForm() {
        form +++
        
        Section()
        
        // Group
        <<< PushRow<String>() {
            $0.tag = "Group"
            $0.title = "Grupo"
            $0.options = DatabaseManager.shared.getGroupsNames()
            $0.selectorTitle = "Selecciona un Grupo"
        }
        .onChange({[weak self] row in
            if let name = row.value {
                self!.selectedGroupId = DatabaseManager.shared.getgroupIdBy(name: name)
                //print(DatabaseManager.shared.getgroupIdBy(name: name))
                self!.reloadData()
            } else {
                self!.selectedGroupId = nil
            }
        })
        .onPresent { from, to in
            to.dismissOnSelection = false
            to.dismissOnChange = false
            to.selectableRowCellSetup = { cell, row in
                cell.tintColor = UIColor(named: "Icon")
            }
        }
        
        +++ Section()
        
        // Segmented Row
        <<< SegmentedRow<String>() {
            let options = ["Pagué", "Me pagó"]
            $0.tag = "WhoPaid"
            $0.options = options
            $0.value = options.first
        }
        
        +++ Section()
        
        // Participant Row
        <<< PushRow<String>() {
            $0.tag = "Participant"
            $0.title = "Participante"
            $0.options = nil
            $0.value = nil
        }
        .onPresent { from, to in
            to.dismissOnSelection = false
            to.dismissOnChange = false
            to.selectableRowCellSetup = { cell, row in
                cell.tintColor = UIColor(named: "Icon")
            }
        }
        
        +++ Section()
        
        // Amount Row
        <<< DecimalRow() {
            $0.tag = "Amount"
            $0.title = "Monto"
            $0.value = 0.0
            $0.formatter = DecimalFormatter()
            $0.useFormatterDuringInput = true
        }.cellSetup { cell, _  in
            cell.textField.keyboardType = .numberPad
        }
        
        +++ Section()
        
        <<< ButtonRow() {
            $0.title = "Add expense"
        }
        .onCellSelection { [weak self] (cell, row) in
            //print(self!.form.values())
            
            // TODO VALIDATE DATA
            guard let selectedGroupId = self!.selectedGroupId else {return}
            guard let group = self!.form.values()["Group"] as? String else {return}
            guard let paidByUser = self!.form.values()["WhoPaid"] as? String else {return}
            guard let participant = self!.form.values()["Participant"] as? String else {return}
            guard let participantID = DatabaseManager.shared.getParticipantId(for: selectedGroupId, name: participant) else {return}
            guard let amount = self!.form.values()["Amount"] as? Double else {return}
            
            print(selectedGroupId)
            print(group)
            print(participant)
            print(participantID)
            print(amount)
            
            DatabaseManager.shared.addExpence(
                groupId: selectedGroupId,
                participantId: participantID,
                amount: paidByUser == "Pagué" ? amount : amount * -1
            ) {[weak self] err in
                row.disabled = Condition(booleanLiteral: false)
                if let _ = err {
                    // TODO SHOW ERROR
                }
                self!.showAlert()
                self!.cleanData()
            }
        }
    }
    
    private func reloadData() {
        // reload by row
        let byRow = form.rowBy(tag: "Participant") as! PushRow<String>
        if let selectedGroupId = self.selectedGroupId {
            let participantsNames = DatabaseManager.shared.getParticipantsNames(for: selectedGroupId)
            byRow.options = DatabaseManager.shared.getParticipantsNames(for: selectedGroupId)
            byRow.value = participantsNames.first
        } else {
            byRow.options = nil
            byRow.value = nil
        }

        // reload amount
        let amountRow = form.rowBy(tag: "Amount") as! DecimalRow
        amountRow.value = 0.0
    }
    
    private func cleanData() {
        let groupRow = form.rowBy(tag: "Group") as! PushRow<String>
        let byRow = form.rowBy(tag: "Participant") as! PushRow<String>
        let amountRow = form.rowBy(tag: "Amount") as! DecimalRow
        
        groupRow.value = nil
        byRow.value = nil
        amountRow.value = nil
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Gasto Agregado", message: "Gasto agregado exitosamente", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Continuar", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setCustomColors() {
        self.tableView.backgroundColor = UIColor(named: "Background")
        
        navigationController?.navigationBar.tintColor = UIColor(named: "Icon")
        
        ButtonRow.defaultCellSetup = {cell, row in
            cell.textLabel?.textColor = UIColor(named: "Primary")
        }
        
        SegmentedRow<String>.defaultCellSetup = {cell, row in
            cell.segmentedControl.selectedSegmentTintColor = UIColor(named: "Primary")
        }
        
        ButtonRow.defaultCellSetup = {cell, row in
            cell.tintColor = UIColor(named: "Primary")
        }
    }
}
