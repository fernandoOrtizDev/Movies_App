//
//  Favorite+CoreDataProperties.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 18/08/25.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var img: String
    @NSManaged public var releaseDate: String
    @NSManaged public var idMovie: String
    @NSManaged public var title: String

}

extension Favorite : Identifiable {

}
