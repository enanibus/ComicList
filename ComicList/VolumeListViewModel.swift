//
//  VolumeListViewModel.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import ComicContainer

/// Represents a volume list view model
protocol VolumeListViewModelType: class {

    /// Called when volumes are inserted or removed
    var didUpdate: () -> Void { get set }

    /// The number of volumes in the list
    var numberOfVolumes: Int { get }

    /// Returns the volume at a given position
    func item(at position: Int) -> Volume
}

final class VolumeListViewModel: VolumeListViewModelType {

    var didUpdate: () -> Void = {}

    var numberOfVolumes: Int {
        return results.numberOfVolumes
    }

    func item(at position: Int) -> Volume {
        return results.volume(at: position)
    }

    private let results: VolumeResultsType

    init(results: VolumeResultsType = VolumeContainer.instance.all()) {
        self.results = results

        self.results.didUpdate = { [weak self] in
            self?.didUpdate()
        }
    }
}
