//
//  ListArtistsViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import UIKit

typealias ArtistsCollection = [ArtistsQuery.Data.Search.Artist.Node ]

class ListArtistsViewController: UIViewController {
    
    //MARK:- Properties
    var artists: ArtistsCollection = []
    let viewModel = ListArtistsViewModel()
    var searchTerm = ""
    
    //MARK:- Outlets
    @IBOutlet weak var listArtistsTableView: UITableView!
    @IBOutlet weak var noContentLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- View Lifecycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- Methods
    fileprivate func setupView() {
        self.listArtistsTableView.delegate = self
        self.listArtistsTableView.dataSource = self
        self.searchBar.delegate = self
        activityIndicator.isHidden = true
        if artists.isEmpty{
            listArtistsTableView.isHidden = true
        }
    }

    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
}

//MARK:- Fetch artists
extension ListArtistsViewController{
    private func searchFor(artist name: String, with viewModel: ListArtistsViewModel) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.fetchArtists(name)
        viewModel.didSearchForArtist = {[weak self] (result) in
            
            guard let strongSelf = self else {
                return
            }
            strongSelf.activityIndicator.isHidden = true
            strongSelf.activityIndicator.stopAnimating()
            switch result {
            case .success(let artistData):
                artistData.forEach { (artist) in
                    if let artistR = artist{
                        strongSelf.artists.append(artistR)
                    }
                }
                strongSelf.listArtistsTableView.isHidden = false
                strongSelf.noContentLabel.isHidden = true
                strongSelf.listArtistsTableView.reloadData()
            case .failure(let error):
                print("Fouund an error \(error)")
            }
        }
    }
}

extension ListArtistsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let selectedArtist = artists[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(identifier: "ArtistDetail") as? ArtistDetailViewController {
            detailsVC.arstistsId = selectedArtist.id
            detailsVC.artistsName = selectedArtist.name
            detailsVC.artistDisambiguation = selectedArtist.disambiguation
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension ListArtistsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if artists.isEmpty{
            return 0
        } else {
            return 1
        }
    }
    
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

//MARK: SearchBar Config
extension ListArtistsViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //remove any previously searched data.
        if !self.artists.isEmpty{
            self.artists.removeAll()
            self.listArtistsTableView.reloadData()
        }

        if searchBar.text != ""{
            if let searchText = searchBar.text{
                searchTerm = searchText
                searchBar.resignFirstResponder()
                searchFor(artist: searchText, with: viewModel)
            }
        } else {
            let alert = UIAlertController.notifyUser(title: "Error", message: "Please enter an artist's name") {}
            self.present(alert, animated: true, completion: nil)
        }
       
    }

}


extension ListArtistsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (listArtistsTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            //make sure it isn't already paginating.
            if viewModel.isPaginatting == false {
                self.listArtistsTableView.tableFooterView = createSpinnerFooter()
                loadMore()
            }
        }
    }
    
    fileprivate func loadMore(){
        let lastArtist = self.artists.last
        viewModel.fetchMoreArtists(lastName: searchTerm, searchName: lastArtist?.name ?? "")
        viewModel.didSearchForArtist = {[weak self] (result) in
            DispatchQueue.main.async {
                self?.listArtistsTableView.tableFooterView = nil
            }
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let artistData):
                artistData.forEach { (artist) in
                    if let artistR = artist{
                        strongSelf.artists.append(artistR)
                    }
                }
                strongSelf.listArtistsTableView.reloadData()
            case .failure(let error):
                print("Fouund an error \(error)")
            }
        }
    }
}
