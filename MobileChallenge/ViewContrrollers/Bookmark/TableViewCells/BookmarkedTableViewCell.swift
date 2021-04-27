//
//  BookmarkedTableViewCell.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

class BookmarkedTableViewCell: UITableViewCell {
    //MARK:- Properties
    static var reuseidentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Outlets
    @IBOutlet weak var musicianName: UILabel!
   

    //MARK:- Methods
    func setup(with artist: Musician){
        musicianName.text = artist.name
    }

}
