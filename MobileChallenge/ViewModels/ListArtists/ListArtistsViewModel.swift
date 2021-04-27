//
//  ListArtistsViewModel.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import Foundation

class ListArtistsViewModel {
    
    enum SearchArtistsError: Error {
        case artistNotFound
        case networkError
        case unknownError
    }
    
    enum SearchArtistResult {
        case success([ArtistsQuery.Data.Search.Artist.Node?])
        case failure(SearchArtistsError)
    }
    
    typealias SearchArtistsCompletion = (SearchArtistResult) -> Void
    var didSearchForArtist: SearchArtistsCompletion?
    var isPaginatting = false

    func fetchArtists(_ name: String) {
        NetworkService.shared.apollo.fetch(query: ArtistsQuery(search: name, first: 15)) { result in
            switch result {
            case .success(let graphQLResult):
                if let data = graphQLResult.data?.search?.artists?.nodes{
                   let artistResult: SearchArtistResult = .success(data)
                   self.didSearchForArtist?(artistResult)
                }
            case .failure(let error):
                let result: SearchArtistResult = .failure(.networkError)
                self.didSearchForArtist?(result)
            }
        }
    }
    
    func fetchMoreArtists(lastName: String, searchName: String) {
        isPaginatting = true
        NetworkService.shared.apollo.fetch(query: ArtistsQuery(search: searchName, first: 15, after: lastName)) { result in
            switch result {
            case .success(let graphQlResult):
                if let data = graphQlResult.data?.search?.artists?.nodes{
                   let artistResult: SearchArtistResult = .success(data)
                   self.didSearchForArtist?(artistResult)
                   self.isPaginatting = false
                }
            case .failure(let error):
                let result: SearchArtistResult = .failure(.networkError)
                self.didSearchForArtist?(result)
                self.isPaginatting = false
            }
        }
        
    }
}
