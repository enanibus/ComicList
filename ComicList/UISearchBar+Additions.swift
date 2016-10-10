//
//  UISearchBar+Additions.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 29/09/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

extension UISearchBar {

    var searchFieldTextColor: UIColor? {
        get {
            return value(forKeyPath: "searchField.textColor") as? UIColor
        }

        set {
            setValue(newValue, forKeyPath: "searchField.textColor")
        }
    }
}

