//
//  recordYourVoiceViewController.swift
//  makingApp
//
//  Created by 水谷七渡 on 2018/12/20.
//  Copyright © 2018 Nanato Mizutani. All rights reserved.
//
//TODO:ボタンを押した時に録音する機能をつける
//TODO:保存する方法
//TODO:データをHomePageに飛ばす
//TODO:実機テスト　録音できるかどうかを

import UIKit
import AVFoundation

class recordYourVoiceViewController: UIViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var isRecording = false
    var isPlaying = false
    
    @IBOutlet weak var recordGoalLabel: UILabel!
    @IBOutlet weak var waitLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
 @IBAction func record(){
    if !isRecording {
        
        let session = AVAudioSession.sharedInstance()
        try! AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
        try! session.setActive(true)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 2,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try! AVAudioRecorder(url: getURL(), settings: settings)
        audioRecorder.delegate = self
        audioRecorder.record()
        
        isRecording = true
        
        waitLabel.text = "録音中"
        recordButton.setTitle("STOP", for: .normal)
        playButton.isEnabled = false
        
    }else{
        
        audioRecorder.stop()
        isRecording = false
        
        waitLabel.text = "待機中"
        recordButton.setTitle("RECORD", for: .normal)
        playButton.isEnabled = true
        
    }
    }
    func getURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let url = docsDirect.appendingPathComponent("recording.m4a")
        return url
    }
    
    @IBAction func play(){
        if !isPlaying {
            
            audioPlayer = try! AVAudioPlayer(contentsOf: getURL())
            audioPlayer.delegate = self
            audioPlayer.play()
            
            isPlaying = true
            
            waitLabel.text = "再生中"
            playButton.setTitle("STOP", for: .normal)
            recordButton.isEnabled = false
            
        }else{
            
            audioPlayer.stop()
            isPlaying = false
            
            waitLabel.text = "待機中"
            playButton.setTitle("PLAY", for: .normal)
            recordButton.isEnabled = true
            
        }
    }
            
            
            
        }
        
        
        
        

    
    

