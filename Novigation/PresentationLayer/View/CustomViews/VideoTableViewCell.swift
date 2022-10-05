//
//  VideoTableViewCell.swift
//  Novigation
//
//  Created by Александр Хмыров on 05.10.2022.
//

import UIKit
import AVFoundation

protocol NameClass {
    static var name: String { get }
}

class VideoTableViewCell: UITableViewCell {


 //   var nameVideo: String = "https://www.youtube.com/watch?v=K49ZBgp6b1M"

    private lazy var player: AVPlayer = {
        var player = AVPlayer()


        var url = Bundle.main.url(forResource: "AH1V", withExtension: "mp4")

        guard
            let urlVideo = url
        else {
            return AVPlayer()
        }
        player = AVPlayer(url: urlVideo)
        return player
    }()


    private lazy var playerLayer: AVPlayerLayer = {
        var playerLayer = AVPlayerLayer(player: self.player)
        return playerLayer
    }()

    private lazy var videoPlayerView: UIView = {
        var videoPlayerView = UIView()
        videoPlayerView.backgroundColor = .black
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerView.layer.addSublayer(playerLayer)
        return videoPlayerView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.videoPlayerView)

        self.playerLayer.frame = self.videoPlayerView.bounds

        self.player.play()


        NSLayoutConstraint.activate([
            self.videoPlayerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.videoPlayerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            self.videoPlayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            self.videoPlayerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),

        ])

        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}

extension VideoTableViewCell: NameClass {
    static var name: String {
        return String(describing: self)
    }
}
