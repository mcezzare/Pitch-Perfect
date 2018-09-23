//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Mario Cezzare on 22/09/18.
//  Copyright © 2018 Mario Cezzare. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, highPitch, lowPitch, echo, reverb
    }
    
    
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound button pressed")
        var optionPressed = ""
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
            optionPressed = "slow"
        case .fast:
            playSound(rate: 1.5)
            optionPressed = "fast"
        case .highPitch:
            playSound(pitch: 1000)
            optionPressed = "high pitch"
        case .lowPitch:
            playSound(pitch: -1000)
            optionPressed = "low pitch"
        case .echo:
            playSound(echo: true)
            optionPressed = "echo"
        case .reverb:
            playSound(reverb: true)
            optionPressed = "reverb"
        }
        print("Playing in \(optionPressed)")
        
        configureUI(.playing)
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop audio button pressed")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
