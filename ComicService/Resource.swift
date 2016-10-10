//
//  Resource.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 08/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation

public enum Method: String {
    case GET = "GET"
}

public protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Resource {

    public var method: Method {
        return .GET
    }

    public var parameters: [String: String] {
        return [:]
    }

    func request(withBaseURL baseURL: URL, additionalParameters: [String: String]) -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        var parameters = self.parameters
        additionalParameters.forEach {
            parameters.updateValue($1, forKey: $0)
        }

        components.queryItems = parameters.map(URLQueryItem.init)

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        return request
    }
}
