//
//  VolumeDetailCoordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import ComicContainer

/// Coordinates the presentation of a volume detail
final class VolumeDetailCoordinator: Coordinator {

    private let volume: Volume
    private unowned let navigationController: UINavigationController

    init(volume: Volume, navigationController: UINavigationController) {
        self.volume = volume
        self.navigationController = navigationController
    }

    override func start() {
        let viewController = VolumeDetailViewController(volume: volume)

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
