//
//  ListArtistTableViewCell.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import UIKit

class ListArtistTableViewCell: UITableViewCell {
    
    //MARK:- Properties
    static var reuseidentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Outlets
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
