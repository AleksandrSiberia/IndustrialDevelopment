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

    private var play: Bool = false

    private var nameVideo: String = "Record"

    private lazy var player: AVPlayer = {
        var player =  AVPlayer()

        var url = Bundle.main.url(forResource: self.nameVideo, withExtension: "mp4" )

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


    override func layoutSubviews() {
        super.layoutSubviews()

        self.playerLayer.frame = self.videoPlayerView.bounds
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


extension VideoTableViewCell: VideoViewControllerOutput {
    func playPauseVideo() {

        guard self.play == false
        else  {
            self.player.pause()
            self.play = false
            return
        }
        self.player.play()
        self.play = true
    }
}


