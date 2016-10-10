//
//  Coordinator.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

/// A coordinator encapsulates navigation logic
protocol CoordinatorType: class {

    /// Tells the coordinator to start its work, i.e. present a view controller.
    func start()

    /// Marks the coordinator as finished.
    ///
    /// The coordinator will remove itself from its parent.
    func didFinish()

    /// Add a child coordinator
    func add(child: CoordinatorType)

    /// Remove a child coordinator
    ///
    /// Usually, you shouldn't need to call this method. Instead it is preferable
    /// to call the child coordinator's `didFinish` method.
    func remove(child: CoordinatorType)
}

/// Base class for coordinators
class Coordinator: NSObject, CoordinatorType {

    private var parentCoordinator: CoordinatorType?
    private var childCoordinators: [CoordinatorType] = []

    func start() {
    }

    func didFinish() {
        parentCoordinator?.remove(child: self)
    }

    final func add(child: CoordinatorType) {
        childCoordinators.append(child)

        if let impl = child as? Coordinator {
            impl.parentCoordinator = self
        }
    }

    final func remove(child: CoordinatorType) {
        let index = childCoordinators.index {
            $0 === child
        }

        if let index = index {
            print("removing coordinator \(child)")
            childCoordinators.remove(at:index)
        }
    }
}
