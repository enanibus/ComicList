//
//  AppCoordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import ComicContainer

final class AppCoordinator: Coordinator {

    private let window: UIWindow
    private let navigationController = UINavigationController()
    private let volumeContainer = VolumeContainer.instance

    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let _ = volumeContainer.load().subscribe()

        customizeAppearance()
        
        window.rootViewController = navigationController

        // The volume list is the initial screen
        let coordinator = VolumeListCoordinator(navigationController: navigationController)

        add(child: coordinator)
        coordinator.start()

        window.makeKeyAndVisible()
    }

    private func customizeAppearance() {
        let navigationBarAppearance = UINavigationBar.appearance()
        let barTintColor = UIColor(named: .bar)

        navigationBarAppearance.barStyle = .black // This will make the status bar white by default
        navigationBarAppearance.barTintColor = barTintColor
        navigationBarAppearance.tintColor = UIColor.white
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white
        ]
    }
}
