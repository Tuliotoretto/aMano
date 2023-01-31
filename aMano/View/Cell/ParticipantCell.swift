//
//  ParticipantCell.swift
//  aMano
//
//  Created by Julian Garcia  on 31/01/23.
//

import UIKit

class ParticipantCell: UITableViewCell {

    @IBOutlet weak var participantNameLabel: UILabel!
    @IBOutlet weak var debtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
