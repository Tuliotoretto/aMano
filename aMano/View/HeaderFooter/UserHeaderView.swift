//
//  UserHeaderView.swift
//  aMano
//
//  Created by Julian Garcia  on 05/01/23.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var youOweLabel: UILabel!
    
    // use in estimatedHeightForHeaderInSection TableView method
    static let estimatedHeightForHeader: CGFloat = 120
    
    // Call to set up this tableview to be the header
    static func setupTableViewHeader(with tableView: UITableView) {
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 120
        tableView.register(UINib(nibName: K.cellIdentifiers.headerUserView, bundle: nil), forHeaderFooterViewReuseIdentifier: K.cellIdentifiers.headerUserView)
    }
    
    // Use in viewForHeaderInSection. to get the header view
    static func getHeaderView(tableView: UITableView) -> UserHeaderView {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.cellIdentifiers.headerUserView) as! UserHeaderView
        
        headerView.view.backgroundColor = UIColor(named: "Main")
        headerView.view.layer.cornerRadius = 10
        headerView.view.layer.masksToBounds = false
        headerView.view.layer.shadowColor = UIColor.black.cgColor
        headerView.view.layer.shadowOpacity = 0.1
        headerView.view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        headerView.view.layer.shadowRadius = 1
        headerView.view.layer.shouldRasterize = true
        
        
        return headerView
    }
    
    
}
