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
    
    func check(artistId: String) -> Bool{
        var artistBookmarked : Bool = false
        do {
            musicians = try context.fetch(Musician.fetchRequest())
            
            musicians.forEach { (musician) in
                if musician.id == artistId{
                    artistBookmarked = true
                }
            }
        }catch  let error as NSError {
            print("Couln't fetch \(error), \(error.userInfo)")
        }
        return artistBookmarked
    }
    
    func save(artistId: String,artistName: String,disambiguation: String, completion: @escaping (Bool) -> Void){
        let musician = Musician(entity: Musician.entity(), insertInto: context)
        musician.id = artistId
        musician.name = artistName
        musician.disambiguation = disambiguation
        appDelegate.saveContext()
        completion(true)
    }
    
    func delete(artistId: String,artistName: String,disambiguation: String , completion: @escaping (Bool) -> Void){
        let musician = getMusicianFrom(artistId: artistId, artistName: artistName, disambiguation: disambiguation)
        do {
            musicians = try context.fetch(Musician.fetchRequest())
            musicians.forEach { (savedMusician) in
                if savedMusician.id == musician.id{
                    context.delete(savedMusician)
                    appDelegate.saveContext()
                    completion(true)
                }
            }
        } catch let error as NSError {
            print("Couln't fetch \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    fileprivate func getMusicianFrom(artistId: String,artistName: String,disambiguation: String) -> Musician {
        let musician = Musician(entity: Musician.entity(), insertInto: context)
        musician.id = artistId
        musician.name = artistName
        musician.disambiguation = disambiguation
        return musician
    }
}
