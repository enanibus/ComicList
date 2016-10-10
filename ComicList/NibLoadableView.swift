//
//  NibLoadableView.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 30/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

/// See [iOS Cell Registration & Reusing with Swift Protocol Extensions and Generics](https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e#.hi9bpcmnf)
protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
