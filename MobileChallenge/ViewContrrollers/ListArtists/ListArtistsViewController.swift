//
//  ListArtistsViewController.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import UIKit

class ListArtistsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var listArtistsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ListArtistsViewController: UITableViewDelegate{
    
}

extension ListArtistsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListArtistTableViewCell.reuseidentifier, for: indexPath) as? ListArtistTableViewCell else {
            fatalError("Unable to dequeue week day table view cell")
        }
        
        return cell
    }
    
}
