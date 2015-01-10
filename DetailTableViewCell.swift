//
//  DetailTableViewCell.swift
//  tweet_fellows
//
//  Created by nacnud on 1/9/15.
//  Copyright (c) 2015 nacnud. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

   @IBOutlet weak var tweetText: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
