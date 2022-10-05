//
//  VideoViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.10.2022.
//

import UIKit
import AVFoundation

protocol VideoViewControllerOutput {
    func playPauseVideo()
}

class VideoViewController: UIViewController {

    private var videos: [String] = []

    private var cells: [VideoViewControllerOutput] = []

    private lazy var tableViewVideo: UITableView = {
        var tableViewVideo = UITableView()
        tableViewVideo.delegate = self
        tableViewVideo.dataSource = self
        tableViewVideo.translatesAutoresizingMaskIntoConstraints = false
        tableViewVideo.register( VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.name)
        tableViewVideo.backgroundColor = .orange
        return tableViewVideo
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableViewVideo)
        


        NSLayoutConstraint.activate([
            self.tableViewVideo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableViewVideo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableViewVideo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableViewVideo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      
        ])
    }
}



extension VideoViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
 //       self.videos.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableViewVideo.dequeueReusableCell(withIdentifier: VideoTableViewCell.name, for: indexPath) as! VideoTableViewCell
        self.cells.append(cell)
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var cell = self.cells[indexPath.row]
        cell.playPauseVideo()

    }


}


