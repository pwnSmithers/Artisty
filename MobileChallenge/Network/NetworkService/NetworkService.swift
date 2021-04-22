//
//  NetworkService.swift
//  MobileChallenge
//
//  Created by Smithers on 22/04/2021.
//

import Foundation
import Apollo

class NetworkService {
    static let shared = NetworkService()
    lazy var apollo = ApolloClient(url: URL(string: "https://graphbrainz.herokuapp.com/")!)
}
