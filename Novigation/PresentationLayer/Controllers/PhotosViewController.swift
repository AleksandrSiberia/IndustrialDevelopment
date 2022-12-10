//
//  PhotosViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 18.06.2022.


import UIKit
import StorageService
import iOSIntPackage

class PhotosViewController: UIViewController {

    private enum numberItem {
        static let number = 3.0
    }

    var imageProcessor: ImageProcessor?
    
    var arrayUIImage: [UIImage] = []


    private lazy var collectionFlowLayout: UICollectionViewFlowLayout = {
        var collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset =  UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionFlowLayout.minimumLineSpacing = 8
        collectionFlowLayout.minimumInteritemSpacing = 8
        collectionFlowLayout.scrollDirection = .vertical
        return collectionFlowLayout
    }()

    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.nameCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        self.navigationItem.title = NSLocalizedString("navigationItem.title", tableName: "PhotosViewControllerLocalizable", comment: "")
        self.view.addSubview(self.collectionView)
        setupConstraints()

        let queue = DispatchQueue.global(qos: .userInteractive)

        let workItem = DispatchWorkItem.init(qos: .userInteractive) {

            guard arrayImages.isEmpty == false else {
                preconditionFailure("Массив с фотографиями пуст")
                    }

            let start = DispatchTime.now()
            self.imageProcessor?.processImagesOnThread(sourceImages: arrayImages, filter: .chrome, qos: .utility, completion:
                                                        { arrayNewImage in
                arrayNewImage.forEach { fotoCG in
                    self.arrayUIImage.append(UIImage(cgImage: fotoCG!))
                }
                let end = DispatchTime.now()
                let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(nanoTime) / 1_000_000_000
                print("Время исполнения метода \(timeInterval) секунд")

                //  Время исполнения метода processImagesOnThread:
                //    .background 8.463020833 секунд
                //    .utility    1.70017675 секунд
                //    .userInitiated 1.76629675 секунд
                //    .userInteractive  1.751627459 сукунд

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        }
        queue.sync(execute: workItem)
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        self.arrayUIImage.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.nameCollectionCell, for: indexPath) as? PhotosCollectionViewCell else { let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.backgroundColor = .black
        cell.setupImage(self.arrayUIImage[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minimumInteritemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero

        var screenWidth = collectionView.frame.width - (minimumInteritemSpacing * (numberItem.number - 1)) - sectionInset.left - sectionInset.right

        screenWidth = floor (screenWidth / numberItem.number)
        return  CGSize(width: screenWidth, height: screenWidth)
    }
}

