//
//  VolumeEntry.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 08/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import CoreData

internal class VolumeEntry: NSManagedObject {

    @NSManaged var identifier: Int
    @NSManaged var title: String
    @NSManaged var publisher: String?

    var coverURL: URL? {
        get {
            return imageURL.flatMap { URL(string: $0) }
        }

        set {
            imageURL = newValue?.absoluteString
        }
    }

    @NSManaged private var imageURL: String?
    @NSManaged private(set) var insertionDate: Date

    override func awakeFromInsert() {
        super.awakeFromInsert()
        insertionDate = Date()
    }
}

extension VolumeEntry {

    static func defaultFetchRequest() -> NSFetchRequest<VolumeEntry> {
        let fetchRequest = NSFetchRequest<VolumeEntry>(entityName: "VolumeEntry")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: "insertionDate", ascending: true)
        ]

        return fetchRequest
    }

    static func fetchRequest(forVolumeWithIdentifier identifier: Int) -> NSFetchRequest<VolumeEntry> {
        let fetchRequest = NSFetchRequest<VolumeEntry>(entityName: "VolumeEntry")

        fetchRequest.predicate = NSPredicate(format: "identifier == %d", identifier)
        fetchRequest.fetchLimit = 1
        
        return fetchRequest
    }

    convenience init(volume: Volume, context moc: NSManagedObjectContext) {
        self.init(context: moc)

        identifier = volume.identifier
        title = volume.title
        coverURL = volume.coverURL
        publisher = volume.publisherName
    }
}
