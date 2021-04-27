//
//  BookmarkedViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

class BookmarkedViewController: UIViewController {
    //MARK:- Properties.
    var viewModel = BookmarkedViewModel()
    var bookmarkedMusicians = [Musician]() {
        didSet{
            print("bookmarked musicians set")
            bookmarkedItemsTableView.reloadData()
        }
    }
    
    //MARK:- Outlets.
    @IBOutlet weak var noContentLabel: UILabel!
    
    @IBOutlet weak var bookmarkedItemsTableView: UITableView!
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK:- METHODS
    fileprivate func setupView() {
        bookmarkedItemsTableView.delegate = self
        bookmarkedItemsTableView.dataSource = self
        
        bookmarkedItemsTableView.isHidden = true
        viewModel.loadMusicians {[weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let musicians):
                if musicians.isEmpty{
                    strongSelf.bookmarkedItemsTableView.isHidden = true
                    strongSelf.noContentLabel.isHidden = false
                } else {
                    strongSelf.bookmarkedItemsTableView.isHidden = false
                    strongSelf.noContentLabel.isHidden = true
                    strongSelf.bookmarkedMusicians = musicians
                    strongSelf.bookmarkedItemsTableView.reloadData()
                }

                print("Musicians \(musicians.count)")
            case .failure(let error):
                print("Error is \(error)")
            }
        }
    }
}

extension BookmarkedViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMusician = bookmarkedMusicians[indexPath.row]
        if let detailsVC = storyboard?.instantiateViewController(identifier: "ArtistDetail") as? ArtistDetailViewController {
            
            var artist: Artist?
            
            artist??.name = selectedMusician.name
            artist??.id = selectedMusician.id ?? ""
            artist??.disambiguation = selectedMusician.disambiguation
            detailsVC.artist = artist
          
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension BookmarkedViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if bookmarkedMusicians.isEmpty{
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedMusicians.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookmarkedTableViewCell.reuseidentifier, for: indexPath) as? BookmarkedTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        let musician = bookmarkedMusicians[indexPath.row]
        cell.setup(with: musician)
 
        return cell
    } 
}
