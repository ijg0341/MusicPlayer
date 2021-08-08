//
//  MusicDetailViewController.swift
//  MusicPlayer
//
//  Created by Jingyu Lim on 2021/08/02.
//

import UIKit
import MediaPlayer

class MusicDetailViewController: UIViewController {
    
    let music = MusicDataStore.shared.seletedMusic
    let player = MusicDataStore.shared.Player!
    let MAX_VOLUME: Float = 10.0
    var progressTimer: Timer?
    
    let albumImageView = UIImageView()
    var playerWrapView = UIStackView()
    var progressView = UISlider()
    var timeLabelWrapView = UIStackView()
    var currentTimeLabel = UILabel()
    var endTimeLabel = UILabel()
    var buttonWrapView = UIStackView()
    var playButton = UIButton()
    var pauseButton = UIButton()
    var stopButton = UIButton()
    var sliderWrapView = UIStackView()
    var volumeLable = UILabel()
    var slider = MPVolumeView()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
        self.title = "\(music!.title ?? "") - \(music!.artist ?? "")"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        endTimeLabel.text = convertNSTimerInterval2String(player.nowPlayingItem!.playbackDuration)
        currentTimeLabel.text = convertNSTimerInterval2String(0)
        progressView.maximumValue = Float(player.nowPlayingItem!.playbackDuration)
//        slider.maximumValue = MAX_VOLUME
//        slider.value = MPVolumeView.
        progressView.value = 0
        self.play(nil)
//        print(player.currentPlaybackRate, player.currentPlaybackTime, player.nowPlayingItem?.playbackDuration)
    }
    
    @objc func updatePlayTime(){
        currentTimeLabel.text = convertNSTimerInterval2String(player.currentPlaybackTime)
        progressView.value = Float(player.currentPlaybackTime)
    }
    
    @objc func play(_ sender: UIButton?){
        setPlayButtons(play: false, pause: true, stop: true)
        player.play()
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updatePlayTime), userInfo: nil, repeats: true)
    }
    
    @objc func pause(_ sender: UIButton){
        player.pause()
        setPlayButtons(play: true, pause: false, stop: true)
    }
    
    @objc func stop(_ sender: UIButton){
        player.stop()
        player.currentPlaybackTime = 0
        currentTimeLabel.text = convertNSTimerInterval2String(0)
        setPlayButtons(play: true, pause: false, stop: false)
        progressTimer?.invalidate()
        progressView.value = 0
    }
    
    @objc func progressBraChanged(_ sender: UISlider){
        player.currentPlaybackTime = Double(sender.value)
    }
    
    func setPlayButtons(play: Bool, pause: Bool, stop: Bool){
        playButton.isEnabled = play
        pauseButton.isEnabled = pause
        stopButton.isEnabled = stop
    }
    
    func convertNSTimerInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    
    func viewInit(){
        view.backgroundColor = .systemBackground
        view.tintColor = .systemRed
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        playButton.setTitleColor(.systemBlue, for: .normal)
        playButton.setTitleColor(.systemGray, for: .disabled)
        playButton.addTarget(self, action: #selector(play(_:)), for: .touchUpInside)
        pauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
        pauseButton.setTitleColor(.systemBlue, for: .normal)
        pauseButton.setTitleColor(.systemGray, for: .disabled)
        pauseButton.addTarget(self, action: #selector(pause(_:)), for: .touchUpInside)
        stopButton.setImage(UIImage(systemName: "stop"), for: .normal)
        stopButton.setTitleColor(.systemBlue, for: .normal)
        stopButton.setTitleColor(.systemGray, for: .disabled)
        stopButton.addTarget(self, action: #selector(stop(_:)), for: .touchUpInside)
        volumeLable.text = "Volumn"
        
        view.addSubview(playerWrapView)
        playerWrapView.axis = .vertical
        playerWrapView.spacing = 30
        playerWrapView.distribution = .fill
        
        playerWrapView.addArrangedSubview(albumImageView)
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1).isActive = true
        albumImageView.image = music?.artwork?.image(at: CGSize(width: 200, height: 20))
        playerWrapView.addArrangedSubview(progressView)
        progressView.isContinuous = false
        progressView.thumbTintColor = .systemRed
        progressView.addTarget(self, action: #selector(progressBraChanged(_:)), for: .valueChanged)
        
        
        playerWrapView.addArrangedSubview(timeLabelWrapView)
        timeLabelWrapView.addArrangedSubview(currentTimeLabel)
        timeLabelWrapView.addArrangedSubview(endTimeLabel)
        timeLabelWrapView.axis = .horizontal
        timeLabelWrapView.distribution = .equalSpacing
        
        playerWrapView.addArrangedSubview(buttonWrapView)
        buttonWrapView.addArrangedSubview(playButton)
        buttonWrapView.addArrangedSubview(pauseButton)
        buttonWrapView.addArrangedSubview(stopButton)
        buttonWrapView.axis = .horizontal
        buttonWrapView.distribution = .fillEqually
        
        playerWrapView.addArrangedSubview(sliderWrapView)
        sliderWrapView.addArrangedSubview(volumeLable)
        sliderWrapView.addArrangedSubview(slider)
        sliderWrapView.axis = .horizontal
        sliderWrapView.distribution = .fill
        sliderWrapView.spacing = 10
        
        let safeArea = view.safeAreaLayoutGuide
        playerWrapView.translatesAutoresizingMaskIntoConstraints = false
        playerWrapView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        playerWrapView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 30).isActive = true
        playerWrapView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -30).isActive = true
            
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
