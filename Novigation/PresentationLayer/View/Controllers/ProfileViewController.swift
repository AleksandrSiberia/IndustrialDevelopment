//
//  ProfileViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 26.05.2022.
//

import UIKit
import iOSIntPackage
import FirebaseAuth



protocol ProfileViewControllerOutput {
    func timerStop()
}



final class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    var savedPostsController: Bool = false

    var handle: AuthStateDidChangeListenerHandle?

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





    private lazy var tapGestureRecogniser: UITapGestureRecognizer = {
        var tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.actionTapGestureRecogniser(recogniser:)))
            tapGestureRecogniser.delegate = self
        tapGestureRecogniser.numberOfTapsRequired = 2
        return tapGestureRecogniser
    }()




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
        self.view.addGestureRecognizer(self.tapGestureRecogniser)
        self.setupConstraints()
    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

        if self.delegate != nil {
            self.delegate.showPost()
        }
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }
    }




    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.output?.timerStop()

        Auth.auth().removeStateDidChangeListener(handle!)
    }




    private func setupConstraints() {
        NSLayoutConstraint.activate([
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    


    @objc private func actionTapGestureRecogniser(recogniser: UITapGestureRecognizer) {

        if recogniser.state == .ended {
            let tapLocation = recogniser.location(in: self.tableView)
            if let tapIndexPathTableView = self.tableView.indexPathForRow(at: tapLocation) {
                if let tappedCell = self.tableView.cellForRow(at: tapIndexPathTableView) as? PostCell {

                    tappedCell.savePost()
                    print("posts >>>>>>>>", self.posts[0])

                }
            }
        }
    }
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.savedPostsController == false {
            return section == 1 ? self.posts.count : 1
        }
        else {
            print("count >>>>", CoreDataCoordinator.shared.posts.count)
            return section == 1 ? CoreDataCoordinator.shared.posts.count : 1
        }
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


            if self.posts.isEmpty == true && CoreDataCoordinator.shared.posts.isEmpty == true {
                 assertionFailure(CustomErrorNovigation.noPost.rawValue)
            }

            let indexPathRow = indexPath.row


            if self.savedPostsController == false {
                let post = self.posts[indexPathRow]
            
                cell.setup(author: post.author, image: post.image, likes: String(post.likes), text: post.description, views: String(post.views))
                return cell
            }
            else {
                let postCoreData = CoreDataCoordinator.shared.posts[indexPathRow]

                print("postCoreData  >>>>>>>>", postCoreData)
                cell.setup(author: postCoreData.author, image: postCoreData.image, likes: postCoreData.likes, text: postCoreData.description, views: postCoreData.views)
                return cell
            }

        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let profileHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ProfileHeaderView") as? ProfileHeaderView else { return nil }
            if currentUser != nil {
                profileHeaderView.setupUser(currentUser!)
            }
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




