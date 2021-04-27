//
//  BookmarkedViewModel.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import Foundation
import CoreData
import UIKit

class BookmarkedViewModel {
    enum BookmarkedResult {
        case success([Musician])
        case failure(NSError)
    }
    
    //MARK:- Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    private var musicians = [Musician]()
}

extension BookmarkedViewModel{
    func loadMusicians(completion: @escaping (BookmarkedResult) -> Void){
        do {
            musicians = try context.fetch(Musician.fetchRequest())
            let result = BookmarkedResult.success(musicians)
            completion(result)
        }catch  let error as NSError {
            let error = BookmarkedResult.failure(error)
            completion(error)
        }
    }
}
