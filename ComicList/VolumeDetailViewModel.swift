//
//  VolumeDetailViewModel.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 03/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

import ComicContainer
import ComicService

protocol VolumeDetailViewModelType: class {

    /// Determines if the volume is saved in the user's comic list
    var isSaved: Observable<Bool> { get }

    /// The volume info
    var volume: Volume { get }

    /// The volume description
    var about: Observable<String?> { get }

    /// The issues for this volume
    var issues: Observable<[Issue]> { get }

    /// Adds or removes the volume from the user's comic list
    func addOrRemove()
}

// FIXME: This is a mock implementation
final class VolumeDetailViewModel: VolumeDetailViewModelType {

    var isSaved: Observable<Bool> {
        return saved.asObservable()
    }

    private(set) var volume: Volume

    private(set) lazy var about: Observable<String?> = self.client
        .object(forResource: API.description(volumeIdentifier: self.volume.identifier))
        .map { (value: VolumeDescription) -> String? in
            return value.description
        }
        .startWith("")
        .observeOn(MainScheduler.instance)

    private(set) var issues: Observable<[Issue]> = Observable.just([
        Issue(title: "Lorem fistrum", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/3/38919/1251093-thanos_imperative_1.jpg")),
        Issue(title: "Quietooor ahorarr", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/0/9116/1299822-296612.jpg")),
        Issue(title: "Apetecan", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/5/57845/1333458-cover.jpg")),
        Issue(title: "Rodrigor mamaar", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/5/56213/1386494-thanos_imperative__4.jpg")),
        Issue(title: "Benemeritaar", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/3/38919/1452486-thanos_imperative_5.jpg")),
        Issue(title: "Caballo blanco caballo negroorl", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/3/38919/1503818-thanos_imperative_6.jpg")),
        Issue(title: "Quietooor diodeno", coverURL: URL(string: "http://static.comicvine.com/uploads/scale_small/3/39027/4609736-4608485-cgxpqgqw0aao_8t+-+copy.jpg"))
    ])

    private let container: VolumeContainerType
    private let client: Client
    private let saved: Variable<Bool>

    init(volume: Volume,
         container: VolumeContainerType = VolumeContainer.instance,
         client: Client = Client()) {
        self.volume = volume
        self.container = container
        self.client = client

        self.saved = Variable(container.contains(volumeWithIdentifier: volume.identifier))
    }

    func addOrRemove() {

        let observable: Observable<Void>

        if saved.value {
            observable = container.delete(volumeWithIdentifier: volume.identifier)
        } else {
            observable = container.save(volumes: [volume])
        }

        let _ = observable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                self.saved.value = !self.saved.value
            })
    }
}
