//
//  InfoViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 27.05.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        return label
    }()
    
    private lazy var alertButton: UIButton = {
        let button = UIButton()
        let screen = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        
        button.frame = CGRect(x: 20, y: screenH / 2, width: screen - 40, height: 30)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(didTagButton), for: .touchUpInside)
        button.setTitle("Удалить аккаунт", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(alertButton)
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.alertButton)
        self.view.addSubview(self.label)
        self.navigationItem.title = "Настройки"

        requestForModelData { string in
            DispatchQueue.main.async {
                self.label.text = string
            }
        }

        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }


    @objc private func didTagButton() {
        let alertDelete = UIAlertController(title: "Удалить акаунт", message: "Вы хотите удалить аккаунт?", preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "Отмена",
                                         style: .cancel,
                                         handler: {_ in
            print("Cancel")
        })
        alertDelete.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Удалить",
                                         style: .destructive,
                                         handler: {_ in
            self.dismiss(animated: true)
            print("Delete")
        })
        alertDelete.addAction(deleteAction)
        present(alertDelete, animated: true)
    }
    
}



