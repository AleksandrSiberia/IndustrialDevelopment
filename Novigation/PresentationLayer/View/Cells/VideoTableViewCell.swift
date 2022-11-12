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

    private var videoViewController: VideoViewController?

    private var videoImageView: UIImageView = {
        var videoImageView = UIImageView()
        videoImageView.translatesAutoresizingMaskIntoConstraints = false
        videoImageView.contentMode = .scaleAspectFit
        return videoImageView
    }()

    private var player: AVPlayer?

    private var playerLayer: AVPlayerLayer?

    private lazy var videoPlayerView: UIView = {
        var videoPlayerView = UIView()
        videoPlayerView.backgroundColor = .black
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerView.layer.cornerRadius = 20
        videoPlayerView.layer.masksToBounds = true
        return videoPlayerView
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.videoPlayerView.addSubview(self.videoImageView)
        self.contentView.addSubview(self.videoPlayerView)


        NSLayoutConstraint.activate([
            self.videoPlayerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.videoPlayerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            self.videoPlayerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            self.videoPlayerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),

            self.videoImageView.centerYAnchor.constraint(equalTo: self.videoPlayerView.centerYAnchor),
            self.videoImageView.widthAnchor.constraint(equalTo: self.videoPlayerView.widthAnchor),
            self.videoImageView.heightAnchor
                .constraint(equalTo: self.videoPlayerView.widthAnchor)
        ])
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer!.frame = self.videoPlayerView.bounds
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    func setupVideoTableViewCell(nameVideo: String, nameFoto: String, videoViewController: VideoViewController) {

        self.videoImageView.image = UIImage(named: nameFoto)

        self.videoViewController = videoViewController

        self.player = AVPlayer(url: Bundle.main.url(forResource:  nameVideo, withExtension: "mp4")!)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.videoPlayerView.layer.addSublayer(self.playerLayer!)
    }
}


extension VideoTableViewCell: NameClass {
    static var name: String {
        return String(describing: self)
    }
}


extension VideoTableViewCell: VideoViewControllerOutput {

    func stopVideo() {
        self.player?.pause()
    }

    func playPauseVideo(videoViewController: VideoViewController) {

        guard
            self.play == false
        else  {
            self.player!.pause()
            self.play = false
            return
        }
        self.player!.play()
        self.play = true
        self.videoImageView.isHidden = true
    }


}
