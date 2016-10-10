//
//  VolumeResults.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 08/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import CoreData

public protocol VolumeResultsType {

    /// Called when volumes are inserted, updated or removed
    var didUpdate: () -> Void { get set }

    /// The number of volumes in the result set
    var numberOfVolumes: Int { get }

    /// Returns the volume at a given index
    func volume(at index: Int) -> Volume
}

internal final class VolumeResults: NSObject, VolumeResultsType {

    // MARK: - VolumeResultsType

    var didUpdate: () -> Void = {}

    var numberOfVolumes: Int {
        return resultsController.fetchedObjects?.count ?? 0
    }

    func volume(at index: Int) -> Volume {
        let indexPath = IndexPath(indexes: [0, index])
        let entry = resultsController.object(at: indexPath)

        return Volume(entry: entry)
    }

    // MARK: - Properties

    private let resultsController: NSFetchedResultsController<VolumeEntry>

    // MARK: - Initialization

    init(fetchRequest: NSFetchRequest<VolumeEntry>, context: NSManagedObjectContext) {

        resultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil)

        super.init()

        resultsController.delegate = self
        try! resultsController.performFetch()
    }
}

extension VolumeResults: NSFetchedResultsControllerDelegate {

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        didUpdate()
    }
}
