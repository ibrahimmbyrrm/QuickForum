//
//  OwnFeedTableViewCell.swift
//  QuickForum
//
//  Created by İbrahim Bayram on 30.11.2022.
//

import UIKit

class OwnFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var ownContent: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
