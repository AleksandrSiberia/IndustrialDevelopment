//
//  PostViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 26.05.2022.
//

import UIKit

import StorageService

class PostViewController: UIViewController {
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemOrange
        let rightBotton = UIBarButtonItem(title: "Настройки", style: .plain, target: self, action: #selector(didTapButton))
        self.navigationItem.rightBarButtonItem = rightBotton
        if let post1: String = self.post?.title {
            self.navigationItem.title = post1
        }
        else {
        }
    }

    @objc private func didTapButton(){
        let infoViewController = InfoViewController()
        let infoUINavigationController = UINavigationController(rootViewController: infoViewController)
        present(infoUINavigationController, animated: true)
    }
}
