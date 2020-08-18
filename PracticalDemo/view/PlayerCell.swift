//
//  PlayerCell.swift
//  PracticalDemo
//
//  Created by mehul modhvadiya on 17/07/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet var lblGame:UILabel!
    @IBOutlet var lblname:UILabel!
    @IBOutlet var lblAnswer:UILabel!
    @IBOutlet var lblAnswer1:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
