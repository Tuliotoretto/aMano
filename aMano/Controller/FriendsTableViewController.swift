//
//  FriendsTableViewController.swift
//  aMano
//
//  Created by Julian Garcia  on 01/12/22.
//

import UIKit

class FriendsTableViewController: UITableViewController {
    
    // delete later
    let items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserHeaderView.setupTableViewHeader(with: tableView)
        DatabaseManager.shared.setUserListener()
    }
    
    // MARK: - Table view data source
    
    // header
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UserHeaderView.getHeaderView(tableView: tableView)
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return UserHeaderView.estimatedHeightForHeader
    }
    
    // items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.friendCellIdentifier, for: indexPath) as! FriendCell
        
        cell.friendNameLabel.text = items[indexPath.row]
        
        return cell
    }
    
    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - App bar navigation buttons handlers
    
    @IBAction private func addFriendsButtonPressed(_ sender: UIBarButtonItem) {
        print("search friends")
    }
    
}
