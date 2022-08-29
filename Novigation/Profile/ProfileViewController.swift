//
//  ProfileViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 26.05.2022.
//

import UIKit

final class ProfileViewController: UIViewController {


    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileHeaderView")
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")

        #if DEBUG
        tableView.backgroundColor = .white
        #else
        tableView.backgroundColor = .red
        #endif

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        self.setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 1 ? arrayModelPost.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        }

        else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        let indexPathRow = indexPath.row
        let post = arrayModelPost[indexPathRow]
        cell.setup(this: post)
        return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView else { return nil }
            return profileHeaderView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let photosViewController = PhotosViewController()
            photosViewController.navigationItem.title = "Photos Gallery"


            self.navigationController?.pushViewController(photosViewController, animated: true)
        }
    }



}





