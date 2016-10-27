//
//  ResultsTableViewCell.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {

    @IBOutlet var idLabel: UILabel!
    @IBOutlet var tccLabel: UILabel!
    @IBOutlet var teLabel: UILabel!
    @IBOutlet var tvcLabel: UILabel!
    @IBOutlet var tbLabel: UILabel!
    @IBOutlet var ttLabel: UILabel!
    @IBOutlet var tiLabel: UILabel!
    @IBOutlet var tfLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
