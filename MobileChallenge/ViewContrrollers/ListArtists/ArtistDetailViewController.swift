//
//  ArtistDetailViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit
import Kingfisher

enum MusicianStatus {
    case Bookmarked
    case NotBookmarked
}

class ArtistDetailViewController: UIViewController {

    //MARK:- Properties
    var artist: Artist?
    var artistsName: String?
    var arstistsId: String?
    var imageUrl: String?
    var artistDisambiguation: String?
    var bookmarkedMusician: Musician?
    var viewModel = ArtistDetailsViewModel()
    var musicianStatus: MusicianStatus = .NotBookmarked

    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistStatusButton: UIButton!
    @IBOutlet weak var artistImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func setupView(){
        if let artistId = arstistsId{
            artistName.text = artistsName
            let processor = DownsamplingImageProcessor(size: artistImage.bounds.size)
                         |> RoundCornerImageProcessor(cornerRadius: 20)
            if let imageUrl = imageUrl {
                let url = URL(string: imageUrl)
                artistImage.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholder"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
            }
           
            let isArtistBookmarked = viewModel.check(artistId: artistId)
            if isArtistBookmarked{
                artistStatusButton.setTitle("Delete Bookmark", for: .normal)
                artistStatusButton.setImage(UIImage(systemName: "trash"), for: .normal)
                artistStatusButton.tintColor = UIColor.red
                artistStatusButton.backgroundColor = UIColor.lightGray
                artistStatusButton.layer.cornerRadius = 5
                musicianStatus = .Bookmarked
                artistStatusButton.addTarget(self, action: #selector(removeArtist), for: .touchUpInside)
            }else {
                artistStatusButton.setTitle("Bookmark Artist", for: .normal)
                artistStatusButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                artistStatusButton.tintColor = UIColor.green
                artistStatusButton.backgroundColor = UIColor.lightGray
                artistStatusButton.layer.cornerRadius = 5
                musicianStatus = .NotBookmarked
                artistStatusButton.addTarget(self, action: #selector(bookMarkArtist), for: .touchUpInside)
            }
        }
    }
  
}

extension ArtistDetailViewController{
    @objc private func bookMarkArtist(){
            bookmark()
    }
    
    @objc private func removeArtist(){
            delete()
    }
    
    fileprivate func bookmark(){
        if let artistId = arstistsId, let artistName = artistsName {
            viewModel.save(artistId: artistId, artistName: artistName, disambiguation: artistDisambiguation ?? "") { [weak self] (finished) in
                guard let strongSelf = self else {
                    return
                }
                if finished{
                    let alert = UIAlertController.notifyUser(title: "Success", message: "You've successfully bookmarked the arttist") {
                        strongSelf.setupView()
                    }
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    fileprivate func delete(){
        if let artistId = arstistsId, let artistName = artistsName{
            viewModel.delete(artistId: artistId, artistName: artistName, disambiguation: artistDisambiguation ?? "") { [weak self] (deleted) in
                guard let strongSelf = self else {
                    return
                }
                if deleted{
                    let alert = UIAlertController.notifyUser(title: "Success", message: "You've successfully unbookmarked the artist.") {
                        strongSelf.setupView()
                    }
                    strongSelf.present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController.notifyUser(title: "Success", message: "You've successfully unbookmarked the artist.") {
                        strongSelf.setupView()
                    }
                    strongSelf.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
