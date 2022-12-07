//
//  SavedPostsViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 04.11.2022.
//

import UIKit
import CoreData


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

        self.navigationItem.title = NSLocalizedString("navigationItem.title", tableName: "SavedPostsViewControllerLocalizable", comment: "Saved posts")

        self.coreDataCoordinator.fetchedResultsControllerPostCoreData.delegate = self

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



        self.coreDataCoordinator.getPosts(nameFolder: "SavedPosts")

        self.coreDataCoordinator.performFetchPostCoreData()

        self.tableView.reloadData()

    }



    @objc private func actionBarButtonItemSearch() {

        let alert = UIAlertController(title: nil, message: NSLocalizedString("actionBarButtonItemSearchAlert", tableName: "SavedPostsViewControllerLocalizable", comment: "Напишите имя автора") , preferredStyle: .alert)


        alert.addTextField { textField in

            textField.clearButtonMode = .whileEditing
            self.textFieldSearchAuthor = textField
            }

        let actionSearch = UIAlertAction(title: NSLocalizedString("actionBarButtonItemSearchAlertActionSearch", tableName: "SavedPostsViewControllerLocalizable", comment: "Найти") , style: .default) {action in


            if self.textFieldSearchAuthor?.text != "" {


                self.coreDataCoordinator.fetchedResultsControllerPostCoreData.fetchRequest.predicate = NSPredicate(format: "author contains[c] %@", self.textFieldSearchAuthor!.text!)

                self.coreDataCoordinator.performFetchPostCoreData()

                self.tableView.reloadData()
            }
        }

        let actionCancel = UIAlertAction(title: NSLocalizedString("actionBarButtonItemSearchAlertActionCancel", tableName: "SavedPostsViewControllerLocalizable", comment: "Отмена"), style: .cancel)

        alert.addAction(actionCancel)
        alert.addAction(actionSearch)

        present(alert, animated: true)
    }



    @objc private func actionBarButtonItemCancelSearch() {
        print("actionBarButtonItemCancelSearch")

        self.coreDataCoordinator.getPosts(nameFolder: "SavedPosts")

        self.tableView.reloadData()
    }
}





extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource  {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.coreDataCoordinator.fetchedResultsControllerPostCoreData.sections?[section].numberOfObjects ?? 0
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell

        else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        let postCoreData = self.coreDataCoordinator.fetchedResultsControllerPostCoreData.object(at: indexPath)


        cell.setup(author: postCoreData.author, image: postCoreData.image, likes: postCoreData.likes, text: postCoreData.text, views: postCoreData.views, coreDataCoordinator: self.coreDataCoordinator)
        return cell
        
    }



//    func numberOfSections(in tableView: UITableView) -> Int {
//        self.coreDataCoordinator.fetchResultController.sections?.count ?? 0
//    }




    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: NSLocalizedString("tableViewAction", tableName: "SavedPostsViewControllerLocalizable", comment: "Удалить из сохраненного") ) { [weak self] (uiContextualAction, uiView, completionHandler) in



            let post = self!.coreDataCoordinator.fetchedResultsControllerPostCoreData.object(at: indexPath)

            self!.coreDataCoordinator.deletePost(post: post)

            completionHandler(true)

        }


        let actionConfiguration = UISwipeActionsConfiguration(actions: [action])
        actionConfiguration.performsFirstActionWithFullSwipe = true

        return actionConfiguration
    }
}






extension SavedPostsViewController: NSFetchedResultsControllerDelegate {

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {


        switch type {

        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .move:
            self.tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .automatic)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
        @unknown default:
            self.tableView.reloadData()
        }
    }
}
