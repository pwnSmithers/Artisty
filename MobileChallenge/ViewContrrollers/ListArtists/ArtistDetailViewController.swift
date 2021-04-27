//
//  ArtistDetailViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

enum MusicianStatus {
    case Bookmarked
    case NotBookmarked
}

enum ArtistContentSource {
    case saved
    case graphQl
}

class ArtistDetailViewController: UIViewController {

    //MARK:- Properties
    var artist: Artist?
    var bookmarkedMusician: Musician?
    var viewModel = ArtistDetailsViewModel()
    var musicianStatus: MusicianStatus = .NotBookmarked
    var sourceOfData: ArtistContentSource = .graphQl

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistStatusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView(){
        switch sourceOfData {
        case .graphQl:
            if let artist = artist {
                print("artist ID \(artist?.name)")
                artistName.text = artist?.name
                let isArtistBookmarked = viewModel.check(artist: artist)
                if isArtistBookmarked{
                    artistStatusButton.setTitle("Delete Bookmark", for: .normal)
                    artistStatusButton.setImage(UIImage(systemName: "trash"), for: .normal)
                    artistStatusButton.tintColor = UIColor.red
                    artistStatusButton.backgroundColor = UIColor.lightGray
                    artistStatusButton.layer.cornerRadius = 5
                    musicianStatus = .Bookmarked
                    artistStatusButton.addTarget(self, action: #selector(removeArtist), for: .touchUpInside)
                } else {
                    artistStatusButton.setTitle("Bookmark Artist", for: .normal)
                    artistStatusButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                    artistStatusButton.tintColor = UIColor.green
                    artistStatusButton.backgroundColor = UIColor.lightGray
                    artistStatusButton.layer.cornerRadius = 5
                    musicianStatus = .NotBookmarked
                    artistStatusButton.addTarget(self, action: #selector(bookMarkArtist), for: .touchUpInside)
                }
            }
        case .saved:
            
            if let musician = bookmarkedMusician {
                artistName.text = musician.name
                
            }
        }
      
    }
  
}

extension ArtistDetailViewController{
    @objc private func bookMarkArtist(){
        if let artist = artist{
            bookmark(artist: artist)
        }
    }
    
    @objc private func removeArtist(){
        if let artist = artist{
            delete(artist: artist)
        }
    }
    
    fileprivate func bookmark(artist: Artist){
        viewModel.save(artist: artist)
    }
    
    fileprivate func delete(artist: Artist){
        viewModel.delete(artist: artist)
    }
}
