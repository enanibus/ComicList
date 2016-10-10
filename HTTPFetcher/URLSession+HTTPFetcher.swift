//
//  URLSession+HTTPFetcher.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

extension URLSession: HTTPFetcher {

    public func data(request: URLRequest) -> Observable<Data> {

        return Observable.create { observer in

            let task = self.dataTask(with: request) { data, response, error in

                if let error = error {
                    observer.onError(error)
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }

                    if 200 ..< 300 ~= httpResponse.statusCode {
                        observer.onNext(data ?? Data())
                        observer.onCompleted()
                    } else {
                        observer.onError(HTTPError.badStatus(httpResponse.statusCode))
                    }
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}
