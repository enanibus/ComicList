//
//  HTTPFetcher.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

public enum HTTPError: Error {
    case badStatus(Int)
}

/// An object that fetches the data for a HTTP request
public protocol HTTPFetcher {

    /// Fetches the contents of a URL based on the specified request object.
    ///
    /// - parameter request: An `NSURLRequest` object that provides the URL, request type, etc.
    ///
    /// - returns: An observable that will send the contents and complete.
    func data(request: URLRequest) -> Observable<Data>
}
