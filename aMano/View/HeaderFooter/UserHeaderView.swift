//
//  UserHeaderView.swift
//  aMano
//
//  Created by Julian Garcia  on 05/01/23.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var youOweLabel: UILabel!
    @IBOutlet weak var theyOweYouLabel: UILabel!
    
    // use in estimatedHeightForHeaderInSection TableView method
    static let estimatedHeightForHeader: CGFloat = 100
    
    // Call to set up this tableview to be the header
    static func setupTableViewHeader(with tableView: UITableView) {
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100
        tableView.register(UINib(nibName: K.cellIdentifiers.headerUserView, bundle: nil), forHeaderFooterViewReuseIdentifier: K.cellIdentifiers.headerUserView)
    }
    
    // Use in viewForHeaderInSection. to get the header view
    static func getHeaderView(tableView: UITableView) -> UIView {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.cellIdentifiers.headerUserView) as! UserHeaderView
        
        headerView.nameLabel.text = DatabaseManager.shared.user?.data.name ?? "No name"
        
        headerView.view.layer.cornerRadius = 10
        return headerView
    }

}
