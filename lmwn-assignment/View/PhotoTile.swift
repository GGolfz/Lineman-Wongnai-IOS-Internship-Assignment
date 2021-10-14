//
//  PhotoTile.swift
//  lmwn-assignment
//
//  Created by ggolfz on 14/10/2564 BE.
//

import UIKit

class PhotoTile: UITableViewCell {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var likeAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
