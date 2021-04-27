//
//  Musician+CoreDataProperties.swift
//  MobileChallenge
//
//  Created by Smithers on 26/04/2021.
//
//

import Foundation
import CoreData


extension Musician {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Musician> {
        return NSFetchRequest<Musician>(entityName: "Musician")
    }

    @NSManaged public var disambiguation: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}

extension Musician : Identifiable {

}
