//
//  HeaderContainerVIew.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import Foundation
import UIKit

class HeaderContainerVIew: UIView {
    var imageViewHeight = NSLayoutConstraint()
    var imageViewBottom = NSLayoutConstraint()

    var containerViewHeight = NSLayoutConstraint()

    lazy var containerView: UIView = {
        let containerView = UIView()

        return containerView
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func loadViews() {
        self.addSubview(containerView)
        containerView.addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor),
        ])

        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false

        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true

        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
