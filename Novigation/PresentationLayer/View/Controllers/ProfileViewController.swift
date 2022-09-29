//
//  ProfileViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 26.05.2022.
//

import UIKit
import iOSIntPackage

protocol ProfileViewControllerOutput {
    func timerStop()
}

final class ProfileViewController: UIViewController {

    var delegate: ProfileViewDelegate! {

        didSet {

            self.delegate.didChange = { [ unowned self ] delegate in
                self.posts = delegate.posts!
                self.tableView.reloadData()
            }
        }
    }

    var output: ProfileViewControllerOutput?

    private var posts: [ModelPost] = []

    var currentUser: User?

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
        tableView.backgroundColor = .systemGray6
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
        self.delegate.showPost()
    }


    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.output?.timerStop()
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
    
        return section == 1 ? self.posts.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as? PhotosTableViewCell else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            self.output = cell
            return cell
        }

        else {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }




            let indexPathRow = indexPath.row

    //        let post = self.posts[indexPathRow]

            //       let post = self.posts[indexPathRow]

            self.delegate.extractPostsArray(this: self.posts) { result in

                switch result {

                case .success(let posts):
                    let post = posts[indexPathRow]
                    cell.setup(this: post)
                case .failure(let error):
                    print(error.description)
                }
            }
            //      cell.setup(this: post)
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView else { return nil }
            profileHeaderView.setupUser(currentUser!)
           
            return profileHeaderView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {

            self.navigationController?.pushViewController(PhotosAssembly.showPhotosViewController(), animated: true)
        }
    }
}




