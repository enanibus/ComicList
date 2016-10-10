//
//  Response.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 08/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public struct Response {

    public let status: Int
    public let message: String
    fileprivate let payload: Any

    public var succeeded: Bool {
        return status == 1
    }

    public func result<T: JSONDecodable>() -> T? {
        return (payload as? JSONDictionary).flatMap(decode)
    }

    public func results<T: JSONDecodable>() -> [T]? {
        return (payload as? [JSONDictionary]).flatMap(decode)
    }
}

extension Response: JSONDecodable {

    public init?(dictionary: JSONDictionary) {
        guard
            let status = dictionary["status_code"] as? Int,
            let message = dictionary["error"] as? String,
            let payload = dictionary["results"] else {
            return nil
        }

        self.status = status
        self.message = message
        self.payload = payload
    }
}
