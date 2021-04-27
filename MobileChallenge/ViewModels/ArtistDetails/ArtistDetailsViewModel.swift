//
//  ArtistDetailsViewModel.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//

import UIKit

class ArtistDetailsViewModel {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = appDelegate.persistentContainer.viewContext
    var musicians = [Musician]()
    
}


//MARK:- CoreData methods for bookmarking.
extension ArtistDetailsViewModel{
    
    func check(artist: Artist) -> Bool{
        var artistBookmarked : Bool = false
        do {
            musicians = try context.fetch(Musician.fetchRequest())
            
            musicians.forEach { (musician) in
                if musician.id == artist?.id{
                    artistBookmarked = true
                }
            }
        }catch  let error as NSError {
            print("Couln't fetch \(error), \(error.userInfo)")
        }
        return artistBookmarked
    }

    
     func save(artist: Artist){
        let musician = Musician(entity: Musician.entity(), insertInto: context)
        musician.id = artist?.id
        musician.name = artist?.name
        musician.disambiguation = artist?.disambiguation
        appDelegate.saveContext()
    }
    
     func delete(artist: Artist){
        let musician = getMusicianFrom(artist: artist)
        context.delete(musician)
        appDelegate.saveContext()
    }
    
    fileprivate func getMusicianFrom(artist: Artist) -> Musician {
        let musician = Musician(entity: Musician.entity(), insertInto: context)
        musician.id = artist?.id
        musician.name = artist?.name
        musician.disambiguation = artist?.disambiguation
        return musician
    }
}
