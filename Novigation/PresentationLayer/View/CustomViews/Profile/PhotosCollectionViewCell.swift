//
//  PhotosCollectionViewCell.swift
//  Novigation
//
//  Created by Александр Хмыров on 18.06.2022.
//

import UIKit

protocol CellProtocol: AnyObject {
    
    static var nameCollectionCell: String { get }
}

class PhotosCollectionViewCell: UICollectionViewCell {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraint()
    }

    private func setupConstraint() {


        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupImage(_ name: UIImage) {
        imageView.image = name
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosCollectionViewCell: CellProtocol {
    static var nameCollectionCell: String {
        return String(describing: self)
    }
}



