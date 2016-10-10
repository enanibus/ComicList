//
//  VolumeHeaderView.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

/// A header that displays information about a volume
final class VolumeHeaderView: UIView {

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = UIColor(named: .darkText)
        }
    }

    @IBOutlet private weak var publisherLabel: UILabel! {
        didSet {
            publisherLabel.textColor = UIColor(named: .lightText)
        }
    }

    @IBOutlet private weak var button: Button! {
        didSet {
            button.tintColor = UIColor(named: .buttonTint)
        }
    }
    
    @IBOutlet private weak var coverView: CoverView!

    @IBAction private func _didTapButton(sender: UIButton) {
        didTapButton()
    }

    /// The volume title
    var title: String {
        get {
            return titleLabel.text ?? ""
        }

        set {
            titleLabel.text = newValue.uppercased()
        }
    }

    /// The publisher name
    var publisher: String? {
        get {
            return publisherLabel.text
        }

        set {
            publisherLabel.text = newValue
        }
    }

    /// The image URL for the volume
    var coverURL: URL? {
        get {
            return coverView.url
        }

        set {
            coverView.url = newValue
        }
    }

    /// Bindable sink for the status of the volume
    var isSaved: AnyObserver<Bool> {

        return UIBindingObserver(UIElement: button) { button, isSaved in
            // Change the title and style of the button
            // based on the status of the volume
            button.title = isSaved
                ? NSLocalizedString("Remove", comment: "")
                : NSLocalizedString("Add", comment: "")
            button.style = isSaved ? .solid : .outline
        }.asObserver()
    }

    /// Called when the user taps the button
    var didTapButton: () -> Void = {}
}
