//
//  PhotosAssembly.swift
//  Novigation
//
//  Created by Александр Хмыров on 22.09.2022.
//

import Foundation
import iOSIntPackage


class PhotosAssembly {

    static func showPhotosViewController() -> PhotosViewController {

        let photosViewController = PhotosViewController()
        let imageProcessor = ImageProcessor()
        photosViewController.imageProcessor = imageProcessor
        photosViewController.navigationItem.title = "Photos Gallery"
        return photosViewController

    }
}
