//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Mario Cezzare on 16/09/18.
//  Copyright © 2018 Mario Cezzare. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUi(isRecording: false, labelString: "Tap to Record")
        
    }
    
    @IBAction func recordAudio(_ sender: AnyObject) {
        print("record button was pressed")
        configureUi(isRecording: true, labelString: "Recording in Progress")
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string:pathArray.joined(separator: "/"))
        print("File recording at:\(String(describing: filePath))")
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url:filePath!, settings:[:])
        // MARK: After implement the AVAudioRecorderDelegate protocol
        audioRecorder.delegate = self
        // MARK: End of delegation
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: AnyObject) {
        print("stop recording button was pressed")
        configureUi(isRecording: false, labelString: "Tap to Record")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Audio Recorder Delegate - function implemented after implement the AVAudioRecorderDelegate protocol
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
            print("Finished recording")
        } else {
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // MARK: Configure UI for Enabling and Disable Buttons and fix Labels
    func configureUi(isRecording: Bool, labelString: String){
        recordingLabel.text = labelString
        stopRecordingButton.isEnabled = isRecording
        recordButton.isEnabled = !isRecording
    }
   
    // MARK: - Review Suggestion
    /*
     func configureUISuggested(_ isRecording:Bool = false) {
         recordingLabel.text = isRecording ? "Recording in progress": "Tap to Record"
         recordButton.isEnabled = !isRecording
         stopRecordingButton.isEnabled = isRecording
     }
    */
    
}

