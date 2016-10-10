//
//  TemporaryPersistentContainer.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 09/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import CoreData

internal final class TemporaryPersistentContainer: NSPersistentContainer {

    override class func defaultDirectoryURL() -> URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }

    init(managedObjectModel model: NSManagedObjectModel) {
        super.init(name: UUID().uuidString, managedObjectModel: model)
    }
}
