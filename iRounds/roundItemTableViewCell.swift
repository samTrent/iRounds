//
//  roundItemTableViewCell.swift
//  iRounds
//
//  Created by Sam Trent on 11/15/18.
//  Copyright © 2018 Sam Trent. All rights reserved.
//

import UIKit

class roundItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numberOfParticepents: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
