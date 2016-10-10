//
//  Button.swift
//  ComicList
//
//  Created by Guillermo Gonzalez on 02/10/2016.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import UIKit

private let contentInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

/// A pill-shaped button
final class Button: UIButton {

    struct Style {
        let titleColor: UIColor?
        let normalBackgroundImage: UIImage?
        let highlightedBackgroundImage: UIImage?
    }

    /// Button title
    var title: String {
        didSet {
            didSetTitle()
        }
    }

    /// Button style
    var style: Style {
        didSet {
            didSetStyle()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            didSetIsHighlighted()
        }
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.height = 24

        return size
    }

    private var previousTintColor: UIColor?

    init(title: String = "", style: Style = .outline) {
        self.title = title
        self.style = style

        super.init(frame: CGRect.zero)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        title = ""
        style = .outline

        super.init(coder: aDecoder)

        setup()
    }

    // MARK: Private

    private func setup() {
        adjustsImageWhenHighlighted = false
        contentEdgeInsets = contentInsets
        titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold)

        didSetTitle()
        didSetStyle()
    }

    private func didSetTitle() {
        setTitle(title.uppercased(), for: .normal)
    }

    private func didSetStyle() {

        setTitleColor(style.titleColor ?? tintColor, for: .normal)
        setBackgroundImage(style.normalBackgroundImage, for: .normal)
        setBackgroundImage(style.highlightedBackgroundImage, for: .highlighted)

        invalidateIntrinsicContentSize()
    }

    private func didSetIsHighlighted() {
        if style.titleColor != nil {
            if isHighlighted {
                previousTintColor = tintColor
                tintColor = tintColor.darkened(withRatio: 0.15)
            } else {
                tintColor = previousTintColor
            }
        }
    }
}

extension Button.Style {

    /// Outline style
    static let outline = Button.Style(titleColor: nil,
                                      normalBackgroundImage: UIImage(asset: .buttonBackgroundOutline),
                                      highlightedBackgroundImage: UIImage(asset: .buttonBackgroundHighlighted))
    /// Solid style
    static let solid = Button.Style(titleColor: UIColor.white,
                                    normalBackgroundImage: UIImage(asset: .buttonBackgroundSolid),
                                    highlightedBackgroundImage: nil)
}
