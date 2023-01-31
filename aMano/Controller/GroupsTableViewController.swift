//
//  GroupsTableViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 04/01/23.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    private var userGroups = [Group]()
    private var selectedGroupIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up header
        UserHeaderView.setupTableViewHeader(with: tableView)
        
        // get all groups
        DatabaseManager.shared.getAllGroups(of: AuthManager.shared.userId) { groups in
            if let groups = groups {
                self.userGroups = groups
                self.tableView.reloadData()
            }
        }
        
        // refresh Control
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor(named: "Primary")
        refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc func refreshData(_ sender: Any) {
        DatabaseManager.shared.getAllGroups(of: AuthManager.shared.userId) { groups in
            if let groups = groups {
                self.userGroups = groups
                self.tableView.reloadData()
            }
            self.refreshControl?.endRefreshing()
        }
    }
    // MARK: - Table view data source
    
    // header
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UserHeaderView.getHeaderView(tableView: tableView)
        // show user info
        // name
        headerView.nameLabel.text = AuthManager.shared.userName
        
        // total debt
        var str = "Estoy a mano!"
        if DatabaseManager.shared.totalDebt != 0 {
            str = DatabaseManager.shared.totalDebt > 0 ? "Te deben: " : "Debes: "
            let debtStr = "\(DatabaseManager.shared.totalDebt)"
            str.append(debtStr)
        }
        
        headerView.youOweLabel.text = str
        
        // image
        headerView.profileImage.roundedImage()
        if let profileImageURL = AuthManager.shared.userImageURL {
            StorageManager.shared.downloadImage(url: profileImageURL) { image in
                headerView.profileImage.image = image
            }
        }

        return headerView
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UserHeaderView.estimatedHeightForHeader
    }
    
    // items
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.groupCellIdentifier, for: indexPath) as! GroupCell
        
        // set name
        cell.groupNameLabel.text = userGroups[indexPath.row].name
        
        // set debt
        cell.setDebtLabel(debt: userGroups[indexPath.row].debt)

        // Set date
        let date = userGroups[indexPath.row].lastUpdated.dateValue()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameMonth = dateFormatter.string(from: date)
        
        cell.dateLabel.text = "\(components.day!) \(nameMonth)"
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedGroupIndex = indexPath.row
        self.performSegue(withIdentifier: K.segues.toGroupDetailsSegue, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GroupDetailsViewController {
            destination.selectedGroup = userGroups[selectedGroupIndex]
        }
    }
}
