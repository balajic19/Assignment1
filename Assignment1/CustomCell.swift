//
//  CustomCell.swift
//  Assignment1
//
//  Created by Shiva Rama Krishna nutakki on 29/01/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var dogsNameLabel: UILabel!
    @IBOutlet weak var dogsSubBreedsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
