//
//  ProfileViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 26.05.2022.
//

import UIKit
import iOSIntPackage
import FirebaseAuth
import CoreData



protocol ProfileViewControllerOutput {
    func timerStop()
}



final class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    var coreDataCoordinator: CoreDataCoordinator!

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


        
        self.view.addSubview(self.tableView)
        self.view.addGestureRecognizer(self.tapGestureRecogniser)
        self.setupConstraints()
    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true


//        self.coreDataCoordinator.fetchedResultsControllerPostCoreData.delegate = self

        
        if self.delegate != nil {
            self.delegate.showPost()
        }
        handle = Auth.auth().addStateDidChangeListener { auth, user in
          // ...
        }


        self.coreDataCoordinator.getPosts(nameFolder: "AllPosts")

        if (self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?.first?.objects?.isEmpty)! {
            for post in arrayModelPost {
                self.coreDataCoordinator.appendPost(author: post.author, image: post.image, likes: String(post.likes), text: post.description, views: String(post.views), folderName: "AllPosts") { _ in
                }
            }
        }

        self.tableView.reloadData()
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

                    var error = tappedCell.savePost()

                    if error == nil {
                        error = "Пост сохранен"
                    }

                    let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel)
                    alert.addAction(action)

                    self.present(alert, animated: true)
                }

            }
        }
    }
}





extension ProfileViewController: UITableViewDelegate, UITableViewDataSource  {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return 1
        }
        if section == 1 {
            return self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?[0].objects?.count ?? 0
        }
        else {
            return 0
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

//            if self.posts.isEmpty == true && self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?[0].objects?.isEmpty == true {
//                assertionFailure(CustomErrorNovigation.noPost.rawValue)
//            }

            let post = self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?.first?.objects![indexPath.row] as! PostCoreData
            
            cell.setup(author: post.author, image: post.image, likes: post.likes, text: post.text, views: post.views, coreDataCoordinator: self.coreDataCoordinator)
            return cell
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


extension ProfileViewController: NSFetchedResultsControllerDelegate {


    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.tableView.reloadData()
    }
}



