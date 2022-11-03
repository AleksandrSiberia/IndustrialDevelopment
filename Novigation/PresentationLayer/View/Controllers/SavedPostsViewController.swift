//
//  SavedPostsViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 04.11.2022.
//

import UIKit

class SavedPostsViewController: UIViewController {



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

}



extension SavedPostsViewController: UITableViewDelegate, UITableViewDataSource  {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return CoreDataCoordinator.shared.savedPosts.count
    }




    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell

        else { let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        if  CoreDataCoordinator.shared.savedPosts.isEmpty == true {
             assertionFailure(CustomErrorNovigation.noPost.rawValue)
        }

        let indexPathRow = indexPath.row

        let postCoreData = CoreDataCoordinator.shared.savedPosts[indexPathRow]

        cell.setup(author: postCoreData.author, image: postCoreData.image, likes: postCoreData.likes, text: postCoreData.text, views: postCoreData.views)
        return cell
        
    }



    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {


            let post = CoreDataCoordinator.shared.savedPosts[indexPath.row]
            CoreDataCoordinator.shared.deletePost(post: post)
            self.tableView.reloadData()
    }
    
}


