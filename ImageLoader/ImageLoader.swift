//
//  ImageLoader.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit
import RxSwift

/// Load images from URLs
public protocol ImageLoader {

    /// Loads an image from the specified URL.
    ///
    /// - parameter url: The URL.
    ///
    /// - returns: An observable that will send an image or nil, and then complete.
    func image(for url: URL) -> Observable<UIImage?>
}
