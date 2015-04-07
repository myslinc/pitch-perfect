//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Michael Yepes on 3/13/15.
//  Copyright (c) 2015 Michael Yepes. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tapRecord: UILabel!

    //Declared Globally
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //hide the stop button
        stopButton.hidden = true
        recordButton.enabled = true
         tapRecord.hidden = false
    }
    

    @IBAction func recordAudio(sender: UIButton) {
    
        stopButton.hidden = false
        recordingInProgress.hidden = false
        recordButton.hidden = false
        tapRecord.hidden = true
        // so the code unhides the record text when the mic icon is pressed
        
        //TODO: Record the user voice
        
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String

        var currentDateTime = NSDate()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        var pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)// this is the debug if errors
        
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        
        audioRecorder.meteringEnabled = true;
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
  
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
      
        if(flag){
        //TO DO  save the recored audio
            
            
            var filePathUrl: String
            var title: String
           
        recordedAudio = RecordedAudio()
            
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title  = recorder.url.lastPathComponent
            
        //TO DO Move the next scene aka perform segue
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            
            println("Recording was not succesful")
            recordButton.enabled = true
            stopButton.hidden = true
            tapRecord.hidden = false
        }
        
    }
    
        override func prepareForSegue (segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "stopRecording") {
                let playSoundsVC:PlaysoundsViewController = segue.destinationViewController as! PlaysoundsViewController
                let data = sender as! RecordedAudio
                playSoundsVC.receivedAudio = data
            
        }
    
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        //code hides the record txt when it is pressed
        recordingInProgress.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
    
}

