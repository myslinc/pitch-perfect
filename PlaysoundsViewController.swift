//
//  PlaysoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Yepes on 3/29/15.
//  Copyright (c) 2015 Michael Yepes. All rights reserved.
//

import UIKit
import AVFoundation
class PlaysoundsViewController: UIViewController {
    
    
    var audioPlayer:AVAudioPlayer!
   
    var receivedAudio: RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    //global variables
    
    var audioFile:AVAudioFile!
    override func viewDidLoad() {
        //start out with hidden stop button
       
        super.viewDidLoad()
        //samele add to see if i have the right code//
       

    audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            audioPlayer.enableRate = true
        
            audioEngine = AVAudioEngine()
            audioFile = AVAudioFile (forReading: receivedAudio.filePathUrl, error: nil)
        
    
    }
    
    //Plays the code slow
    @IBAction func playAudioSlow(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 0.50
        audioPlayer.play()
    }
    //Plays the code fast
    @IBAction func playAudioFast(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.rate = 2.0
        audioPlayer.play()

    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithVariablePitch (1000)
        
        
    }
    func playAudioWithVariablePitch(pitch:Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode,format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
    }

    @IBAction func playDarthvaderAudio(sender: UIButton) {
               playAudioWithVariablePitch (-1000)
        
    }
    @IBAction func playAudioStop(sender: UIButton) {
        audioPlayer.stop()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
