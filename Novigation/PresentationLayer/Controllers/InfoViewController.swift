//
//  InfoViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 27.05.2022.
//

import UIKit
import KeychainSwift

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



    private lazy var buttonExit: UIButton = {
        let buttonExit = UIButton()
        let screen = UIScreen.main.bounds.width
        let screenH = UIScreen.main.bounds.height
        
        buttonExit.frame = CGRect(x: 20, y: screenH / 2, width: screen - 40, height: 30)
        buttonExit.backgroundColor = .systemPink
        buttonExit.addTarget(self, action: #selector(didTagButton), for: .touchUpInside)
        buttonExit.setTitle( NSLocalizedString("buttonExit", tableName: "InfoViewControllerLocalizable", comment: ""), for: .normal)
        buttonExit.layer.cornerRadius = 10
        buttonExit.clipsToBounds = true
        return buttonExit
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.buttonExit)
        self.view.addSubview(self.label)
        self.view.addSubview(self.labelPlanetOrbitalPeriod)
        self.view.addSubview(self.tableViewPlanetResident)
        self.navigationItem.title = NSLocalizedString("navigationItem.title", tableName: "InfoViewControllerLocalizable", comment: "Настройки") 

        ManagerDataModelData.requestForModelData { string in
            DispatchQueue.main.async {
                self.label.text = string
            }
        }

        ManagerDataModelPlanet.requestModelPlanet { planet in
            guard let planet else {
                print("ManagerDataModelPlanet: planet = nil")
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
            self.tableViewPlanetResident.bottomAnchor.constraint(equalTo: self.buttonExit.topAnchor)
        ])
    }



    @objc private func didTagButton() {

        let alertExit = UIAlertController(title: nil, message: NSLocalizedString("buttonExitAlertExit", tableName: "InfoViewControllerLocalizable", comment: "Выйти из аккаунта?"), preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: NSLocalizedString("buttonExitCancelAction", tableName: "InfoViewControllerLocalizable", comment: ""),
                                         style: .cancel,
                                         handler: {_ in
        })
        alertExit.addAction(cancelAction)
        
        let exitAction = UIAlertAction(title: NSLocalizedString("buttonExitExitAction", tableName: "InfoViewControllerLocalizable", comment: ""),
                                         style: .destructive,
                                         handler: {_ in

          //  UserDefaults.standard.removeObject(forKey: "userOnline")

            KeychainSwift().delete("userOnline")
            self.dismiss(animated: true)

        })
        alertExit.addAction(exitAction)
        present(alertExit, animated: true)
    }
}



extension InfoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  ManagerDataResidentsPlanet.residentsPlanetUserDefaults.count

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableViewPlanetResident.dequeueReusableCell(withIdentifier: InfoTableViewCell.name, for: indexPath) as? InfoTableViewCell
        else
        {
            let cell = self.tableViewPlanetResident.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
            return cell
        }
        cell.setupInfoTableViewCell(ManagerDataResidentsPlanet.residentsPlanetUserDefaults[indexPath.row].name)
        
        return cell
    }
}



