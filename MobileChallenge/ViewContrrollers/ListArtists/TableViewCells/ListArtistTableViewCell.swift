//
//  ListArtistTableViewCell.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import UIKit

typealias Artist = ArtistsQuery.Data.Search.Artist.Node?

class ListArtistTableViewCell: UITableViewCell {
    
    //MARK:- Properties
    static var reuseidentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Outlets
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistImageView: UIImageView!
    
    
    func setupCell(artist: Artist){
        artistNameLabel.text = artist?.name
    }
}
