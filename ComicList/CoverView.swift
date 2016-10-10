//
//  CoverView.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

import ImageLoader
import RxSwift
import RxCocoa

/// Displays a cover image
final class CoverView: UIView {

    // MARK: Properties

    /// The url of the cover image
    var url: URL? {
        didSet {
            didSetURL()
        }
    }

    fileprivate let imageView = UIImageView()
    fileprivate let loader = RemoteImageLoader.instance
    fileprivate var disposeBag: DisposeBag?

    // MARK: Initialization

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Overrides

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

// MARK: Private

private extension CoverView {

    func setup() {
        addSubview(imageView)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }

    func didSetURL() {
        // This will cancel any ongoing download
        self.disposeBag = nil
        imageView.image = nil

        guard let url = url else {
            return
        }

        let disposeBag = DisposeBag()

        // Load the image and bind the result to our observer property
        loader.image(for: url)
            .bindTo(imageObserver)
            .addDisposableTo(disposeBag)

        self.disposeBag = disposeBag
    }

    /// A bindable observer for remote images
    var imageObserver: AnyObserver<UIImage?> {

        return UIBindingObserver(UIElement: imageView) { imageView, image in

            // If there is an error (image is nil) we should cancel any ongoing
            // animations and reset our image view
            guard let image = image else {
                imageView.layer.removeAllAnimations()
                imageView.image = nil

                return
            }

            // Add a fade animation and set the image
            imageView.layer.add(CATransition.fade, forKey: kCATransition)
            imageView.image = image
        }.asObserver()
    }
}

private extension CATransition {

    static var fade: CATransition {
        let transition = CATransition()
        transition.duration = 0.25
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        
        return transition
    }
}
