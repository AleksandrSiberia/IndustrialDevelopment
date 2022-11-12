//
//  PostCell.swift
//  Novigation
//
//  Created by Александр Хмыров on 15.06.2022.
//

import UIKit
import iOSIntPackage

class PostCell: UITableViewCell {


    private var nameImage: String?

    var coreDataCoordinator: CoreDataCoordinator!

    private lazy var authorLabel: UILabel = {
        var authorLabel = UILabel()

        authorLabel.backgroundColor = .white
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.numberOfLines = 2
        authorLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        authorLabel.textColor = .black
        return authorLabel
    }()




    private lazy var postImageView: UIImageView = {
        var postImageView = UIImageView()
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.backgroundColor = .black
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        return postImageView
    }()




    private lazy var descriptionLabel: UILabel = {
        var descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.backgroundColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .systemGray
        return descriptionLabel
    }()




    private lazy var likesLabel: UILabel = {
        var likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.backgroundColor = .white
        likesLabel.numberOfLines = 0
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        return likesLabel
    }()




    private lazy var viewsLabel: UILabel = {
        var viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.backgroundColor = .white
        viewsLabel.numberOfLines = 0
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        return viewsLabel
    }()




    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

     //   self.addGestureRecognizer(self.tapGestureRecogniser)

    }




    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }




    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            self.likesLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 16),
            self.viewsLabel.widthAnchor.constraint(equalToConstant: (self.frame.width / 2) - 16)
        ])
    }




    func savePost() -> String? {

        var errorSave: String?
        
        self.coreDataCoordinator.appendPost(author: self.authorLabel.text, image: self.nameImage, likes: self.likesLabel.text, text: self.descriptionLabel.text, views: self.viewsLabel.text, folderName: "SavedPosts") { error in
            errorSave = error
        }
        return errorSave
    }




    private func setupView() {
        self.addSubview(authorLabel)
        self.addSubview(postImageView)
        self.addSubview(descriptionLabel)
        self.addSubview(likesLabel)
        self.addSubview(viewsLabel)

        NSLayoutConstraint.activate( [
            self.authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.authorLabel.bottomAnchor.constraint(equalTo: self.postImageView.topAnchor, constant: -12),


            self.postImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
            self.postImageView.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -16),


            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.likesLabel.topAnchor, constant: -16),

            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.likesLabel.trailingAnchor.constraint(equalTo: self.viewsLabel.leadingAnchor),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),

            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsLabel.leadingAnchor.constraint(equalTo: self.likesLabel.trailingAnchor),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }



    
    func setup(author: String?, image: String?, likes: String?, text: String?, views: String?, coreDataCoordinator: CoreDataCoordinator) {

        self.coreDataCoordinator = coreDataCoordinator

        self.authorLabel.text = author

        self.nameImage = image

        let filter = ImageProcessor()

        var filteredImage: UIImage?


        filter.processImage(sourceImage: UIImage(named: image ?? "")!, filter: ColorFilter.noir) { outputImage in
            filteredImage = outputImage
        }

        self.postImageView.image = filteredImage
        self.descriptionLabel.text = text
        self.likesLabel.text = "Likes: " + String(likes ?? "")
        self.viewsLabel.text = "Views: " + String(views ?? "")
            }
}

