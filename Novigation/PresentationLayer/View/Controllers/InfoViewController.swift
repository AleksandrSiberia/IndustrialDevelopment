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
        label.numberOfLines = 0
        return label
    }()

    private lazy var labelPlanetOrbitalPeriod: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray6
        label.textAlignment = .center
        return label
    }()

    private lazy var tableViewPlanetResident: UITableView = {
        var tableViewPlanetResident = UITableView(frame: .zero, style: .grouped)
        tableViewPlanetResident.translatesAutoresizingMaskIntoConstraints = false
        tableViewPlanetResident.delegate = self
        tableViewPlanetResident.dataSource = self
        tableViewPlanetResident.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.name)
        tableViewPlanetResident.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        return tableViewPlanetResident
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
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.alertButton)
        self.view.addSubview(self.label)
        self.view.addSubview(self.labelPlanetOrbitalPeriod)
        self.view.addSubview(self.tableViewPlanetResident)
        self.navigationItem.title = "Настройки"

        requestForModelData { string in
            DispatchQueue.main.async {
                self.label.text = string
            }
        }

        requestModelPlanet { planet in
            guard let planet else {
                print("planet = nil")
                return
            }

            DispatchQueue.main.async {
                self.labelPlanetOrbitalPeriod.text = planet.orbitalPeriod
            }
        }


        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            self.labelPlanetOrbitalPeriod.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 30),
            self.labelPlanetOrbitalPeriod.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.labelPlanetOrbitalPeriod.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),

            self.tableViewPlanetResident.topAnchor.constraint(equalTo: self.labelPlanetOrbitalPeriod.bottomAnchor, constant: 30),
            self.tableViewPlanetResident.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableViewPlanetResident.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableViewPlanetResident.bottomAnchor.constraint(equalTo: self.alertButton.topAnchor)
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

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  residentsPlanetUserDefaults.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        guard let cell = self.tableViewPlanetResident.dequeueReusableCell(withIdentifier: InfoTableViewCell.name, for: indexPath) as? InfoTableViewCell
        else
        {
            let cell = self.tableViewPlanetResident.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            return cell
        }
        cell.setupInfoTableViewCell(residentsPlanetUserDefaults[indexPath.row].name)
        
        return cell
    }
}



