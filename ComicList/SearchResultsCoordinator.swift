//
//  SearchResultsCoordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

/// Coordinates the presentation of the search results
final class SearchResultsCoordinator: Coordinator {

    private let query: String
    private unowned let navigationController: UINavigationController

    init(query: String, navigationController: UINavigationController) {
        self.query = query
        self.navigationController = navigationController
    }

    override func start() {
        let viewController = SearchResultsViewController(query: query)

        // Present the detail when a volume is selected in the search results
        viewController.didSelectVolume = { [weak self] volume in
            guard let `self` = self else {
                return
            }

            let coordinator = VolumeDetailCoordinator(volume: volume, navigationController: self.navigationController)
            self.add(child: coordinator)

            coordinator.start()
        }

        viewController.didFinish = { [weak self] in
            guard let `self` = self else {
                return
            }

            // This will remove the coordinator from its parent
            self.didFinish()
        }

        navigationController.pushViewController(viewController, animated: true)
    }
}
