//
//  CoreDataMappable.swift
//  Changelle
//
//  Created by Fernando Ortiz Escobar on 19/08/25.
//

import CoreData

protocol CoreDataMappable {
    associatedtype Entity: NSManagedObject

    init?(entity: Entity)

    func toEntity(in context: NSManagedObjectContext) -> Entity
}
