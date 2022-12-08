//
//  AudioViewController.swift
//  Novigation
//
//  Created by Александр Хмыров on 04.10.2022.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController {

    private var play: Bool = false

    private var tracks: [String] = ["Tinlicker_Robert_Miles_-_Children", "Paul_Van_Dyk_Aly_Fila_-_SHINE_Ibiza_Anthem", "Ben_Gold_-_Xtravaganza", "Armin_van_Buuren_Wrabel_-_Feel_Again", "Armin_van_Buuren_-_In_And_Out_Of_Love"]

    private var numberTrack: Int = 0

    private lazy var player: AVPlayer = {
        var player = AVPlayer()
        var url = Bundle.main.url(forResource: self.tracks[self.numberTrack], withExtension: "mp3")
        guard
            let urlAudio = url
        else {
            return AVPlayer()
        }
        player = AVPlayer(url: urlAudio)
        return player
    }()


    private lazy var playerLayer: AVPlayerLayer = {
        var playerLayer = AVPlayerLayer(player: self.player)
        return playerLayer
    }()

    private lazy var audioPlayerView: UIView = {
        var audioPlayerView = UIView()
        audioPlayerView.backgroundColor = .black
        audioPlayerView.translatesAutoresizingMaskIntoConstraints = false
        audioPlayerView.layer.addSublayer(playerLayer)
        return audioPlayerView
    }()

    private lazy var labelTrackName: UILabel = {
        var labelTrackName = UILabel()
        labelTrackName.text = self.tracks[self.numberTrack]
        labelTrackName.translatesAutoresizingMaskIntoConstraints = false
        labelTrackName.textColor = .white
        return labelTrackName
    }()

    private lazy var buttonPlayPauseAudio: UIButton = {
        let action = UIAction { action in
            guard self.play == false
            else  {
                self.player.pause()
                self.play = false
                return
            }
            self.player.play()
            self.play = true
        }
        var buttonPlayPauseAudio = UIButton(primaryAction: action)
        buttonPlayPauseAudio.setTitle( "buttonPlayPauseAudio".audioViewControllerLocalizable , for: .normal)
        buttonPlayPauseAudio.translatesAutoresizingMaskIntoConstraints = false
        buttonPlayPauseAudio.backgroundColor = .white
        buttonPlayPauseAudio.layer.cornerRadius = 12
        buttonPlayPauseAudio.setTitleColor(.darkGray, for: .normal)
        return buttonPlayPauseAudio
    }()

    private lazy var buttonStopPlay: UIButton = {
        let action = UIAction { _ in
            self.player.seek(to: CMTime.zero)
            self.player.pause()
            self.play = false
        }
        var buttonStopPlay = UIButton(primaryAction: action)
        buttonStopPlay.setTitle( "buttonStopPlay".audioViewControllerLocalizable, for: .normal)
        buttonStopPlay.backgroundColor = .white
        buttonStopPlay.layer.cornerRadius = 12
        buttonStopPlay.setTitleColor(.darkGray, for: .normal)
        buttonStopPlay.translatesAutoresizingMaskIntoConstraints = false
        return buttonStopPlay
    }()

    private lazy var buttonTrackBack: UIButton = {
        var action = UIAction { _ in
            if self.numberTrack > 0 {
                self.player.pause()
                var url = Bundle.main.url(forResource: self.tracks[self.numberTrack - 1], withExtension: "mp3" )
                self.numberTrack -= 1
                self.player = AVPlayer(url: url!)
                self.player.play()
                self.labelTrackName.text = self.tracks[self.numberTrack]
            }
            else { return }
        }
        var buttonTrackBack = UIButton(primaryAction: action)
        buttonTrackBack.setTitle("buttonTrackBack".audioViewControllerLocalizable, for: .normal)
        buttonTrackBack.backgroundColor = .white
        buttonTrackBack.layer.cornerRadius = 12
        buttonTrackBack.setTitleColor(.darkGray, for: .normal)
        buttonTrackBack.translatesAutoresizingMaskIntoConstraints = false
        return buttonTrackBack
    }()

    private lazy var buttonTrackForward: UIButton = {
        var action = UIAction { _ in

            if self.tracks.count - 1 > self.numberTrack {
                self.player.pause()
                var url = Bundle.main.url(forResource: self.tracks[self.numberTrack + 1], withExtension: "mp3" )
                self.numberTrack += 1
                self.player = AVPlayer(url: url!)
                self.player.play()
                self.labelTrackName.text = self.tracks[self.numberTrack]
            }
            else { return }
        }
        var buttonTrackForward = UIButton(primaryAction: action)
        buttonTrackForward.setTitle("buttonTrackForward".audioViewControllerLocalizable, for: .normal)
        buttonTrackForward.backgroundColor = .white
        buttonTrackForward.layer.cornerRadius = 12
        buttonTrackForward.setTitleColor(.darkGray, for: .normal)
        buttonTrackForward.translatesAutoresizingMaskIntoConstraints = false
        return buttonTrackForward
    }()



    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.audioPlayerView)
        self.audioPlayerView.addSubview(self.buttonPlayPauseAudio)
        self.audioPlayerView.addSubview(self.buttonStopPlay)
        self.audioPlayerView.addSubview(self.labelTrackName)
        self.audioPlayerView.addSubview(self.buttonTrackBack)
        self.audioPlayerView.addSubview(self.buttonTrackForward)

        NSLayoutConstraint.activate([
            self.audioPlayerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.audioPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.audioPlayerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.audioPlayerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.buttonPlayPauseAudio.topAnchor.constraint(equalTo: self.buttonTrackBack.bottomAnchor, constant: 20),
            self.buttonPlayPauseAudio.leadingAnchor.constraint(equalTo: self.audioPlayerView.leadingAnchor, constant: 20),

            self.buttonStopPlay.centerYAnchor.constraint(equalTo: self.buttonPlayPauseAudio.centerYAnchor),
            self.buttonStopPlay.trailingAnchor.constraint(equalTo: self.audioPlayerView.trailingAnchor, constant: -20),


            self.buttonTrackBack.topAnchor.constraint(equalTo: self.labelTrackName.bottomAnchor, constant: 40),
            self.buttonTrackBack.centerXAnchor.constraint(equalTo: self.audioPlayerView.centerXAnchor, constant: -30),

            self.buttonTrackForward.leadingAnchor.constraint(equalTo: self.buttonTrackBack.trailingAnchor, constant: 12),
            self.buttonTrackForward.centerYAnchor.constraint(equalTo: self.buttonTrackBack.centerYAnchor),

            self.labelTrackName.topAnchor.constraint(equalTo: self.audioPlayerView.topAnchor, constant: 50),
            self.labelTrackName.centerXAnchor.constraint(equalTo: self.audioPlayerView.centerXAnchor)


        ])
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.playerLayer.frame = self.audioPlayerView.bounds
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.player.pause()
    }

}

extension String {
    var audioViewControllerLocalizable: String {
       return NSLocalizedString(self, tableName: "AudioViewControllerLocalizable", comment: "")
    }
}
