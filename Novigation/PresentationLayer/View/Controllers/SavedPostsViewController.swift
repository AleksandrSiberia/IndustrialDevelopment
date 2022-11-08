//
//  SavedPostsViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 04.11.2022.
//

import UIKit

class SavedPostsViewController: UIViewController {

    var coreDataCoordinator: CoreDataCoordinator!

    private var nameAuthor: String = ""

    private var textFieldSearchAuthor: UITextField?

    private lazy var barButtonItemSearch: UIBarButtonItem = {
        var barButtonItemSearch = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(actionBarButtonItemSearch))
        return barButtonItemSearch
    }()




    private lazy var barButtonItemCancelSearch: UIBarButtonItem = {
        var barButtonItemCancelSearch = UIBarButtonItem(image: UIImage( systemName: "minus.circle"), style: .plain, target: self, action: #selector(actionBarButtonItemCancelSearch))
        return barButtonItemCancelSearch
    }()




    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")

        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")

        tableView.backgroundColor = .white

        return tableView
    }()




    override func viewDidLoad() {
        super.viewDidLoad()


        self.navigationItem.rightBarButtonItems = [self.barButtonItemCancelSearch, self.barButtonItemSearch ]
        self.view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }




    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()

    }





    @objc private func actionBarButtonItemSearch() {
        print("actionBarButtonItemSearch")
        let alert = UIAlertController(title: nil, message: "Напишите имя автора", preferredStyle: .alert)


        alert.addTextField { textField in

            textField.clearButtonMode = .whileEditing
            self.textFieldSearchAuthor = textField
            }


        let actionSearch = UIAlertAction(title: "Найти", style: .default) {action in

            if self.textFieldSearchAuthor?.text != "" {
                print("search")
                self.coreDataCoordinator.reloadPosts(searchAuthor: self.textFieldSearchAuthor?.text)
                self.tableView.reloadData()
            }
        }

        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)

        alert.addAction(actionCancel)
        alert.addAction(actionSearch)

        present(alert, animated: true)
    }





    @objc private func actionBarButtonItemCancelSearch() {
        print("actionBarButtonItemCancelSearch")

        self.coreDataCoordinator.reloadPosts(searchAuthor: nil)
        self.tableView.reloadData()


    }
}






extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource  {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {



    //    self.coreDataCoordinator.savedPosts.count
        return self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?[section].numberOfObjects ?? 0
    }




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell

        else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

//        if  self.coreDataCoordinator.savedPosts.isEmpty == true {
//             assertionFailure(CustomErrorNovigation.noPost.rawValue)
//        }

      //  let indexPathRow = indexPath.row

        let postCoreData = self.coreDataCoordinator.fetchedResultsControllerPostCoreData.object(at: indexPath)

  //      let postCoreData = self.coreDataCoordinator.savedPosts[indexPathRow]

        cell.setup(author: postCoreData.author, image: postCoreData.image, likes: postCoreData.likes, text: postCoreData.text, views: postCoreData.views, coreDataCoordinator: self.coreDataCoordinator)
        return cell
        
    }



//    func numberOfSections(in tableView: UITableView) -> Int {
//        self.coreDataCoordinator.fetchResultController.sections?.count ?? 0
//    }



    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Удалить из сохраненного") { [weak self] (uiContextualAction, uiView, completionHandler) in

            let post = self!.coreDataCoordinator.fetchedResultsControllerPostCoreData.object(at: indexPath)

            self!.coreDataCoordinator.deletePost(post: post)

            self!.tableView.reloadData()

            completionHandler(true)

        }

        //   action.backgroundColor = UIColor( named: "MyColorSet")

        let actionConfiguration = UISwipeActionsConfiguration(actions: [action])
        actionConfiguration.performsFirstActionWithFullSwipe = true

        return actionConfiguration
    }
}


