//
//  ArtistDetailViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

class ArtistDetailViewController: UIViewController {

    var artist: Artist?
    
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistStatusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView(){
        if let artist = artist {
            artistName.text = artist?.name
        }
    }
}
