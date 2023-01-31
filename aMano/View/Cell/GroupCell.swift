//
//  GroupCell.swift
//  aMano
//
//  Created by Julian Garcia  on 04/01/23.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupDebtLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    private let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = [UIColor(named: "GradientStart")!.cgColor, UIColor(named: "GradientEnd")!.cgColor]
        //gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Shadow
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowRadius = 1
        view.layer.shouldRasterize = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDebtLabel(debt: Double) {
        // text
        groupDebtLabel.text = debt != 0.0 ?
        debt > 0 ? "+\(debt)" : "\(debt)"
        : ""
        
        // color
        groupDebtLabel.textColor = debt > 0 ?
            UIColor(named: "Success")! :
            UIColor(named: "Accent Error")!
        
    }
}
