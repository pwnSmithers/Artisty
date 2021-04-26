//
//  ListArtistsViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import UIKit

typealias ArtistsCollection = [ArtistsQuery.Data.Search.Artist.Node?]

class ListArtistsViewController: UIViewController {
    
    //MARK:- Properties
    var artists: ArtistsCollection = []
    //MARK:- Outlets
    @IBOutlet weak var listArtistsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Methods
    fileprivate func setupView() {
        self.listArtistsTableView.delegate = self
        self.listArtistsTableView.dataSource = self
        let viewModel = ListArtistsViewModel()
        searchFor(artist: "The 1975", with: viewModel)
    }

}

//MARK:- Fetch artists
extension ListArtistsViewController{
    private func searchFor(artist name: String, with viewModel: ListArtistsViewModel) {
        viewModel.fetchArtists(name)
        viewModel.didSearchForArtist = {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let artistData):
                strongSelf.artists.append(contentsOf: artistData)
                strongSelf.listArtistsTableView.reloadData()
            case .failure(let error):
                print("Fouund an error \(error)")
            }
        }
    }
}

extension ListArtistsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArtist = artists[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(identifier: "ArtistDetail") as? ArtistDetailViewController {
            detailsVC.artist = selectedArtist
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ListArtistsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListArtistTableViewCell.reuseidentifier, for: indexPath) as? ListArtistTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        cell.setupCell(artist: artists[indexPath.row])
        return cell
    }
    
}
